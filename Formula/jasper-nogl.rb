class JasperNogl < Formula
  desc "Library for manipulating JPEG-2000 images (Without OpenGL)"
  homepage "https://www.ece.uvic.ca/~frodo/jasper/"
  url "https://github.com/jasper-software/jasper/archive/version-2.0.25.tar.gz"
  sha256 "f5bc48e2884bcabd2aca1737baff4ca962ec665b6eb673966ced1f7adea07edb"
  license "JasPer-2.0"

  depends_on "cmake" => :build
  depends_on "jpeg"

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DJAS_ENABLE_DOC=OFF"
      args << "-DJAS_ENABLE_OPENGL=OFF"

      system "cmake", "..",
        "-DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=false",
        "-DJAS_ENABLE_SHARED=ON",
        *args
      system "make"
      system "make", "install"
      system "make", "clean"

      system "cmake", "..",
        "-DJAS_ENABLE_SHARED=OFF",
        *args
      system "make"
      lib.install "src/libjasper/libjasper.a"
    end
  end

  test do
    system bin/"jasper", "--input", test_fixtures("test.jpg"),
                         "--output", "test.bmp"
    assert_predicate testpath/"test.bmp", :exist?
  end
end
