# Multirb

Runs an IRB-esque prompt (but it's NOT really IRB!) over multiple Rubies using RVM.

![Screencast](http://s3.cooperpress.com.s3.amazonaws.com/multirb.gif)

Note: This is NOT the same as [multiruby](http://www.infoq.com/news/2008/02/multiruby-testing) although multiruby has similar uses for fuller scripts and may be worth checking out.

## Why is this useful?

If you're a regular developer, it's probably not very useful. But if you're researching or training people in the differences between versions and implementations of Ruby, it could be very helpful indeed.

This system was used in a different form in the [Ruby 1.9 Walkthrough](https://cooperpress.com/19walkthrough) and is now being used to develop the Ruby 2.0 Walkthrough. Multirb allows me to quickly demonstrate the ways in which different versions of Ruby handle or support various features.

## Installation

Install with:

    $ gem install multirb

You also need a complete, working [RVM](https://rvm.io/) installation. Feel free to submit pull requests to make this auto detect other Ruby version managers, such as rbenv.

## Usage

Run with:

    $ multirb

Or if you want to specify some different 'default' versions of Ruby to run:

    $ multirb 1.9.2 1.9.3 [etc..]

Then:

1. Type in expressions and press Enter.
2. Leave whitespace on the end of lines to enter more lines.
3. Add `# all` to run all versions, nothing for default.
4. Add `# version,version,version` to run specific versions (e.g. `# 1.9.2, 1.9.3`.)
5. Type `exit` on its own to exit (or use Ctrl+D.)

Currently specifies jruby, 1.8.7, 1.9.2, 1.9.3, and 2.0.0 as 'all versions'; 1.8.7, 1.9.3, and 2.0.0 as 'default versions'.

## Versions

0.0.1: Initial version

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request