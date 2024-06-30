# frozen_string_literal: true

module HexletCode
  class Tag
    SINGLE_TAGS = %w[img br input].freeze

    def self.build(tag_name, **options)
      built_attributes = build_attributes(options)

      if SINGLE_TAGS.include?(tag_name)
        "<#{tag_name}#{built_attributes}>"
      else
        "<#{tag_name}#{built_attributes}>#{yield if block_given?}</#{tag_name}>"
      end
    end

    def self.build_attributes(attributes)
      attributes.map do |key, value|
        " #{key}=\"#{value}\""
      end.join
    end
  end
end
