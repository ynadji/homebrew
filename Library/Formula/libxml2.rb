require 'formula'

class Libxml2 <Formula
  url 'ftp://xmlsoft.org/libxml2/libxml2-2.7.7.tar.gz'
  homepage 'http://xmlsoft.org'
  md5 '9abc9959823ca9ff904f1fbcf21df066'

  def keg_only?
    :provided_by_osx
  end

  def options
    [
      ["--with-python", "Compile with Python support, assumes you did a 'brew install python --framework' build."],
    ]
  end

  def install
    args = ["--prefix=#{prefix}", "--disable-dependency-tracking"]
    args << "--with-python=/Library/Frameworks/Python.framework/Versions/Current" if ARGV.include? '--with-python'

    system "./configure", *args
    system "make"
    ENV.j1
    system "make install"

    # do python bindings installation
    if ARGV.include? '--with-python'
      system "cd python && make install"
    end

  end

  def caveats
    "To use libxml2 in Python, make sure you add the site-packages directory to your PYTHONPATH. This is located in `brew --prefix`/lib/pythonVER/site-packages." if ARGV.include? '--with-python'
  end
end
