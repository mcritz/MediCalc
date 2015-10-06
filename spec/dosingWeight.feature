Feature: Patient info view
As a patient
I want an application UI
So that I can enter vital statics and get a treament estimate.

Scenario: Dosing Weight UI
Given I am a patient
And an information view
When I load the app
Then I see a label for dosing weight
And I see a UI control for dosing weight

Scenario: Concentration UI
Given I am a patient
And an information view
When I load the app
Then I see a label for concentration
And I see a UI control for concentration

Scenario: Treatment estimate
Given I am a patient
And an information view
When I fill dosing weight
And I fill concentration
Then I see a label for Prostacyclin ml/hr
Then I see an estimate of my Prostacyclin ml/hr

Scenario: Persistent storage
Given I am a patient
And an information view
And a previous session with | acceptable data |
When I load the app
Then I see a label for dosing weight
And UI control is set to | previous weight |
And I see a label for concentration
And I see | previous concentration |
And I see a label for Prostacyclin ml/hr
And I see an estimate of my Prostacyclin ml/hr
