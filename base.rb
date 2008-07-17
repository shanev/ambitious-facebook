module Ambition
  module Adapters
    module FQL
      class Base
        
        def fields
          FIELDS.map(&:to_s).join(',')
        end
        
        def table_name
          self.class.to_s.downcase
        end
        
        def sanitize(value)
          if value.is_a? Array
            return value.map { |v| sanitize(v) }.join(', ')
          end

          case value
          when true,  'true'  
            '1'
          when false, 'false' 
            '0'
          when Regexp
            "'#{value.source}'"
          when Fixnum
            "#{value}"
          else 
            "'#{value}'"
          end
        rescue
          "'#{value}'"
        end
      end
    end
  end
end