require 'formula'

class Ledit <Formula
  url 'http://pauillac.inria.fr/~ddr/ledit/distrib/src/ledit-2.01.tgz'
  homepage 'http://pauillac.inria.fr/~ddr/ledit'
  md5 '24faa563dff1091aea2e744b1ec15fbb'

 depends_on 'ocaml'
 depends_on 'camlp5'

  def install
    system "make BINDIR=#{prefix}/bin LIBDIR=#{prefix}/lib MANDIR=#{prefix}/man"
    system "make install BINDIR=#{prefix}/bin LIBDIR=#{prefix}/lib MANDIR=#{prefix}/man"
  end
end
