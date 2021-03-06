# encoding: UTF-8

module Rosette
  module DataStores
    class ActiveRecordDataStore

      class Phrase < ActiveRecord::Base
        extend ExtractParams
        include Rosette::Core::PhraseIndexPolicy
        include Rosette::Core::PhraseToHash

        validates :repo_name, presence: true
        validate  :validate_key_presence
        validates :file, presence: true
        validates :commit_id, presence: true

        has_many :translations

        # eventually include ArelHelpers and remove this method
        def self.[](column)
          arel_table[column]
        end

        def self.lookup(key, meta_key)
          ikey = index_key(key, meta_key)
          ivalue = index_value(key, meta_key)
          where(ikey => ivalue)
        end

        def self.from_h(hash)
          new(hash)
        end

        private

        def validate_key_presence
          if key.nil?
            errors.add(:key, "can't be nil")
          end
        end
      end
    end

  end
end
