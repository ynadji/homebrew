require 'formula'

class Shaperprobe < Formula
  homepage 'http://www.cc.gatech.edu/~partha/diffprobe/shaperprobe.html'
  url 'http://www.cc.gatech.edu/~partha/diffprobe/shaperprobe.tgz'
  md5 'd555ace1f2e8d86ce2975457b09b17b7'
  version '0.1'

  def install
    system "make -f Makefile.osx"
    bin.install "prober"
  end

  def test
    system "prober"
  end
end
