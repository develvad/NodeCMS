
class Cantante
  play: (cancion) ->
    @currentlyPlayingSong = cancion
    @isPlaying = true

  pause: ->
    this.isPlaying = false

  resume: ->
    if (@isPlaying)
      throw new Error("La canción ya está en marcha")
    @isPlaying = true

  makeFavorite: ->
    @currentlyPlayingSong.persistFavoriteStatus(true)

