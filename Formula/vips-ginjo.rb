class VipsGinjo < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.10.5/vips-8.10.5.tar.gz"
  sha256 "a4eef2f5334ab6dbf133cd3c6d6394d5bdb3e76d5ea4d578b02e1bc3d9e1cfd8"
  license "LGPL-2.1-or-later"
  revision 2

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "pkg-config" => :build
  depends_on "expat"
  depends_on "fftw"
  depends_on "fontconfig"
  depends_on "gettext"
  depends_on "glib"
  depends_on "libexif"
  depends_on "libheif"
  depends_on "libpng"
  depends_on "libspng"
  depends_on "adios/ginjo/libtiff-more"
  depends_on "little-cms2"
  depends_on "mozjpeg"
  depends_on "openexr"
  depends_on "orc"
  depends_on "webp"

  uses_from_macos "zlib"

  def install
    # mozjpeg needs to appear before libjpeg, otherwise it's not used
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["mozjpeg"].opt_lib/"pkgconfig"

    args = %W[
      --disable-dependency-tracking
      --disable-introspection
      --prefix=#{prefix}
      --without-cfitsio
      --without-giflib
      --without-gsf
      --without-imagequant
      --without-magick
      --without-matio
      --without-nifti
      --without-openslide
      --without-pangoft2
      --without-pdfium
      --without-poppler
      --without-rsvg
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp

    # --trellis-quant requires mozjpeg, vips warns if it's not present
    cmd = "#{bin}/vips jpegsave #{test_fixtures("test.png")} #{testpath}/test.jpg --trellis-quant 2>&1"
    assert_equal "", shell_output(cmd)

    # [palette] requires libimagequant, vips warns if it's not present
    cmd = "#{bin}/vips copy #{test_fixtures("test.png")} #{testpath}/test.png[palette] 2>&1"
    assert_equal "", shell_output(cmd)
  end
end
