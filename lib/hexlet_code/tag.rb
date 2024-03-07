# frozen_string_literal: true

module HexletCode
  class Tag
    SINGLE_TAGS = %w[img br input].freeze

    def self.build(name, attributes = {})
      built_attributes = build_attributes(attributes)

      raise StandardError, 'This tag does not supported' unless SINGLE_TAGS.include?(name)

      "<#{name}#{built_attributes}>"
    end

    def self.build_attributes(attributes)
      attributes.compact.map do |key, value|
        " #{key}=\"#{value}\""
      end.join
    end
  end
end
