Feature: Login
  As an user, I want to be able to login on the app

    Scenario: Entering as an user
        Given I wait until the "Login" is present
        When I fill the "Email" field with "clara@gmail.com"
        And I fill the "Password" field with "sigarra"
        When I tap the "loginButton" button
        Then I wait until the "Login" is absent