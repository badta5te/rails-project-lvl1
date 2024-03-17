# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

  def test_form_generate
    user = User.new name: 'rob'

    form_with_url = HexletCode.form_for user, url: '/users'
    assert(form_with_url == '<form action="/users" method="post"></form>')

    form_without_url = HexletCode.form_for user
    assert(form_without_url == '<form action="#" method="post"></form>')
  end
end
