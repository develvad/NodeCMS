// Generated by CoffeeScript 1.6.2
var Cantante;

Cantante = (function() {
  function Cantante() {}

  Cantante.prototype.play = function(cancion) {
    this.currentlyPlayingSong = cancion;
    return this.isPlaying = true;
  };

  Cantante.prototype.pause = function() {
    return this.isPlaying = false;
  };

  Cantante.prototype.resume = function() {
    if (this.isPlaying) {
      throw new Error("La canción ya está en marcha");
    }
    return this.isPlaying = true;
  };

  Cantante.prototype.makeFavorite = function() {
    return this.currentlyPlayingSong.persistFavoriteStatus(true);
  };

  return Cantante;

})();
