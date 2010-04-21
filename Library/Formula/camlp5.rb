require 'formula'

class Camlp5 <Formula
  url 'http://pauillac.inria.fr/~ddr/camlp5/distrib/src/camlp5-5.13.tgz'
  homepage 'http://pauillac.inria.fr/~ddr/camlp5/'
  md5 'f205d624e890761d3526eaf709071039'

  depends_on 'ocaml'

  def install
    # compile for strict
    system "./configure -strict -prefix #{prefix}"
    # parallel build
    system "make -j 1 world.opt"
    system "make install"
  end
end
