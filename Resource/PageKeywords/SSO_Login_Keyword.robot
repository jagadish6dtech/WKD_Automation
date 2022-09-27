*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String

Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../../Resource/PageKeywords/Common.robot

*** Variables ***
${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]

${LoginPage}      ${WKD}[LoginPage]
${SSO}      ${WKD}[SSOPage]
${TimeOut}      60s
${Start}        1s



*** Keywords ***

Login to SSO UI
    [Arguments]  ${user}  ${pass}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${LoginPage}[UserName]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${LoginPage}[UserName]      ${user}
    click element   ${LoginPage}[Password]
    input text      ${LoginPage}[Password]     ${pass}
    click element   ${LoginPage}[Loginbtn]
    sleep  10s


NAVIGATE SSO UI
    [Arguments]  ${ui}
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${ui}
    Sleep  10s
    Switch Window    new
    Sleep  5s