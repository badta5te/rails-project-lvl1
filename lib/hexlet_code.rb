# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'

  class Error < StandardError; end

  def self.form_for(_, **options)
    url = options[:url] || '#'

    Tag.build('form', action: url, method: 'post')
  end
end
