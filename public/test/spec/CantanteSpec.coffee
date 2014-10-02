
describe("Cantante", =>

  cantante = new Cantante()
  cancion = new Cancion()

  beforeEach( =>
    cantante = new Cantante()
    cancion = new Cancion()
  )

  # Test "suelto"
  it("debería ser capaz de tocar una cancion", ->
    bool = cantante.play(cancion) # debería de devolver un true, si OK, o false si no

    expect(bool).toEqual(true)


    # TEST
    expect(cantante.currentlyPlayingSong).toEqual(cancion)

    # Muestra el uso de "matchers" personalizados
    #expect(cantante).toBePlaying(cancion)
  )





  # Agrupamos varios Test en un "describe"
  describe("Cuando una canción ha sido pausada ...", =>

    beforeEach( =>
      cantante.play(cancion)
      cantante.pause()
    )


    # Primer test del grupo
    it("debería indicar que canción está actualmente en pausa", =>
      cantante.play(cancion)
      cantante.pause()

      expect(cantante.isPlaying).toBeFalsy() # si esto se cumple TEST OK

      # demonstrates use of 'not' with a custom matcher
      # expect(cantante).not.toBePlaying(cancion)
    )

    # Segundo Test
    it("Debería ser posible darle a continuar", =>
      cantante.resume()
      expect(cantante.isPlaying).toBeTruthy()   # MAtchers de Jasmine
      expect(cantante.currentlyPlayingSong).toEqual(cancion)
    )
  ) # Fin de este grupo de test




  # El uso de "spies" para interceptar si se llama al método que queremos o no
  it("Dice si la canción actual está como favorita", =>
    spyOn(cancion, 'persistFavoriteStatus');

    cantante.play(cancion)
    cantante.makeFavorite()

    expect(cancion.persistFavoriteStatus).toHaveBeenCalledWith(true)
  )

  # demonstrates use of expected exceptions
  describe("#resume", =>
    it("Debería lanzar una excepción si la canción ya está en marcha", =>
      cantante.play(cancion)

      expect( =>
        cantante.resume();
      ).toThrowError("La canción ya está en marcha");
    )
  )


)
