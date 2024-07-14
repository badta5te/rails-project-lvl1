# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

  def test_form_without_field
    user = User.new
    assert_raises NoMethodError do
      HexletCode.form_for user do |f|
        f.input :name
        f.input :age
      end
    end
  end

  def test_form_generate
    user = User.new name: 'rob'

    form_with_url = HexletCode.form_for user, url: '/users'
    assert_equal form_with_url, '<form action="/users" method="post"></form>'

    form_without_url = HexletCode.form_for user
    assert_equal form_without_url, '<form action="#" method="post"></form>'
  end

  # rubocop:disable Metrics/MethodLength
  def test_with_block
    user = User.new name: 'rob'
    resulted_html = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input name="name" type="text" value="rob">',
      '<label for="job">Job</label>',
      '<input name="job" type="text" value="">',
      '</form>'
    ].join

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
    end
    assert_equal form, resulted_html
  end

  def test_with_options
    user = User.new name: 'rob', job: 'hexlet'
    resulted_html = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input name="name" type="text" value="rob" class="my-test-class">',
      '<label for="job">Job</label>',
      '<textarea name="job" cols="20" rows="10">hexlet</textarea>',
      '</form>'
    ].join

    form = HexletCode.form_for user do |f|
      f.input :name, class: 'my-test-class'
      f.input :job, as: :text, rows: 10
    end
    assert_equal form, resulted_html
  end

  def test_with_labels
    user = User.new name: 'rob', job: 'hexlet'
    resulted_html = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input name="name" type="text" value="rob">',
      '<label for="job">Job</label>',
      '<input name="job" type="text" value="hexlet">',
      '</form>'
    ].join

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
    end
    assert_equal form, resulted_html
  end

  def test_with_custom_submit
    user = User.new name: 'rob'
    resulted_html = [
      '<form action="#" method="post">',
      '<label for="name">Name</label>',
      '<input name="name" type="text" value="rob">',
      '<label for="job">Job</label>',
      '<input name="job" type="text" value="">',
      '<input type="submit" value="Wow">',
      '</form>'
    ].join

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end
    assert_equal form, resulted_html
  end

  def test_form_with_class
    user = User.new name: 'rob'
    resulted_html = [
      '<form action="/profile" method="get" class="hexlet-form">',
      '<input type="submit" value="Save">',
      '</form>'
    ].join

    form = HexletCode.form_for user, url: '/profile', method: 'get', class: 'hexlet-form', &:submit
    assert_equal form, resulted_html
  end
  # rubocop:enable Metrics/MethodLength
end
