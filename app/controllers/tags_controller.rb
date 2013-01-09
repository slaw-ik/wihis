class TagsController < ApplicationController
  def autocomplete
    result = Tag.where("name like ?", '%'+params[:term]+'%')
    text = []
    result.each do |el|
      text << {:id => "#{el.id}",
               :label => el.name,
               :value => el.name
      }
    end
    render :text => text.to_json
  end
end
