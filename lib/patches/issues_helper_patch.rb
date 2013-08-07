require_dependency 'issues_helper'

module RedmineTag
  module Patches
    module IssuesHelperPatch
      def self.included(base)
        # base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          alias_method_chain :show_detail, :tags
        end
      end

      module InstanceMethods
        def show_detail_with_tags(detail, no_html=false, options={})
          case detail.property
          when 'tag'
            label = content_tag('strong', detail.property.capitalize) unless no_html
            # When its an add
            if (detail.old_value.nil?)
              severity = detail.prop_key.to_i
              value = detail.value
              unless no_html
                value = content_tag('ul', content_tag('li', value, class: "severity-#{severity}" ), class: "tags")
              end
              return l(:tag_journal_added, :label => label, :new => value).html_safe
            # When its an remove
            elsif (detail.value.nil?)
              severity = detail.prop_key.to_i
              value = detail.old_value
              unless no_html
                value = content_tag('ul', content_tag('li', value, class: "severity-#{severity}" ), class: "tags")
              end
              return l(:tag_journal_deleted, :label => label, :old => value).html_safe
            # When its an update
            else
              old_severity = detail.old_value.to_i
              new_severity = detail.value.to_i
              value = detail.prop_key
              old_value = value
              new_value = value
              unless no_html
                old_value = content_tag('ul', content_tag('li', old_value, class: "severity-#{old_severity}"), class: "tags")
                new_value = content_tag('ul', content_tag('li', new_value, class: "severity-#{new_severity}"), class: "tags")
              end
              return l(:tag_journal_changed, :label => label, :old => old_value, :new => new_value).html_safe
            end
          end

          if detail.property != "tag"
            show_detail_without_tags(detail, no_html, options)
          end
        end
      end

      #module ClassMethods
      #end

    end
  end
end

unless IssuesHelper.included_modules.include?(RedmineTag::Patches::IssuesHelperPatch)
  IssuesHelper.send(:include, RedmineTag::Patches::IssuesHelperPatch)
end
