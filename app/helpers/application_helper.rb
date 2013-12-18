module ApplicationHelper
  # see http://getbootstrap.com/2.3.2/base-css.html#images
  def icon_and_text(name, icon_name=nil)
    icon_name ||= name
    "<i class='icon-#{icon_name}'> #{t(".#{name}", :default => t("helpers.links.#{name}"))}</i>".html_safe
  end

  def format_sql(sql)
    sql_formatter.format(sql)
  end

  def sql_formatter
    @sql_formatter ||= begin
      rule = AnbtSql::Rule.new
      rule.keyword = AnbtSql::Rule::KEYWORD_UPPER_CASE
      %w(count sum substr date).each{|func_name|
        rule.function_names << func_name.upcase
      }
      rule.indent_string = "    "
      formatter = AnbtSql::Formatter.new(rule)
    end
  end
end
