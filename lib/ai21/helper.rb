# frozen_string_literal: true

module AI21
  module Helper
    def deep_transform_keys!(object, &block)
      case object
      when Hash
        object.keys.each do |key|
          value = object.delete(key)
          object[yield(key)] = deep_transform_keys!(value, &block)
        end
        object
      when Array
        object.map! { |item| deep_transform_keys!(item, &block) }
      else
        object
      end
    end

    def camel_to_snake(hash)
      deep_transform_keys!(hash) do |key|
        key.to_s.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase.to_sym
      end
    end

    def snake_to_camel(hash)
      deep_transform_keys!(hash) do |key|
        key.to_s.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.to_sym
      end
    end
  end
end
