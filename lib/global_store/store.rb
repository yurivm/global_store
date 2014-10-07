module GlobalStore
  class Store
    class << self

      def get(key)
        storage[prefixed_key(key)]
      end

      def present?(key)
        storage[prefixed_key(key)].present?
      end

      def blank?(key)
        storage[prefixed_key(key)].blank?
      end

      alias_method :exists?, :present?

      def set(key, value)
        storage[prefixed_key(key)] = value
      end

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
    end
  end
end