Feature: Login
  As an user, I want to be able to login on the app

	Scenario: Entering as an user
	    Given I am on the Login page
	    When I login with valid credentials
	    Then I am logged in