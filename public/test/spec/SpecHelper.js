// Generated by CoffeeScript 1.6.2
beforeEach(function() {
  return jasmine.addMatchers({
    toBePlaying: function() {
      return {
        compare: function(actual, expected) {
          var cantante;

          cantante = actual;
          return {
            pass: cantante.currentlyPlayingSong === expected && cantante.isPlaying
          };
        }
      };
    }
  });
});
