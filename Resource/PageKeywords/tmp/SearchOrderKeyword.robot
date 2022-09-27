*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../../Resource/PageKeywords/Common.robot
Library  OnBoardingAPI.py

*** Variables ***
${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]
${OrderSearch}      ${BICS}[OrderSearch]
${TimeOut}      120s
${Start}        1s
${LoginPageTestdatas}     ${TestData}[USER][user1]
${Orderid}=  OnBoardingAPI.OnBoarding_API

*** Keywords ***
Search Order By OrderId
#    wait until element is visible   ${LoginPage}[welcomenote]
#    wait until element is visible   ${LoginPage}[bicslogo]
#    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${OrderSearch}[Ordertab]
#    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${OrderSearch}[viewOrder]
    click element   ${OrderSearch}[Ordertab]
    sleep  5s
    click element   ${OrderSearch}[viewOrder]
    sleep  5s
    click element   ${OrderSearch}[Ordertype]
    sleep  5s
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element   ${OrderSearch}[OrderSearchbar]
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      input text      ${OrderSearch}[OrderSearchbar]      955731433640275968
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      input text      ${OrderSearch}[OrderSearchbar]      ${Orderid}
    click element   ${OrderSearch}[SearchButton]
    Sleep   10s
    click element   ${OrderSearch}[OrderAction]
    Sleep   5s
    click element   ${OrderSearch}[OrderView]
    Sleep   10s

    #Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${LoginPage}[UserName]      ${Login
