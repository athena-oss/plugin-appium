Feature: I would like to do a request to the Appium server

	Scenario: Successful request
		Given I perform a request to "http://athena-appium:4723/wd/hub/sessions"
		Then I should get a "200" status code
