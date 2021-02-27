# Homebrew Ginjo

My formulae.

- `graphicsmagick-ginjo.rb`: for tiff WebP lossless compression.
  - `libtiff-more.rb`: needed to enable WebP and ZSTD at compile time.
  - `jasper-nogl.rb`: remove OpenGL needs.
  - *requires* `homebrew-core/libtiff` to be shadowed.

## Manually ___shadow___ `homebrew-core/libtiff`

1. `brew edit libtiff`
2. put a `keg_only "Let libtiff-more handle"` line in the class definition

## Verify `graphicsmagick-ginjo.rb` work

    gm convert -verbose test.png -compress webp -define tiff:webp-lossless=true -quality 100 test.webp.tif

## How do I install these formulae?

Just `brew install <formula>`. This is the default tap for Homebrew and is installed by default.

## More Documentation, Troubleshooting, Contributing, Security, Community, Donations, License and Sponsors

See these sections in [Homebrew/brew's README](https://github.com/Homebrew/brew#homebrew).
