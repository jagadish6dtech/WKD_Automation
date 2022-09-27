*** Settings ***
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Variables    ../PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../PageKeywords/LoginPageKeyword.robot
Resource    ../PageKeywords/Common.robot
*** Variables ***
${TimeOut}      60s
${Start}        1s
*** Keywords ***

Verify BICS Dashboard
    [Documentation]     Highlevel keyoword for verifying bics dashboard menu items.
    ...    keyword is verifying all the dashboard div/image/graph.
