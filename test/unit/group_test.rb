require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save group without title" do
    group = Group.new
    assert !group.save
  end
end
