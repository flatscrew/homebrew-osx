class Libgtkflow4 < Formula
  desc "GTK4 widgets for visual node-based flow graphs"
  homepage "https://github.com/flatscrew/libgtkflow4"
  url "https://github.com/flatscrew/libgtkflow4/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "001afa6fc0063a8b2b33e6491fd772c58bd53564545cc125ac4058aae40fde7d"
  license "GPL-3.0"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build

  depends_on "flatscrew/osx/libgflow"
  depends_on "glib"
  depends_on "gobject-introspection"
  depends_on "gtk4"
  depends_on "libadwaita"

  def install
    system "meson", "setup", "build", *std_meson_args, "-Denable_valadoc=false"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gtkflow4/gtkflow4.h>
      int main() { return 0; }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lgtkflow4", "-o", "test"
    system "./test"
  end
end
