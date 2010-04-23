require 'formula'

class Highlight <Formula
  url 'http://www.andre-simon.de/zip/highlight-2.16.tar.bz2'
  homepage 'http://www.andre-simon.de/zip/download.html'
  md5 '08f1429a6db258ab1a7eecbb4e0d44b2'

  def fix_makefile
    inreplace 'makefile' do |contents|
      contents.change_make_var! "PREFIX", prefix
      contents.change_make_var! "man_dir", "${PREFIX}/share/man/man1/"
      contents.change_make_var! "conf_dir", "${PREFIX}/etc/highlight/"
    end
  end

  def install
    fix_makefile()
    system "make cli"
    system "make install"
  end
end
