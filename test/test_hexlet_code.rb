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

  def test_with_block
    user = User.new name: 'rob'
    resulted_html = ['<form action="#" method="post">',
                     '<input name="name" type="text" value="rob">',
                     '<input name="job" type="text" value="">',
                     '</form>'].join

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
    end
    # byebug
    assert form == resulted_html
  end

  def test_with_options
    user = User.new name: 'rob', job: 'hexlet'
    resulted_html = ['<form action="#" method="post">',
                     '<input name="name" type="text" value="rob" class="my-test-class">',
                     '<textarea name="job" cols="20" rows="10">hexlet</textarea>',
                     '</form>'].join

    form = HexletCode.form_for user do |f|
      f.input :name, class: 'my-test-class'
      f.input :job, as: :text, rows: 10
    end
    assert form == resulted_html
  end

  def test_form_without_field
    user = User.new
    assert_raises NoMethodError do
      HexletCode.form_for user do |f|
        f.input :name
        f.input :age
      end
    end
  end
end
