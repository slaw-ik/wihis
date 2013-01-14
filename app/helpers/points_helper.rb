module PointsHelper
  def build_activity(text)
    html = "<div class='tag-cnt'>"
    text[:tags].each do |tag|
      html << "<div class='tag-item'>#{sanitize(tag)}</div>"
    end
    html << "</div>"
    html << sanitize(text[:desc])
    return raw html
  end
end
