#!/usr/bin/env python3
"""Check the preserved Sarepta reference and release files against SHA-256."""
import argparse,hashlib
from pathlib import Path

def verify(manifest):
    errors=[];count=0
    for line in manifest.read_text().splitlines():
        if not line.strip():continue
        expected,name=line.split('  ',1);path=(manifest.parent/name).resolve()
        if not path.is_relative_to(manifest.parent.resolve()):errors.append('Unsafe path: '+name);continue
        if not path.is_file():errors.append('Missing: '+name);continue
        actual=hashlib.sha256(path.read_bytes()).hexdigest();count+=1
        if actual!=expected:errors.append('Changed: '+name)
    for message in errors:print(message)
    print(f'{manifest.name}: {count} files checked; {len(errors)} errors')
    return not errors

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('manifests',nargs='*',type=Path);a=ap.parse_args()
    root=Path(__file__).resolve().parent.parent
    manifests=a.manifests or [root/'reference/SHA256SUMS',root/'releases/SHA256SUMS']
    return 0 if all([verify(m) for m in manifests]) else 1
if __name__=='__main__':raise SystemExit(main())
