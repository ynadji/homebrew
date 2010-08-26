require 'formula'

class Libdnet <Formula
  url 'http://libdnet.googlecode.com/files/libdnet-1.12.tgz'
  homepage 'http://code.google.com/p/libdnet/'
  md5 '9253ef6de1b5e28e9c9a62b882e44cc9'

  def options
    ["--python", "Python bindings"]
  end

  def install
    args = ["--disable-debug", "--disable-dependency-tracking",
           "--prefix=#{prefix}",
           "--mandir=#{man}"]

    if ARGV.include? "--python"
      args << "--with-python"
    end

    system "./configure", *args
    system "make install"
  end
end
