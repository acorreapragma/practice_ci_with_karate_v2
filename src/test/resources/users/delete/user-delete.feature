    @regression
Feature: Delete user on JSONPlaceholder

  Background:
    * url "https://jsonplaceholder.typicode.com"

    @Calls-Reused
  Scenario: Delete a user
    # Para esta API, simplemente elegimos un ID para borrar, por ejemplo, el usuario 1.
    # La API de JSONPlaceholder simula la eliminación pero no borra el dato realmente.
    Given path "/users/1"
    When method delete
    # La respuesta esperada para un DELETE exitoso en esta API es 200 OK.
    Then status 200
