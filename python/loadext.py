#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os


@lldb.command("loadext")
def load(debugger, command, result, dict):
    path = os.path.join(os.path.dirname(__file__), 'swift/DebugExtensions.swift')
    with open(path, 'r') as f:
        common.evaluate(f.read())
