# frozen_string_literal: true

module Lockme
  # Base class for all LockMe API objects
  class Base
    include JsonUtils

    class << self; attr_reader :base_path end

    # Check if object is persisted with Lockme
    def persisted?
      !id.nil?
    end

    def singular_path
      self.class.singular_path(id)
    end

    def collection_path
      self.class.collection_path
    end

    def self.singular_path(id)
      [base_path, id].join('/')
    end

    def self.collection_path
      base_path
    end
  end
end
