#!/usr/bin/env python3

import pathlib
import os

root = pathlib.Path(__file__).parent.parent
example_root = root.parent / 'cinema' / 'example'

# build example apk first so that the ApiSummarizer can find all referenced classes
cmd = f'cd {example_root} && fvm flutter build apk'
os.system(cmd)

# build jnigen after that
cmd = f'fvm dart run jnigen --config {root}/jnigen.yaml'
os.system(cmd)