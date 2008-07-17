module Ambition
  module Adapters
    module FQL
      class Select < Base
        def call(method)
          method.to_s
        end
        
        # def chained_call(*methods)
        #   if reflection = owner.reflections[methods.first]
        #     stash[:include] ||= []
        #     stash[:include] << methods.first
        #     "#{reflection.table_name}.#{quote_column_name methods.last}"
        #   else 
        #     send(methods[1], methods.first)
        #   end
        # end
        
        def both(left, right)
          "(#{left} AND #{right})"
        end
        
        def either(left, right)
          "(#{left} OR #{right})"
        end

        def ==(left, right)
          if right.nil?
            "#{left} IS NULL"
          else
            "#{left} = #{sanitize right}"
          end
        end

        # !=
        def not_equal(left, right)
          raise "Not implemented by Facebook"
        end
        
        def =~(left, right)
          raise "Not implemented by Facebook"          
        end
        
        # !~
        def not_regexp(left, right)
          raise "Not implemented by Facebook"
        end
        
        def <(left, right)
          "#{left} < #{sanitize right}"
        end
        
        def >(left, right)
          "#{left} > #{sanitize right}"
        end
        
        def >=(left, right)
          "#{left} >= #{sanitize right}"
        end
        
        def <=(left, right)
          "#{left} <= #{sanitize right}"
        end
        
        def include?(left, right)
          left = left.map { |element| sanitize element }.join(', ')
          "#{right} IN (#{left})"
        end
        
        def downcase(column)
          raise "Not implemented by Facebook"                    
        end
        
        def upcase(column)
          raise "Not implemented by Facebook"          
        end
      end
    end
  end
end
