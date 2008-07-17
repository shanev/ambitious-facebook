module Ambition
  module Adapters
    module FQL
      class Query

        def kick
          owner.find(:all, to_hash)
        end

        def size
          raise "Not Implemented"
        end

        def to_hash
          hash = {}

          unless (where = clauses[:select]).empty?
            hash[:conditions] = Array(where)
            hash[:conditions] *= ' AND '
          end
          
          hash
        end

        def to_s
          hash = to_hash

          raise "Sorry, I can't construct SQL with complex joins (yet)" if hash[:include]

          sql = []
          sql << "WHERE #{hash[:conditions]}" if hash[:conditions]
          sql << "ORDER BY #{hash[:order]}"   if hash[:order]
          sql << clauses[:slice].last         if hash[:slice]

          select % [ owner.table_name, sql.join(' ') ]
        end
        alias_method :to_sql, :to_s     
        
      private
        def select
          "SELECT #{owner.fields} FROM %s %s"            
        end
      end
    end
  end
end
