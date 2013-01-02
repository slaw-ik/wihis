# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".chzn-select").chosen();
  markersArray = []
  # On click, clear markers, place a new one, update coordinates in the form
  Gmaps.map.callback = ->
      google.maps.event.addListener(Gmaps.map.serviceObject, 'click', (event) ->
        clearOverlays()
        placeMarker(event.latLng)
        get_address(event.latLng)
        updateFormLocation(event.latLng))

  # Update form attributes with given coordinates
  updateFormLocation = (latLng) ->
      $('section #point_latitude').val(latLng.lat())
      $('section #point_longitude').val(latLng.lng())
      $('#location_attributes_gmaps_zoom').val(Gmaps.map.serviceObject.getZoom())

  # Add a marker with an open infowindow
  placeMarker = (latLng) ->
      marker = new google.maps.Marker(
          position: latLng
          map: Gmaps.map.serviceObject
          draggable: false
      )
      markersArray.push(marker)
      # Set and open infowindow

      infowindow = new google.maps.InfoWindow(
          content: $('#popup-form').html()
      )
      infowindow.open(Gmaps.map.serviceObject,marker)
      validate_form()
#      $(".chzn-select").chosen();

  get_address = (latLng) ->
    $.ajax(
      url: '/get_address'
      type: 'POST'
      data: "latLng="+latLng
    ).success (data) ->
      $('h4.address').text(data)
      $('section #point_address').val(data)

  # Removes the overlays from the map
  clearOverlays = ->
    if markersArray?
      for i in markersArray
        i.setMap(null)
    markersArray.length = 0


#Form validations
#$(document).ready ->
#  $("#new_point").validate()
@validate_form = ->
  $(".map_container #new_point").validate
    rules:
      "user[email]":
        email: true
        required: true

      "point[description]":
        required: true
        minlength: 6

      "user[password_confirmation]":
        minlength: 6
        required: true
        equalTo: "#user_password"

    highlight: (label) ->
      $(label).closest(".control-group").addClass "error"

    success: (label) ->
      label.text("OK!").addClass("valid").closest(".control-group").addClass "success"



#todo
# try to implement another Tgs plugin http://tagedit.webwork-albrecht.de/