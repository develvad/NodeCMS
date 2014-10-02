$(document).on('ready', function(){



  // EJEMPLO 1
  // Usando petición ajax con "callback" como parámetro
  /*
  $.getJSON('/noticias', function(response){
    console.log(response);
  });
  */
  /*

  */
  // Se crea el objeto Deferred "interruptor"
  // tiene varios estados "pendiente", "resuelto", "rechazado" los más importantes
  // cuando se crea está en estado "pendiente"
  /*
  var deferred = new $.Deferred(); // deferred está en pendiente
  console.log(deferred);
  console.log(deferred.promise());
  */

  // Retornar Promise
  // deferred.promise(); // Esto se usa en la funcion que queremos "esperar"
  // El motivo de retornar una promise en lugar del propio objeto deferred es evitar la manipulación
  // fuera del contexto de la petición ajax.



  // ** Importante ***
  // Los metodos AJAX de jquery, ya retornan por defecto objetos promises
  // Sin saberlo, cuando haciamos una llamada como la anterior, ya estabamos usando deferreds y promises.

  // EJEMPLO 2
  // Usando petición ajax sin callback, "llamada limpia" usando deferred/promises
  // Ejecuta la llamada a /noticias y cuando la respuesta sea enviada,
  // Ajax pasa a "resolve" su deferred interno
  /*
  var promise = $.getJSON('/noticias');

  // Promise se queda en escucha hasta que el deferred cambie a estado "resolve",
  // que aquí lo hace ajax automáticamente cuando se retorna "algo"
  promise.done(function(response){
    console.log(response);
  });

  promise.fail(function(response){
    console.log("La Llamada ajax falló");
  });
  */


  // EJEMPLO 3 USANDO Deferred y Promise en cualquier uso que no sea AJAX
  // NORMALMENTE se usan los deferred/promises para peticiones ajax, pero también se pueden utilizar para otras cosas
  // Siempre los objetos AJAX retornan objetos promises
  /*
  function espera() {
    var deferred = $.Deferred();

    setTimeout(function() {
      // Si se ejecuta el código de aquí, es porque ya esperamos 5 segundos
      // Una vez pasados 5 segundos, se pasa el deferred a resuelto
      // una vez realizado esto,
      deferred.resolve();
    }, 5000);

    // Siempre que se trabajan con deferred y promises, al final se retorna un objeto PROMISE
    // PROMISE es el "escuchante", que está esperando que se cambie su estado para ejecutar "algo"
    return deferred.promise();
  }

  // Llamamos a ESPERA, guardando el promise que retorna
  promise = espera();
  // Cuando el deferrede de la función wait se pase a "resolve" resuelto, ejecuta lo siguiente
  // .done significa "hecho"
  promise.done(function() {
    console.log("He esperado 5 segundos!!");
  });
  */

  // Cuando se usan deferreds y promises, los métodos más usuales son
  // .promise() para retornar un promise de un deferred reducido "como lectura"
  // .done() lo que esté en su interior, se ejecutará cuando el deferred cambia a estado resolve
  // $.when(funcion1, funcion2, funcion3) se usa para encadenar funciones por las que tenemos que esperar antes de realizar algo
  // por ejemplo tenemos que esperar por 3 llamadas AJAX antes de ejecutar algo,
  // porque queremos trabajar con los resultados de las 3 peticiones.
  // En este caso se encadenan las funciones con .when así

  /*
  $.when($.getJSON('/noticias'),  $.getJSON('/noticias'),  $.getJSON('/noticias'), $.getJSON('/noticias'))
  .done(function(retornadoFunc1,retornadoFunc2,retornadoFunc3, retornadoFunc4){
    console.log(retornadoFunc1[0]);
    console.log(retornadoFunc2[0]);
    console.log(retornadoFunc3[0]);
    console.log(retornadoFunc4[0]);
    console.log("Esto se ejecuta cuando se hayan realizado correctamente las 3 peticiones AJAX");
  });
  */
  // o así
  /*
  promise = $.when($.getJSON('/noticias'),  $.getJSON('/noticias'),  $.getJSON('/noticias'));

  promise.done(function(retornadoFunc1, retornadoFunc2, retornadoFunc3){
    console.log(retornadoFunc1);
    console.log(retornadoFunc2);
    console.log(retornadoFunc3);
    console.log("Esto se ejecuta cuando se hayan realizado correctamente las 3 peticiones AJAX");
  });
  */

});
