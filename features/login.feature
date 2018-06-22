Feature: Login Feature
    Description: This feature is used to test Login

    @editProfile
    Scenario: Login positive
        Given I have logged in as a register user
        Then I can access my profile information
        When I change First and Last name to new
        Then I check if profile information is changed
          And I change user information back to original