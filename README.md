# GIF test suite

## Overview

A GIF test suite for testing decoders. It includes GIFs with various different features such as animation, looping, frame disposal, interlacing, transparency.

## Usage

### Test suite
See [gifsuite.html](gifsuite.html). GIFs can be found in [gifs/](gifs/). Individual frames of each GIF can be found in [gifs/frames/](gifs/frames/).

### Generating

The test GIFs are generated using [ImageMagick](https://imagemagick.org/index.php). Run [generate_gifs.sh](generate_gifs.sh) from the project root directory.

The ImageMagick `convert` and `mogrify` commands can be overridden using the `CONVERT_COMMAND` and `MOGRIFY_COMMAND` environment variables.

**NOTE**: Until 2020-09-28, ImageMagick had a [bug](https://github.com/ImageMagick/ImageMagick/issues/2560) that prevented it from outputting interlaced GIFs. The [animated_loop_interlaced.gif](gifs/animated_loop_interlaced.gif) in this repo has been generated using a version built after this date, so it is correctly interlaced. You may find that the version of ImageMagick provided by your OS package manager does not yet include this fix.

## Attribution

Forked from [SerenityOS LibGfx](http://serenityos.org/).
