*** Settings ***
Resource        robot/Cumulus/resources/NPSP.robot
Library         cumulusci.robotframework.PageObjects
...             robot/Cumulus/resources/ContactPageObject.py
...             robot/Cumulus/resources/AccountPageObject.py
...             robot/Cumulus/resources/OpportunityPageObject.py
...             robot/Cumulus/resources/NPSP.py
Suite Setup     Run keywords
...             Open Test Browser
...             Setup Test Data
Suite Teardown  Delete Records and Close Browser

***Keywords***
# Setup a contact with parameters specified
Setup Test Data
    Setupdata   contact   ${contact1_fields}

*** Variables ***
&{contact1_fields}  Email=test@example.com

*** Test Cases ***

Create Open Recurring Donation With Monthly Installment
    [Documentation]              This test verifies that a Recurring Donation can be created through the UI.

    Go To Page                           Details
    ...                                  Contact
    ...                                  object_id=${data}[contact][Id]
    Click More Actions Button
    Click Link                           link=New Open Recurring Donation
    Wait Until Modal Is Open		
    Populate Modal Form
    ...                                  Recurring Donation Name= Robot Recurring Donation
    ...                                  Amount=100
    ...                                  Installment Period=Monthly
    Click Modal Button                   Save
    Wait Until Modal Is Closed		
    Reload Page		
    Select Tab                           Related
    Check Related List Values            Recurring Donations    Robot Recurring Donation
    Load Related List                    Opportunities
    Click ViewAll Related List           Opportunities
    ${return_value}                      Verify Payment Details
    Should be equal as strings           ${return_value}        12