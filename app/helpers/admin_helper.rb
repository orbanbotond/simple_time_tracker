module AdminHelper
  def menu_item(text,url,icon_class ='',options ={})
    content_tag :li, options.merge({class: "link-head #{request.path == url ? 'active' : ''}"}) do
      link_to "<i  class=\"#{icon_class}\"></i><span class=\"menu-text\"> #{text}</span>".html_safe,url
    end
  end

  def header(content)
    content_for(:page_header, content)
  end

  def delete_item_link(item, attribute, *classes)
    classs = ['btn', 'btn-danger'] + classes
    link_to 'Delete', url_for([:admin, item].flatten), method: :delete, data: { confirm: 'Are you sure to delete?' }, class: classs.join(' ')
  end

  def sortable(sortable_column, title = nil, sort_param = :sort, sort_direction_param = "#{sort_param}_direction")
    title ||= sortable_column.titleize
    sorted_column = sort_column(sort_param).to_sym
    sorted_direction = sort_direction(sort_direction_param).to_sym
    css_class = sortable_column == sorted_column ? "current #{sorted_direction}" : nil
    direction = (sortable_column == sorted_column && sorted_direction == :asc) ? :desc : :asc
    link_to title, params.merge(sort_param => sortable_column.to_s, sort_direction_param => direction), {:class => css_class}
  end

  def resource_admin_index_path(resource_class)
    if resource_class.to_s.pluralize.downcase == resource_class.to_s.singularize.downcase
      [:admin, resource_class.to_s.pluralize.downcase, :index]
    else
      [:admin, resource_class.to_s.pluralize.downcase]
    end
  end
end
