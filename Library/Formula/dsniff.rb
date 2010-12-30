require 'formula'

class Dsniff <Formula
  url 'http://www.monkey.org/~dugsong/dsniff/beta/dsniff-2.4b1.tar.gz'
  homepage 'http://www.monkey.org/~dugsong/dsniff/'
  md5 '2f761fa3475682a7512b0b43568ee7d6'

  depends_on 'berkeley-db'
  depends_on 'libnet'
  depends_on 'libnids'

  # These patches update dsniff to work with libnet > 1.10 and are required
  # for dsniff to be installed properly.
  def patches
    base = 'http://trac.macports.org/export/74632/trunk/dports/net/dsniff-devel/files/'
    diffs = [
      'patch-pcaputil.c',
      'patch-sshcrypto.c',
      'patch-sshow.c.diff',
      'patch-arpspoof.c.diff',
      'patch-dnsspoof.c.diff',
      'patch-filesnarf.c.diff',
      'patch-macof.c.diff',
      'patch-record.c.diff',
      'patch-sshmitm.c.diff',
      'patch-tcp_raw.c.diff',
      'patch-tcp_raw.h.diff',
      'patch-tcpkill.c.diff',
      'patch-tcpnice.c.diff',
      'patch-trigger.c.diff',
      'patch-trigger.h.diff',
      'patch-urlsnarf.c.diff',
      'patch-webmitm.c.diff',
      'patch-webspy.c.diff'
    ]
    diffs.map! {|diff| base + diff}
    {:p0 => diffs}
  end

  def install
    ENV.append 'CFLAGS', '-DBIND_8_COMPAT'
    system "./configure", "--with-libnet=#{HOMEBREW_PREFIX}", "--with-libnids=#{HOMEBREW_PREFIX}",
                          "--with-db=#{HOMEBREW_PREFIX}", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make install"
  end
end
