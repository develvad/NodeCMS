(($) ->
#$(document).ready()
    window.mycms = {}

    mycms.NoticiaModel = Backbone.Model.extend(

        urlRoot: '/api/noticia'

        initialize: ->
            console.log "init model noticia"

        parse: (response, options) ->
            if response.status is 200
                return response.noticia
            return response
    )

    mycms.NoticiasCollection = Backbone.Collection.extend(

        model: mycms.NoticiaModel
        url: "/api/noticias"

        initialize: ->
            console.log "init collection noticias"

        parse: (response, options) ->
            if response.status is 200
                return response.noticias
            return response
    )

    # Test model and collection
    #noticia = new mycms.NoticiaModel()
    #noticias = new mycms.NoticiasCollection()

    #console.log noticia # muestro mi modelo
    #console.log noticias # muestro mi coleccion de modelos


    # Main View class. Controlls all events and behaviors of the application.
    mycms.NoticiasNewView = Backbone.View.extend(
        el: $('#mainView')

        # View's contructor.
        # Initialize event listeners, and update DOM elements state.
        initialize: (options) ->
            _.bindAll(@, 'render')
            console.log "Init NoticiasNewView"
            @render()

        render: ->
            template =  _.template( $("#noticiasNewTemplate").html())
            $(@el).html(template)

    )

    # Main View class. Controlls all events and behaviors of the application.
    mycms.PerfilView = Backbone.View.extend(
        el: $('#mainView')

        # View's contructor.
        # Initialize event listeners, and update DOM elements state.
        initialize: (options) ->
            _.bindAll(@, 'render')
            console.log "Init perfilView"
            @render()

        render: ->
            template =  _.template( $("#perfilTemplate").html())
            $(@el).html(template)

    )

    # Main View class. Controlls all events and behaviors of the application.
    mycms.NoticiasView = Backbone.View.extend(
        el: $('#mainView')

        # View's contructor.
        # Initialize event listeners, and update DOM elements state.
        initialize: (options) ->
            _.bindAll(@, 'render')
            console.log "Init NoticiasView"
            @render()

        render: ->
            template = _.template($('#noticiasTemplate').html(), {noticias: @collection.toJSON()})
            this.$el.html(template)
    )

    # Main View class. Controlls all events and behaviors of the application.
    mycms.IndexView = Backbone.View.extend(
        # element
        el: $('#mainView')

        # View's contructor.
        # Initialize event listeners, and update DOM elements state.
        initialize: (options) ->
            _.bindAll(@, 'render')
            console.log "Init IndexView"
            @render()

        render: ->
            template =  _.template( $("#indexTemplate").html())
            $(@el).html(template)

    )

    mycms.SubheaderView = Backbone.View.extend(
        el: $('#subheader')

        events:
            "click .js-dashboard": "home"
            "click .js-perfil": "perfil"
            "click .js-noticias": "noticias"
            "click .js-noticias_new": "noticias_new"


        initialize: (options) ->
            _.bindAll(@, 'render')
            console.log "Init LinksHeaderView"
            @render()

        home: ->
            console.log "home"
            app.navigate("/panel", true)

        perfil: ->
            console.log "perfil"
            app.navigate("/panel/perfil", true)

        noticias: ->
            console.log "noticias"
            app.navigate("/panel/noticias", true)

        noticias_new: ->
            console.log "noticias_new"
            app.navigate("/panel/noticias/new", true)

        render: ->
            template =  _.template( $("#subHeaderTemplate").html())
            $(@el).append(template)
    )


    # Creamos el Backbone Router, quien "escuchará los cambios en la URL
    # y ejecutará las respectivas acciones"
    mycms.AppRouter = Backbone.Router.extend(

        # Rutas : accion
        routes:
            "panel":                "index",
            "panel/perfil":         "perfil",
            "panel/noticias":       "noticias",
            "panel/noticias/new":   "noticias_new"

        initialize: ->
            console.log "init router"
            @SubheaderView = new mycms.SubheaderView()

        index: ->
            console.log "router index"
            @IndexView = new mycms.IndexView()

        perfil: ->
            console.log "router perfil"
            @PerfilView = new mycms.PerfilView()

        noticias: ->
            console.log "router noticias"
            col = new mycms.NoticiasCollection()
            # Usamos método de Backbone .fetch que lanzará una petición GET ajax a /noticias
            # Usamos método de Backbone .save que lanzará una petición POST ajax a /noticias
            # Usamos método de Backbone .save que lanzará una petición PUT ajax a /noticias
            # Usamos método de Backbone .destroy que lanzará una petición DELETE ajax a /noticias
            # (si el objeto modelo tiene _id -si no es nuevo)
            ###
            params = {
                title: "pepe"
                descripcion: "lalala"
            }
            # Esto lanza un AJAX POST a /noticias
            modelo.save(params)
            # Esto lanza un AJAX PUT a /noticias (Ya existe ese modelo en el server)
            modelo.save(params)


            #$.ajax('/api/noticias', ......)
            ###
            col.fetch(
                wait:true,
                success: (collection, response, options) =>
                    console.log "fetched noticias"
                    console.log collection
                    console.log response
                    # Ya tenemos nuestra Collección con 50 noticias
                    # Ahora creamos la vista y le pasamos la colección para que las muestre
                    @NoticiasView = new mycms.NoticiasView(
                        collection: collection
                    )
            )

        noticias_new: ->
            console.log "router noticias New"
            @NoticiasNewView = new mycms.NoticiasNewView()

    )

    # start backbone routing
    app = new mycms.AppRouter()
    Backbone.history.start(pushState: true)

) (jQuery)

