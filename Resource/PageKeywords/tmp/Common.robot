*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
#Resource     ../PageKeywords/DashBoadKeyword.robot

*** Variables ***
${BICS_SIM}      ${TestData}[URL]
${Browser_Name}  ${TestData}[Browser]


${Environment}      ${TestData}[Environment]
${TimeOut}      60s
${Start}        1s

*** Keywords ***

Verify elements is visible and displayed
    [Documentation]   Keyword to verify locator is enabled and visibled on a page.
    [Arguments]    ${locator}
    wait until element is enabled    ${locator}    timeout=60
    wait until element is visible     ${locator}    timeout=60
    page should contain element      ${locator}     timeout=60
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     wait until page contains element    ${locator}


Print
    [Arguments]    ${message}
    log to console    \n${message}

Execute Suite Setup
    [Documentation]     Open Browser on Test or preproduction environment
    Open chrome on ${Environment}

Execute Suite Setup as ${user}
    [Documentation]     Open Browser on Test or preproduction environment
     Login SIM For Things as ${user}
     Verify user is able to login application as ${user}
     Verify BICS Dashboard
Open ${Browser} on ${Environment}
    [Documentation]     Open broswer based on Browser variable and environemnt.
        run keyword if    '${Browser_Name}' == 'chrome' or '${Browser_Name}' == 'headlesschrome'
    ...             open browser    about:blank   ${Browser_Name}      options=add_argument("--ignore-ssl-errors")
    ...    ELSE    log    ${Browser_Name} is not supported only chrome will suppoert       ERROR
    Print   Finished ==> Open Browser section on ${Environment}


Open ${Application} and Verify page title
    [Documentation]     Open application and verify the page titile is correct or not.
    ${titile} =    run keyword if   '${Application}'=='SIM For Things'
    ...         open ${BICS_SIM} and return title
     ...                     ELSE     log    ${Application} URL is not yet configured!!!      ERROR

    Print   finished => Open ${Application} and Get Page Title
    [Return]    ${titile}

Verify Page title
     [Documentation]   Open application and verify application opened with correct title
     sleep  5s
     ${page_title}=   get title
     should be equal     SIM for Things      ${page_title}
     Print  Finished==>Application Title Verification
open ${URL} and return title
    [Documentation]
    go to   ${URL}
    maximize browser window
    ${page_title}=   get title
    log     ${page_title} page opens      DEBUG
    ${page_title}=   run keyword and return if   '${page_title}'=='Privacy error'    Bypass SSL Error And Get Title
    [Return]    ${page_title}
Bypass SSL Error And Get Title
    log    Bypassing SSL ERROR      WARN
    click button    Advanced
    wait until page contains element    //*[@id="proceed-link"]
    click link    //*[@id="proceed-link"]
    wait until page does not contain        Your connection is not private
    ${page_title}=   get title
    Print   finished => Bypass SSL Error And Get Title
    [Return]    ${page_title}

Execute Suite Teardown
    [Documentation]     Closes all open browsers and resets the browser cache.
    #TODO: add other tasks
    ${present}=     Run Keyword And Return Status    Variable Should Exist    ${download directory}
    IF    ${present}
        Empty Directory    ${download directory}
        Remove Directory    ${download directory}
    END
    close all browsers
    Print   finished => Execute Suite Teardown

input value on text fields
    [Arguments]     ${text}     ${locator}
    should not be empty   ${text}
    #todo text field value reading if anything there.
    input text  ${text}      ${locator}

Execute Suite Setup as User
    [Documentation]     Open Browser on Test or preproduction environment
     Open Browser    ${URL}   ${Broswer}  ${TestData}[Browser]     options=add_argument("--ignore-certificate-errors")
     Maximize browser window

Execute Suite Setup as User to set New Download Directory
    [Documentation]     open Browser on Test or preproduction environment and set the chrome default download location to new directory
    ${now}    Get Time    epoch
    ${download directory}    Join Path    ${CURDIR}     downloads_${now}
    Create Directory    ${download directory}
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs}    Create Dictionary    download.default_directory=${download directory}
    Call Method    ${chrome options}    add_experimental_option    prefs    ${prefs}
#    Create Webdriver    Chrome    chrome_options=${chrome options}
    Open Browser    ${URL}   ${Broswer}  ${TestData}[Browser]     options=${chrome options}
    Maximize Browser Window
    Set Test Variable    ${download directory}

Download should be done
    [Documentation]    Verifies that the directory has only one folder and it is not a temp file.
    [Arguments]    ${directory}     ${regexp}=${EMPTY}      ${downloadInd}=${True}
    Sleep    5s
    ${file}     Set Variable    ${EMPTY}
    IF    ${downloadInd}
        ${files}    List Files In Directory        ${directory}
        Length Should Be    ${files}    1    Should be only one file in the download folder
        sleep   5s
        IF    '${regexp}' != '${EMPTY}'
             Should Match Regexp    ${files[0]}    ${regexp}    File matching with regex pattern
        END
        ${file}    Join Path    ${directory}    ${files[0]}
        Log    File was successfully downloaded to ${file}
    END
    [Return]    ${file}
