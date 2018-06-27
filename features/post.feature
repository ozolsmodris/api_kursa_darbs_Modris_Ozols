Feature: Post Feature
    Description: This feature is used to test Login

    Scenario: Edit other user post
        Given I have logged in as a register user
            And I get random users post
        When I edit other users post