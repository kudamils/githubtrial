@gist
Feature: Site Search

  Background: Login to github
    Given User navigate to the homepage
    And User click on Login button
    And user fill username and password
    And user click on sign in button
    And user navigate to gist page

  @create-new-gist
  Scenario: As a user, I want to create a public gist.
    When create a public gist
    Then validate gist created

  @edit-existing-gist
  Scenario: As a user, I want to edit an existing gist.
    When edit an existing public gist

  @delete-existing-gist
  Scenario: As a user, I want to delete an existing gist.
    When delete an existing gist

  @see-gist-list
  Scenario: As a user, I want to see my list
    When see my list of gists