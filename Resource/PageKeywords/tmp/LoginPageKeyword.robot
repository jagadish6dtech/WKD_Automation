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
${LoginPage}      ${BICS}[LoginPage]
${TimeOut}      60s
${Start}        1s
${LoginPageTestdatas}     ${TestData}[USER][user1]


*** Keywords ***
Login to Application as Specific User
#    wait until element is visible   ${LoginPage}[welcomenote]
#    wait until element is visible   ${LoginPage}[bicslogo]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${LoginPage}[UserName]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${LoginPage}[UserName]      ${LoginPageTestdatas}[username]
    click element   ${LoginPage}[Password]
    input text      ${LoginPage}[Password]      ${LoginPageTestdatas}[password]
    click element   ${LoginPage}[Loginbtn]
    sleep  10s

Logout as User

#    mouse over      xpath=${LoginPage}[UserLogo]
    click element   ${LoginPage}[UserLogo]
#    click element   ${LoginPage}[Logout]
    Sleep   3s
#    mouse over      xpath=${BICS}[LoginPage][UserLogo]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${LoginPage}[Logout]
#    click element   ${BICS}[LoginPage][Logout]


Login to Application as specific User With Arguments
    [Arguments]     ${user}     ${pass}=${LoginPageEntTestdatas}[password]
#    wait until element is visible   ${LoginPage}[welcomenote]
#    wait until element is visible   ${LoginPage}[bicslogo]
    Sleep   5s
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element   ${LoginPage}[UserNameLogo]
    Sleep   5s
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      input text      ${LoginPage}[UserNameLogo]      ${user}
    Sleep   3s
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     input text      ${LoginPage}[PasswordLogo]      ${pass}
    Sleep   3s
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     click element   ${LoginPage}[inputfields][Loginbtn]
    Sleep  5s
    #Verify elements is visible and displayed     ${BICS}[DashBoardPage][dashboardlogo]