Feature: Login
  As an user, I want to be able to login on the app

	Scenario: Entering as an user
	    Given I am on the "Login" page
	    When I fill the "Email" field with "clara@gmail.com"
      And I fill the "Password" field with "sigarra"
      Then I tap the "loginButton" button
	  