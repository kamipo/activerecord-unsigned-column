require 'activerecord-unsigned-column/base'

module ActiveRecord
  module ConnectionAdapters
    class TableDefinition
      def references(*args)
        options = args.extract_options!
        polymorphic = options.delete(:polymorphic)
        args.each do |col|
          column("#{col}_id", :unsigned, options)
          column("#{col}_type", :string, polymorphic.is_a?(Hash) ? polymorphic : options) unless polymorphic.nil?
        end
      end
      alias :belongs_to :references
    end

    class Table
      def references(*args)
        options = args.extract_options!
        polymorphic = options.delete(:polymorphic)
        args.each do |col|
          @base.add_column(@table_name, "#{col}_id", :unsigned, options)
          @base.add_column(@table_name, "#{col}_type", :string, polymorphic.is_a?(Hash) ? polymorphic : options) unless polymorphic.nil?
        end
      end
      alias :belongs_to :references
    end

    class AbstractMysqlAdapter
      def type_to_sql_with_primary_key(type, limit = nil, precision = nil, scale = nil)
        if type == :primary_key
          column_type_sql = type_to_sql_without_primary_key(:unsigned, limit, precision, scale)
          column_type_sql << ' DEFAULT NULL auto_increment PRIMARY KEY'
        else
          type_to_sql_without_primary_key(type, limit, precision, scale)
        end
      end
      alias_method_chain :type_to_sql, :primary_key
    end
  end
end
