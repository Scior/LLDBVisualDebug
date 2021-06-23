# LLDBVisualDebug

## Before Debugging

Place `.lldbinit` or `.lldbinit-Xcode` in your home directory to import Python scripts.

(Example file: `.lldbinit.sample`)

## Usage

### saveimage

https://user-images.githubusercontent.com/9279273/123053715-255fde00-d43f-11eb-97c6-3287f3a7251c.mov

Captures contents in the specific `UIView` and save them as a PNG file.

Before calling `saveimage`, you have to call `loadext` to load Swift extensions.

```sh
(lldb) loadext
(lldb) saveimage imageView /tmp/alpaca.png
```

### overlayimage

https://user-images.githubusercontent.com/9279273/123053836-44f70680-d43f-11eb-9e76-76b494ece077.mov

Create a image view for debugging from a local image file and add it to the superview of the forcusing `UIView`.

```sh
(lldb) loadext
(lldb) overlayimage imageView /tmp/alpaca.png
```

## Sample Project

`ImageBuffer` and `DebugOverlayView` are placed in the `LLDBVisualDebugSample` directory.
