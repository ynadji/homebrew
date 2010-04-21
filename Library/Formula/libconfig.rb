require 'formula'

class Libconfig <Formula
  url 'http://www.hyperrealm.com/libconfig/libconfig-1.4.4.tar.gz'
  homepage 'http://www.hyperrealm.com/libconfig/'
  md5 '3ebfb70dcb0c2ee454cda50fc634f4f2'

 depends_on 'libopennet'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
