module ApplicationHelper
  # see http://getbootstrap.com/2.3.2/base-css.html#images
  def icon_and_text(name, icon_name=nil)
    icon_name ||= name
    "<i class='icon-#{icon_name}'> #{t(".#{name}", :default => t("helpers.links.#{name}"))}</i>".html_safe
  end
end
