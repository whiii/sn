Feature: Manage photos
    
  Scenario: Uploading new photo
    Given user with email:"Me@asd.aa" and password:"qweasd"
    And user with email "Me@asd.aa" has album "My album"
    When I sign in as "Me@asd.aa/qweasd"
    And I go to the album "My album" of user with email "Me@asd.aa"
    Then I should see "Add photo"

    When I follow "Add photo"
    Then I should be on the new photo page for album "My album" of user with email "Me@asd.aa"
    And I should see "Add photo to &laquoMy album&raquo"
    And I should see "Back to album"

    When I choose "kitty.jpeg" file for "Image"
    And I fill in "Comment" with "My Kitty"
    And I press "Upload"
    Then I should be on the album "My album" of user with email "Me@asd.aa"
    And I should see "My Kitty"

  Scenario: Deleting photo
    Given user with email:"Me@asd.aa" and password:"qweasd"
    And user "Me@asd.aa/qweasd" uploaded "kitty.jpeg" in "My album"
    When I sign in as "Me@asd.aa/qweasd"
    And I go to the album "My album" of user with email "Me@asd.aa"
    And I should see "kitty.jpeg"
    And I follow "Delete"
    Then I should be on the album "My album" of user with email "Me@asd.aa"
    And I should not see "kitty.jpeg"