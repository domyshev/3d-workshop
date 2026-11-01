"""Exercise native/fallback launcher selection without requiring OpenSCAD."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

EXPORTER = Path(__file__).resolve().parents[1] / "export_stl"


class ExportLauncherTests(unittest.TestCase):
    def run_export(self, platform, mode, binary_format="script", rosetta=True):
        with tempfile.TemporaryDirectory(prefix="export-launcher-") as directory:
            root = Path(directory)
            tools = root / "tools"
            tools.mkdir()
            source = root / "source with spaces.scad"
            source.write_text("cube(1);\n")
            log = root / "calls.jsonl"
            fixtures = {
                "uname": "import os; print(os.environ['TEST_PLATFORM'])\n",
                "file": "import os; print(os.environ['TEST_FORMAT'])\n",
                "arch": """import os, sys
if sys.argv[2] == '/usr/bin/true' and os.environ['TEST_ROSETTA'] == 'no': sys.exit(1)
assert sys.argv[1] == '-x86_64'
env = dict(os.environ, TEST_ARCH='x86_64')
os.execvpe(sys.argv[2], sys.argv[2:], env)
""",
                "openscad": """import json, os, sys
from pathlib import Path
args = sys.argv[1:]
architecture = os.environ.get('TEST_ARCH', 'native')
with open(os.environ['TEST_LOG'], 'a') as stream:
    stream.write(json.dumps(dict(args=args, architecture=architecture)) + '\\n')
mode = os.environ['TEST_MODE']
if mode == 'broken' or (mode == 'fallback' and architecture == 'native'):
    sys.exit(134)
if args == ['--version']:
    print('OpenSCAD fixture')
else:
    Path(args[args.index('-o') + 1]).write_bytes(b'fixture export')
""",
            }
            for name, body in fixtures.items():
                executable = tools / name
                executable.write_text(f"#!{sys.executable}\n" + body)
                executable.chmod(0o755)
            env = dict(os.environ, PATH=str(tools) + os.pathsep + os.environ["PATH"],
                       TEST_PLATFORM=platform, TEST_MODE=mode, TEST_LOG=str(log),
                       TEST_FORMAT=binary_format, TEST_ROSETTA="yes" if rosetta else "no")
            env.pop("TEST_ARCH", None)
            result = subprocess.run(
                ["bash", str(EXPORTER), "sample", "--source", str(source),
                 "--output-dir", str(root / "out"), "--", "-D", 'part="rim bow"'],
                env=env, cwd=root, text=True, capture_output=True,
            )
            calls = [json.loads(line) for line in log.read_text().splitlines()] if log.exists() else []
            return result, calls, len(list((root / "out").glob("*.stl")))

    def test_macos_arm_only_keeps_native_without_probe(self):
        result, calls, count = self.run_export("Darwin", "native", "Mach-O 64-bit executable arm64")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual([v["architecture"] for v in calls], ["native"])
        self.assertIn('part="rim bow"', calls[-1]["args"])
        self.assertTrue(calls[-1]["args"][-1].endswith("source with spaces.scad"))
        self.assertEqual(count, 1)

    def test_universal_build_selects_intel_without_native_probe(self):
        result, calls, count = self.run_export(
            "Darwin", "fallback", "Mach-O universal binary: x86_64 arm64")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual([v["architecture"] for v in calls], ["x86_64"])
        self.assertNotIn("--version", calls[0]["args"])
        self.assertIn('part="rim bow"', calls[-1]["args"])
        self.assertEqual(count, 1)

    def test_macos_wrapper_is_not_forced_through_arch(self):
        result, calls, count = self.run_export("Darwin", "native", "POSIX shell script")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual([v["architecture"] for v in calls], ["native"])
        self.assertEqual(count, 1)

    def test_non_macos_keeps_direct_execution(self):
        result, calls, count = self.run_export("Linux", "native", "Mach-O universal binary: x86_64 arm64")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(len(calls), 1)
        self.assertNotEqual(calls[0]["args"], ["--version"])
        self.assertEqual(calls[0]["architecture"], "native")
        self.assertEqual(count, 1)

    def test_missing_compatibility_never_starts_openscad(self):
        result, calls, count = self.run_export(
            "Darwin", "broken", "Mach-O universal binary: x86_64 arm64", rosetta=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(calls, [])
        self.assertIn("compatibility support", result.stderr)
        self.assertEqual(count, 0)


if __name__ == "__main__":
    unittest.main()
