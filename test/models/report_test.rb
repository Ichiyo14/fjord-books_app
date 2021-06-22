# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    report = reports(:my_nippou)
    me = users(:me)
    she = users(:she)
    assert report.editable?(me)
    assert_not report.editable?(she)
  end

  test '#created_on' do
    report = reports(:my_nippou)
    assert_equal(report.created_on, 'Tue, 02 Feb 2021'.to_date)
  end
end
