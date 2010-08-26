class UsageError <RuntimeError; end
class FormulaUnspecifiedError <UsageError; end
class KegUnspecifiedError <UsageError; end

module HomebrewArgvExtension
  def named
    @named ||= reject{|arg| arg[0..0] == '-'}
  end

  def options_only
    select {|arg| arg[0..0] == '-'}
  end

  def formulae
    require 'formula'
    @formulae ||= downcased_unique_named.map{ |name| Formula.factory(resolve_alias(name)) }
    raise FormulaUnspecifiedError if @formulae.empty?
    @formulae
  end

  def kegs
    require 'keg'
    @kegs ||= downcased_unique_named.collect do |name|
      d = HOMEBREW_CELLAR + resolve_alias(name)
      dirs = d.children.select{ |pn| pn.directory? } rescue []
      raise "No such keg: #{HOMEBREW_CELLAR}/#{name}" if not d.directory? or dirs.length == 0
      raise "#{name} has multiple installed versions" if dirs.length > 1
      Keg.new dirs.first
    end
    raise KegUnspecifiedError if @kegs.empty?
    @kegs
  end

  # self documenting perhaps?
  def include? arg
    @n=index arg
  end
  def next
    at @n+1 or raise UsageError
  end

  def force?
    flag? '--force'
  end
  def verbose?
    flag? '--verbose' or ENV['HOMEBREW_VERBOSE']
  end
  def debug?
    flag? '--debug' or ENV['HOMEBREW_DEBUG']
  end
  def quieter?
    flag? '--quieter'
  end
  def interactive?
    flag? '--interactive'
  end
  def build_head?
    flag? '--HEAD'
  end

  def flag? flag
    options_only.each do |arg|
      return true if arg == flag
      next if arg[1..1] == '-'
      return true if arg.include? flag[2..2]
    end
    return false
  end

  def usage; <<-EOS.undent
    Usage: brew command [formula] ...

    Principle Commands:
      install formula ... [--ignore-dependencies] [--HEAD]
      list [--unbrewed|--versions] [formula] ...
      search [/regex/] [substring]
      uninstall formula ...
      update

    Other Commands:
      info formula [--github]
      deps formula
      uses formula [--installed]
      home formula ...
      cleanup [formula]
      link formula ...
      unlink formula ...
      outdated
      prune
      doctor

    Informational:
      --version
      --config
      --prefix [formula]
      --cache [formula]

    Commands useful when contributing:
      create URL
      edit [formula]
      audit [formula]
      log formula
      install formula [-vd|-i]

    For more information:
      man brew

    To visit the Homebrew homepage type:
      brew home
    EOS
  end

  def resolve_alias name
    aka = HOMEBREW_REPOSITORY+"Library/Aliases/#{name}"
    if aka.file?
      aka.realpath.basename('.rb').to_s
    else
      name
    end
  end

  private

  def downcased_unique_named
    @downcased_unique_named ||= named.map{|arg| arg.downcase}.uniq
  end
end
