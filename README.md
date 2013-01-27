# Multirb

Runs an IRB-esque prompt (but it's NOT really IRB!) over multiple Rubies using RVM.

Currently specifies jruby, 1.8.7, 1.9.2, 1.9.3, and 2.0.0 as 'all versions'.
And 1.8.7, 1.9.3, and 2.0.0 as 'default versions'.

This system was used in a different form in the Ruby 1.9 Walkthrough and is now
being used to develop the Ruby 2.0 Walkthrough. Multirb allows me to quickly
demonstrate the ways in which different versions of Ruby handle or support
various features.

## Installation

Install with:

    $ gem install multirb


## Usage

Unless you're in the mood to experiment, use the 'multirb' executable to
bring up a Ruby prompt. Then:

1. Type in expressions and press enter.
2. Leave whitespace on the end of lines to enter more lines.
3. Add # all to run all versions, nothing for default
4. Add # version,version,version to run specific versions.
5. Type 'exit' on its own to exit (or use Ctrl+D)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request