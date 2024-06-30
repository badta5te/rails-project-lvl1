# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'

  class Error < StandardError; end

  def self.form_for(model, **options)
    @model = model
    @inputs = []
    url = options[:url] || '#'

    Tag.build('form', action: url, method: 'post') do
      if block_given?
        yield self
        @inputs.join
      end
    end
  end

  def self.input(name, **options)
    @inputs ||= []

    value = @model.public_send(name)
    if options[:as] == :text
      options = handle_as_text(options)
      @inputs << Tag.build('textarea', name:, **options) { value }
    else
      @inputs << Tag.build('input', name:, type: 'text', value:, **options)
    end
  end

  def self.handle_as_text(options)
    options.delete(:as)
    defaults = { cols: 20, rows: 40 }
    defaults.merge!(options)
  end
end
