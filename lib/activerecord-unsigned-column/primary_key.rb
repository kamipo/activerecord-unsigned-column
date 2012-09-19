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
      NATIVE_DATABASE_TYPES.merge!(
        :primary_key => 'int(10) unsigned DEFAULT NULL auto_increment PRIMARY KEY'
      )
    end
  end
end
