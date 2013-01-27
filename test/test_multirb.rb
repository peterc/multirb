$: << File.expand_path(__FILE__, "../../lib")

require 'minitest/autorun'
require 'multirb'

include Multirb

# Some merely cursory tests, in this case!

describe Multirb do
  it "should have versions defined" do
    ALL_VERSIONS.must_be_instance_of Array
    DEFAULT_VERSIONS.must_be_instance_of Array

    ALL_VERSIONS.length.must_be :>, 2
    DEFAULT_VERSIONS.length.must_be :>, 2
  end

  it "should be able to determine versions wanted by the user" do
    determine_versions(['2 + 2']).must_equal DEFAULT_VERSIONS
    determine_versions(['2 + 2 #all']).must_equal ALL_VERSIONS
    determine_versions(['2 + 2 # all']).must_equal ALL_VERSIONS
    determine_versions(['2 + 2 #all', '5 + 5']).must_equal DEFAULT_VERSIONS
    determine_versions(['2 + 2 # 1.9.2,1.9.3,2.0.0']).must_equal %w{1.9.2 1.9.3 2.0.0}
    determine_versions(['2 + 2 # 1.9.2, 1.9.3, 2.0.0']).must_equal %w{1.9.2 1.9.3 2.0.0}
  end
end
