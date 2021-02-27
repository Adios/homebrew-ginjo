class GraphicsmagickGinjo < Formula
  desc "Image processing tools collection (support lossless WebP compression in TIFF)"
  homepage "http://www.graphicsmagick.org/"
  url "https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.36/GraphicsMagick-1.3.36.tar.xz"
  sha256 "5d5b3fde759cdfc307aaf21df9ebd8c752e3f088bb051dd5df8aac7ba7338f46"
  head "http://hg.code.sf.net/p/graphicsmagick/code", using: :hg

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "adios/ginjo/jasper-nogl"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "adios/ginjo/libtiff-more"
  depends_on "libtool"
  depends_on "little-cms2"
  depends_on "webp"

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  skip_clean :la

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-openmp
      --disable-static
      --enable-shared
      --with-modules
      --with-quantum-depth=16
      --without-lzma
      --without-x
      --without-gslib
      --with-gs-font-dir=#{HOMEBREW_PREFIX}/share/ghostscript/fonts
      --without-wmf
    ]

    # versioned stuff in main tree is pointless for us
    inreplace "configure", "${PACKAGE_NAME}-${PACKAGE_VERSION}", "${PACKAGE_NAME}"
    system "./configure", *args
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.png")
    assert_match "PNG 8x8+0+0", shell_output("#{bin}/gm identify #{fixture}")
  end
end
