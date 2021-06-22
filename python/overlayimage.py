#!/usr/bin/env python3

import lldb
import lldbcommon as common
import os


@lldb.command("overlayimage")
def overlay_image(debugger, arguments, result, dict):
    view, path = arguments.split()

    # 引数がUIViewかチェック
    is_ui_view = common.evaluate('%s is UIView' % view).GetObjectDescription().rstrip()
    if is_ui_view != 'true':
        print('The first argument must inherit UIView')
        return

    with open(path, 'rb') as f:
        data = f.read()

    # メモリ領域の確保とアドレスの取得
    buf_name = common.generateVarName()
    common.evaluate('let $%s = ImageBuffer(size: %s)' % (buf_name, len(data)))
    address_str = common.evaluate('$%s.pointer' % buf_name).GetObjectDescription().split()[1]
    address = int(address_str, 16)

    # 領域に書き込み
    process = lldb.debugger.GetSelectedTarget().GetProcess()
    error = lldb.SBError()
    size = process.WriteMemory(address, data, error)
    if not error.Success():
        print(error)
    elif size != len(data):
        print('data is corrupted')
    else:
        view_name = common.generateVarName()
        common.evaluate('let $%s = DebugOverlayView(frame: %s.frame)' % (view_name, view))
        common.evaluate('$%s.set(data: $%s.getData())' % (view_name, buf_name))
        common.evaluate('%s.superview?.addSubview($%s)' % (view, view_name))
        print("The image has been loaded from: %s" % path)
