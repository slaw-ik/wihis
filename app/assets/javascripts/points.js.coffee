# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
#  Gmaps.map.HandleDragend = (pos) ->
#    geocoder = new google.maps.Geocoder()
#    geocoder.geocode
#      latLng: pos
#    , (responses) ->
#      if responses and responses.length > 0
#        alert responses[0].formatted_address
#      else
#        alert "Cannot determine address at this location."

  markersArray = []
  # On click, clear markers, place a new one, update coordinates in the form
  Gmaps.map.callback = ->
#      i = 0
#      while i < @markers.length
#        google.maps.event.addListener Gmaps.map.markers[i].serviceObject, "dragend", ->
#          Gmaps.map.HandleDragend @getPosition()
#        ++i
#      google.maps.event.addListener(Gmaps.map.serviceObject, 'click', (event) ->
#        clearOverlays()
#        placeMarker(event.latLng)
#        get_content(event.latLng)
#        updateFormLocation(event.latLng))


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
      # Listen to drag & drop
      google.maps.event.addListener(marker, 'dragend', ->
          updateFormLocation(this.getPosition())
      )

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


