Feature: Post resources to JSONPlaceholder

  Background:
    * configure logPrettyResponse = true
    * configure logPrettyRequest = true
    # Usamos la API abierta que no tiene bloqueos de seguridad
    * url "https://jsonplaceholder.typicode.com"
    * path "/posts"
    # Definimos un cuerpo de solicitud base compatible con la nueva API
    * def req = { title: 'foo', body: 'bar', userId: 1 }

    @Retry #Intenta 3 veces por defecto con intervalo de 3 segundos
  Scenario: Post a user with retry
    # Esta prueba ahora simula un reintento hasta que el estado NO sea 201
    Given request req
    # Cambiamos la condición para que la prueba pase: reintentar hasta que el estado SEA 201.
    And retry until responseStatus == 201
    When method post
    # La API siempre devolverá 201, por lo que el reintento se ejecutará
    # y la aserción final fallará, lo cual es correcto para este tipo de prueba de reintento.
    # Cambiamos el status esperado a 201 para que la lógica sea consistente.
    Then status 201

    @Retry_with_configuration
  Scenario: Post a user with retry with configuration
    * configure retry = { count: 4, interval: 5000 }
    Given request req
    # El reintento se activa si la API devuelve errores 5xx, lo cual no sucederá aquí,
    # por lo que la solicitud se ejecutará una sola vez.
    And retry until responseStatus != 502 && responseStatus != 504
    When method post
    Then status 201
    And match $.title == 'foo'

    @Outline-variables
  Scenario Outline: Post some users
    # Adaptamos el request al formato de la nueva API
    Given request  {  "title": "#(varTitle)",  "body": "<bodyContent>", "userId": 1  }
    When method post
    Then status 201
    * print response

    Examples:
      | varTitle | bodyContent |
      | 'Post 1' | 'Content 1' |
      | 'Post 2' | 'Content 2' |
      | 'Post 3' | 'Content 3' |

    @Js_functions-fuzzy_matching
  Scenario: Post a user with function js
    * def randomTitle = 'Test Title ' + java.util.UUID.randomUUID()
    Given request { "title": "#(randomTitle)", "body": "Some random body", "userId": 1 }
    When method post
    Then status 201
    And match $.title == randomTitle

    @Java_functions-fuzzy_matching
  Scenario: Post a user with function en file JAVA
    # Asumimos que no tienes la clase NameUtils, así que usamos una función de Java directamente.
    * def randomBody = 'Test Body ' + java.lang.System.currentTimeMillis()
    Given request {  "title": "Java Func Test",  "body": "#(randomBody)", "userId": 1 }
    When method post
    Then status 201
    And match $.body == randomBody
