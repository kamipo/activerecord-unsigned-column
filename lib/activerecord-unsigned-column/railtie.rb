module ActiveRecord
  module UnsignedColumn
    class Railtie < Rails::Railtie
      initializer 'activerecord-unsigned-column' do
        ActiveSupport.on_load :active_record do
          require 'activerecord-unsigned-column/primary_key'
        end
      end
    end
  end
end
