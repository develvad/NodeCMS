beforeEach( ->

  jasmine.addMatchers(
    toBePlaying: ->
      return {
        compare: (actual, expected) ->
          cantante = actual

          return {
            pass: cantante.currentlyPlayingSong is expected and cantante.isPlaying
          }
      }

  )
)
