# LLDBVisualDebug

## Before Debugging

Place `.lldbinit` or `.lldbinit-Xcode` in your home directory to import Python scripts.

(Example file: `.lldbinit.sample`)

## Usage

### saveimage

Captures contents in the specific `UIView` and save them as a PNG file.

Before calling `saveimage`, you have to call `loadext` to load Swift extensions.

```sh
(lldb) loadext
(lldb) saveimage imageView /tmp/alpaca.png
```

### overlayimage

Create a image view for debugging from a local image file and add it to the superview of the forcusing `UIView`.

```sh
(lldb) loadext
(lldb) overlayimage imageView /tmp/alpaca.png
```

## Sample Project

`ImageBuffer` and `DebugOverlayView` are placed in the `LLDBVisualDebugSample` directory.