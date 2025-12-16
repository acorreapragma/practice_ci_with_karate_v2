    @smoke @regression
Feature: Reusable scenarios for post a user

    # Migramos a una API más amigable para la automatización
  Background:
    * url "https://jsonplaceholder.typicode.com"

    @Create-user
  Scenario: Post a user
    * path "/posts"
    # Adaptamos el cuerpo de la solicitud al formato de la nueva API
    Given request { title: 'foo', body: 'bar', userId: 1 }
    When method post
    Then status 201
    And def contactId = $.id

    @Create-user-table-variable
  Scenario: Post a user with table and variable received
    * path "/posts"
    # Adaptamos el cuerpo de la solicitud al formato de la nueva API
    Given request { title: '#(data.title)', body: '#(data.body)', userId: 1 }
    When method post
    Then status 201
    And def contactId = $.id

    @Create-user-only-table
  Scenario: Post a user with only table received
    * path "/posts"
    # Adaptamos el cuerpo de la solicitud al formato de la nueva API
    Given request { title: '#(title)', body: '#(body)', userId: 1 }
    When method post
    Then status 201
    And def contactId = $.id
    * print "el id del usuario creado es " + contactId
