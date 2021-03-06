#= require application

geocodeResult = (city, state) ->
  [
    address_components: [
      null,
      null,
      long_name: city,
      null,
      short_name: state
    ]
  ]

ExampleApp.TestSupport =
  stubSuccessfulGoogleResponse: (city, state) ->
    window.google =
      maps:
        LatLng: (latitude, longitude) ->
          'latlng'

        Geocoder: ->
          geocode: (latLng, callback) ->
            callback(geocodeResult(city, state), 'OK')

  stubUnsuccessfulGoogleResponse: ->
    window.google =
      maps:
        LatLng: (latitude, longitude) ->
          'latlng'

        Geocoder: ->
          geocode: (latLng, callback) ->
            callback(null, 'BAD')

  stubSuccessfulGoogleMapsResponse: ->
    window.google =
      maps:
        event:
          trigger: (object, action) ->
            true

        LatLngBounds: ->
          extend: (latlng) ->
            @extendedBounds = latlng

          getCenter: ->
            'center'

        LatLng: (latitude, longitude) ->
          latitude: latitude
          longitude: longitude

        Map: (selector, options) ->
          fitBounds: (bounds) ->
            true

          setCenter: (center) ->
            true

        MapTypeId: ->
          SATELLITE: 'satellite'

        Marker: (position, map) ->
          true
