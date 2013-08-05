require_dependency 'issue'

module RedmineTags
  module Patches
    module IssuePatch
      def self.included(base)
        # base.extend(ClassMethods)
        # base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          has_many :tags
          has_many :tag_descriptors, through: :tags
        end
      end

      module InstanceMethods
      end

      module ClassMethods
      end

    end
  end
end

unless Issue.included_modules.include?(RedmineTags::Patches::IssuePatch)
  Issue.send(:include, RedmineTags::Patches::IssuePatch)
end
