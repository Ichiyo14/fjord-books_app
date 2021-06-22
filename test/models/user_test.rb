# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @me = users(:me)
    @she = users(:she)
  end

  test '#name_or_email' do
    assert_equal 'me@example.com', @me.name_or_email
    @me.name = '花子'
    assert_equal '花子', @me.name_or_email
  end

  test '#follow' do
    assert_not @me.following?(@she)
    @me.follow(@she)
    assert @me.following?(@she)
  end

  test '#unfollow' do
    @me.follow(@she)
    assert @she.followed_by?(@me)
    @me.unfollow(@she)
    assert_not @she.followed_by?(@me)
  end
end
