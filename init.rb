require 'redmine'

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
  # if redmine plugins were railties:
  # object_to_prepare = config
end

object_to_prepare.to_prepare do
  require_dependency 'patches/issue_patch'
end

Redmine::Plugin.register :redmine_tag do
  name 'Redmine Tag'
  author 'Charles Yang'
  description 'This plugin add taggability to Redmine issues/tasks'
  version '0.0.1'
  author_url 'http://charlescy.com'
end

class RedmineTagsViewListener < Redmine::Hook::ViewListener
  # Adds javascript and stylesheet tags
  def view_layouts_base_html_head(context)
    stylesheet_link_tag('redmine_tag', plugin: :redmine_tag)
  end
end