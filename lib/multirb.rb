# encoding: utf-8

require_relative 'multirb/version'    # not strictly necessary, but laziness in development ;-)
require 'readline'
require 'tempfile'

module Multirb
  ALL_VERSIONS = %w{jruby 1.8.7 1.9.2 1.9.3 2.0.0}
  DEFAULT_VERSIONS = %w{1.8.7 1.9.3 2.0.0}

  RBENV_INSTALLED_VERSIONS = `rbenv versions`.split("\n").map { |version| version.delete('*').strip.split.first } if ENV['PATH']['.rbenv']

  def read_lines
    lines = []
    begin
      print "\e[0m"
      line = Readline::readline("> ")
      return nil if line.nil?
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

  def run_code(filename, version, out = STDOUT)
    if ENV['PATH']['.rvm']
      `rvm #{version} exec ruby #{filename}`
    elsif ENV['PATH']['.rbenv']
      begin
        `#{rbenv_ruby_path_for(version)} '#{filename}'`
      rescue ArgumentError => e # Rescue when version is not installed and print a message
        e.message
      end
    else
      raise "Seems you don't have either RVM or RBENV installed"
    end
  end

  private

  def rbenv_ruby_path_for(wanted_version)
    rbenv_version = RBENV_INSTALLED_VERSIONS.select {|version| version.match(/^#{wanted_version}/) }.last

    # raise error if there is not such version installed
    raise ArgumentError.new("version not installed") if rbenv_version.nil?

    "~/.rbenv/versions/#{rbenv_version}/bin/ruby"
  end
end
