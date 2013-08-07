require_dependency 'issues_controller'

module RedmineTag
  module Patches
    module IssuesControllerPatch
      def self.included(base)
        # base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          #alias_method_chain :build_new_issue_from_params, :tags
          # alias_method_chain: :update_issue_from_params :tags
          #alias_method_chain :update, :tags
        end
      end

      module InstanceMethods
        #def update_with_tags
        #  update_without_tags
        #  build_tag_from_param
        #end

        #private

        #def build_new_issue_from_params_with_tags
          # build_new_issue_from_params
          # @issue.tags = build_tag(marshall_tag)
        #end

        #def update_issue_from_params_with_tags
        #  puts "HEllo world"
        #end


      end

      module ClassMethods
      end

    end
  end
end

unless IssuesController.included_modules.include?(RedmineTag::Patches::IssuesControllerPatch)
  IssuesController.send(:include, RedmineTag::Patches::IssuesControllerPatch)
end
