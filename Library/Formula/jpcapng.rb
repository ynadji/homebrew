require 'formula'

class Jpcapng <Formula
  url 'http://downloads.sourceforge.net/project/jpcapng/jpcap/jpcap-0.8_src.tar.gz'
  homepage 'http://sourceforge.net/projects/jpcapng/'
  md5 'd931f754b96a6e0f057e2765aec6bb85'

  version '0.8'
  aka 'jpcap'

  def install
    # JAR
    system "ant"
    lib.install "lib/jpcap.jar"

    # JNI library
    cd "src/c"
    # set JAVA_HOME
    inreplace 'Makefile' do |contents|
      contents.change_make_var! "JAVA_DIR", "/System/Library/Frameworks/JavaVM.framework/Home"
    end

    system "make"
    lib.install "libjpcap.jnilib"
  end
end
