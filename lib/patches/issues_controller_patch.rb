require_dependency 'issues_controller'

module RedmineTag
  module Patches
    module IssuesControllerPatch
      def self.included(base)
        # base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          alias_method_chain :build_new_issue_from_params, :tags
          # alias_method_chain: :update_issue_from_params :tags
          alias_method_chain :update, :tags
        end
      end

      module InstanceMethods
        def update_with_tags
          build_tag_from_param
          #tags = build_tag_from_param
          #tag_ids = tags.map(&:id) unless tags.empty?
          # Replace now the tag in params with tag_ids for mass insertion
          #params[:issue][:tags] = tag_ids
          update_without_tags
        end

        private

        def build_new_issue_from_params_with_tags
          # build_new_issue_from_params
          # @issue.tags = build_tag(marshall_tag)
        end

        def update_issue_from_params_with_tags
          puts "HEllo world"
        end

        def build_tag_from_param
          params_tag = params[:issue].delete(:tags) || []
          return if params_tag.empty?

          tags = params_tag.split(',').map do |tag|
            severity = tag.count("!")
            description = tag.scan(/[\w\s]+/).pop.strip

            tag_descriptor = TagDescriptor.find_by_description description
            tag_descriptor ||= TagDescriptor.create(description: description)

            Tag.create(severity: severity, tag_descriptor: tag_descriptor, issue: @issue) if tag_descriptor
          end
        end
      end

      module ClassMethods
      end

    end
  end
end

unless IssuesController.included_modules.include?(RedmineTag::Patches::IssuesControllerPatch)
  IssuesController.send(:include, RedmineTag::Patches::IssuesControllerPatch)
end
