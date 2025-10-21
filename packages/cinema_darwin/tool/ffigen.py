#!/usr/bin/env python3

import pathlib
import os

root = pathlib.Path(__file__).parent.parent

cmd = f'fvm dart run ffigen --config {root}/ffigen.yaml'
os.system(cmd)