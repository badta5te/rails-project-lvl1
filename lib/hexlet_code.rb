# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'

  class Error < StandardError; end

  def self.form_for(model, **options)
    @model = model
    @inputs = []
    action = options[:action] || '#'
    method = options[:method] || 'post'

    form_content = if block_given?
                     yield self
                     @inputs.join
                   end

    Tag.build('form', action:, method:) { form_content }
  end

  def self.input(name, **options)
    @inputs ||= []

    value = @model.public_send(name)
    label_tag = Tag.build('label', for: name) { name.capitalize }

    input_field = if options[:as] == :text
                    options = handle_as_text(options)
                    Tag.build('textarea', name:, **options) { value }
                  else
                    Tag.build('input', name:, type: 'text', value:, **options)
                  end

    @inputs << "#{label_tag}#{input_field}"
  end

  def self.submit(value = 'Save')
    @inputs ||= []
    @inputs << Tag.build('input', type: 'submit', value:)
  end

  def self.handle_as_text(options)
    options.delete(:as)
    defaults = { cols: 20, rows: 40 }
    defaults.merge!(options)
  end
end
