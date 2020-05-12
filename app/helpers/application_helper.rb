# frozen_string_literal: true

module ApplicationHelper
  # include AuthManagement
  def let(value)
    yield value
  end

  def han(model_name, attribute_name)
    model_name.classify.constantize.human_attribute_name(attribute_name)
  end

  def markdown2html(text)
    extensions = {
      autolink: true,
      filter_html: true,
      safe_links_only: true
    }
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, link_attributes: { target: '_blank' })
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text)
  end

  def truncate_markdown(text, options)
    truncate(strip_tags(markdown2html(text)), options)
  end

  def active?(path, options = {})
    # raise options.inspect
    if options.key? :active_if
      'active' if options[:active_if]
    elsif current_page?(path)
      'active'
    end
  end

  def nav_menu_item(name, path = '#', options = {})
    assembled_options = options.merge(class: "nav-link #{active?(path)}")
    content_tag :li, class: 'nav-item' do
      link_to path, assembled_options do
        content_tag(:div, name)
      end
    end
  end

  def message_for_notification(notification)
    ::NotificationsHelper.message(notification)
  end

  def class_for_notification(notification)
    ::NotificationsHelper.notification_class(notification)
  end

  def not_found_random_image
    # FIXME: add funny pictures
    content_tag :div, class: 'lead text-center' do
      t('.nothing')
    end
  end

  def facebook_share_url(url)
    "https://facebook.com/sharer.php?display=popup&u=#{url}"
  end

  def vk_share_url(url)
    "https://vk.com/share.php?url=#{url}"
  end
end
