# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'

  class Error < StandardError; end

  def self.build(name, attributes = {})
    HexletCode::Tag.build(name, attributes)
  end
end
