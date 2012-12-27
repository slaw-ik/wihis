# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#$ ->
#  Gmaps.map.callback = ->
#    google.maps.event.addListener Gmaps.map.serviceObject, "click", (event) ->
#      clearOverlays()
#      placeMarker event.latLng

$ ->
  markersArray = []
  # On click, clear markers, place a new one, update coordinates in the form
  Gmaps.map.callback = ->
      google.maps.event.addListener(Gmaps.map.serviceObject, 'click', (event) ->
        clearOverlays()
        placeMarker(event.latLng)
        updateFormLocation(event.latLng))

  # Update form attributes with given coordinates
  updateFormLocation = (latLng) ->
      $('#location_attributes_latitude').val(latLng.lat())
      $('#location_attributes_longitude').val(latLng.lng())
      $('#location_attributes_gmaps_zoom').val(Gmaps.map.serviceObject.getZoom())

  # Add a marker with an open infowindow
  placeMarker = (latLng) ->
      marker = new google.maps.Marker(
          position: latLng
          map: Gmaps.map.serviceObject
          draggable: true
      )
      markersArray.push(marker)
      # Set and open infowindow
      $('#popup-form .coords p').text(latLng)
#      $.ajax(
#        url: '/get_address'
#        type: 'POST'
#        data: latLng
#      ).done = (data) ->
#        alert data
      infowindow = new google.maps.InfoWindow(
          content: $('#popup-form').html()
      )
      infowindow.open(Gmaps.map.serviceObject,marker)
      # Listen to drag & drop
      google.maps.event.addListener(marker, 'dragend', ->
          updateFormLocation(this.getPosition())
      )

  # Removes the overlays from the map
  clearOverlays = ->
    if markersArray?
      for i in markersArray
        i.setMap(null)
    markersArray.length = 0
