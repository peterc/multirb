# encoding: utf-8

require_relative 'multirb/version'    # not strictly necessary, but laziness in development ;-)
require 'readline'
require 'tempfile'

module Multirb
  ALL_VERSIONS = %w{jruby 1.8.7 1.9.2 1.9.3 2.0.0}
  DEFAULT_VERSIONS = %w{1.8.7 1.9.3 2.0.0}

  def read_lines
    lines = []
    begin
      print "\e[0m"
      line = Readline::readline("> ")
      Readline::HISTORY << line
      line.chomp!
      lines << line
      exit if line =~ /^exit$/i
    end while line =~ /\s+$/
    lines
  end

  def determine_versions(lines, defaults = DEFAULT_VERSIONS)
    defaults = DEFAULT_VERSIONS if defaults.empty?
    case lines.last
    when /\#\s?all$/
      ALL_VERSIONS
    when /\#\s?(.+)$/
      [*$1.strip.split(',').map(&:strip)]
    else
      defaults
    end
  end

  def create_code(lines)
    %{# encoding: utf-8
      ARRAY = ['a', 'b', 'c']
      HASH = { :name => "Jenny", :age => 40, :gender => :female, :hobbies => %w{chess cycling baking} }
      ARRAY2 = [1,2,3]
      STRING = "Hello"
      STRING2 = "çé"
      STRING3 = "ウabcé"
      o = begin
        "\e[32m" + eval(<<-'CODEHERE'
          #{lines.join("\n")}
        CODEHERE
        ).inspect + "\e[0m"
      rescue Exception => e
        "\e[31m!! \#{e.class}: \#{e.message}\e[0m"
      end
      print o}
  end

  def create_and_save_code(lines)
    f = Tempfile.new('multirb')
    f.puts create_code(lines)
    f.close
    f
  end

  def run_code(filename, version)
    `rvm #{version} exec ruby #{filename}`
  end
end