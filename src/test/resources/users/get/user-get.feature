    @smoke
Feature: Get user from JSONPlaceholder

  Background:
    # Usaremos una API más amigable para las pruebas automatizadas
    * url "https://jsonplaceholder.typicode.com"

    @Basic
  Scenario: Get a user
    # En esta API, los usuarios se obtienen directamente por ID
    Given path "/users/1"
    When method get
    Then status 200
    # Verificamos que el ID del usuario en la respuesta sea 1
    And match response.id == 1

    @Read-Json-Fuzzy_matching
  Scenario: Get user list
    Given path "/users"
    When method get
    Then status 200
    And match each response == { id: '#number', name: '#string', username: '#string', email: '#string', address: '#object', phone: '#string', website: '#string', company: '#object' }