Feature: I would like to log in to the system

  Scenario: Successful login
    Given I am on the login screen
     When I fill in "username" with "athena@olx.com"
      And I fill in "password" with "123456"
      And I tap "login"
     Then I should see "Success!" message

  Scenario: Unsuccessful login
    Given I am on the login screen
     When I fill in "username" with "wrong email"
      And I fill in "password" with "wrong password"
      And I tap "login"
     Then I should see "Failure!" message
