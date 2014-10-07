module GlobalStore
  class Store
    class << self

      def get(key)
        storage[prefixed_key(key)]
      end

      def present?(key)
        storage[prefixed_key(key)].respond_to?(:present?) ? storage[prefixed_key(key)].present? : object_present?(storage[prefixed_key(key)])
      end

      def blank?(key)
        storage[prefixed_key(key)].respond_to?(:blank?) ? storage[prefixed_key(key)].blank? : object_blank?(storage[prefixed_key(key)])
      end


      def set(key, value)
        storage[prefixed_key(key)] = value
      end

      def exists?(keyname)
        storage.exist?(keyname)
      end
      
      alias_method :exist?, :exists?

      protected

      def storage
        RequestStore
      end

      def prefixed_key(key)
        [key_prefix, key].join("_").to_sym
      end

      def key_prefix
        :db_versioning
      end

      private

      # in case you don't have #present? and #blank? I don't feel like adding activesupport just for those two
      def object_blank?(obj)
        obj.respond_to?(:empty?) ? !!obj.empty? : !obj
      end

      def object_present?(obj)
        !object_blank?(obj)
      end

    end
  end
end