class TagsController < ApplicationController
  def autocomplete
    params
    render :text => '[{"id":"3","label":"Hazel Grouse","value":"Hazel Grouse"},
{"id":"4","label":"Common Quail","value":"Common Quail"}]'
  end
end
