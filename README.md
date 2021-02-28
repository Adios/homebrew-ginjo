# Homebrew Ginjo

Customized formulae:

- **To compress "*WebP Lossless*" in TIFF images**:
  - `libtiff-more.rb`: enable WebP and ZSTD compression.
    - `homebrew-core/libtiff` needs to be shadowed explicitly. See below.

- The rest are just for reducing dependencies:
  - `vips.rb`: without X11
  - `imagemagick-ginjo.rb`: without X11
  - `graphicsmagick-ginjo.rb`: without X11
    - `jasper-nogl.rb`: without OpenGL

## Shadow `homebrew-core/libtiff`

Manully make `homebrew-core/libtiff` into a ***keg_only*** brew. So I don't have to maintain all the formulae that depend on `homebrew-core/libtiff`.

1. `brew edit libtiff`
2. put a `keg_only "Let libtiff-more handle"` line in the class definition

## Verify WebP lossless compression

- *graphicsmagick*:
  - `gm convert -verbose test.png -compress webp -define tiff:webp-lossless=true -quality 100 test.webp.tif`

- *vips*:
  - `vips tiffsave in.png test.webp.tif --compression webp --Q 100 --tile --lossless --vips-progress`

- *imagemagick*:
  - `magick convert` doesn't support WebP compression.
  - `magick compare` can read WebP compressed TIFF (`libtiff-more`).

