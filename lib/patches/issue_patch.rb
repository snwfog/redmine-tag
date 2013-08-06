require_dependency 'issue'

module RedmineTag
  module Patches
    module IssuePatch
      def self.included(base)
        # base.extend(ClassMethods)
        # base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          has_many :tags
          has_many :tag_descriptors, through: :tags

          safe_attributes 'tags',
          :if => lambda { |issue, user| issue.new_record? || user.allowed_to?(:edit_issues, issue.project)  }
        end
      end

      module InstanceMethods
      end

      module ClassMethods
      end

    end
  end
end

unless Issue.included_modules.include?(RedmineTag::Patches::IssuePatch)
  Issue.send(:include, RedmineTag::Patches::IssuePatch)
end
