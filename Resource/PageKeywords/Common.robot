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
${SCREENSHOT_LOC}  ${TestData}[SCREENSHOT_LOC]
${TimeOut}      60s
${Start}        1s

*** Keywords ***

Verify elements is visible and displayed
    [Documentation]   Keyword to verify locator is enabled and visibled on a page.
    [Arguments]    ${locator}
    wait until element is enabled    ${locator}    timeout=60
    SeleniumLibrary.wait until element is visible    ${locator}    timeout=60
    SeleniumLibrary.page should contain element      ${locator}     timeout=60
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}     SeleniumLibrary.wait until page contains element    ${locator}


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

Set Radio Button
     [Arguments]     ${label}  ${value}
     ${Is_Checkbox_Selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    //span[text()='${label}']/preceding-sibling::span//input
     Log To Console  ************************************
     Log To Console  ${Is_Checkbox_Selected}
     Log To Console  ************************************
     #Verify elements is visible and displayed  //input[@type='radio']
     #Select Radio Button   ${label}  ${value}
     Click Item  //span[text()='${label}']/preceding-sibling::span//input


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



Click Item
    [Arguments]     ${locator}
    Verify elements is visible and displayed  ${locator}
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      SeleniumLibrary.click element      ${locator}

Handle PopUp
    [Arguments]     ${locator}  ${Expectedvalue}
    Verify elements is visible and displayed  ${locator}
    ${String}=  SeleniumLibrary.get text     ${locator}
    Log To Console  ------------------------
    Log To Console  ${String}
    Log To Console  ------------------------
    Should be equal  ${String}   ${Expectedvalue}


Set Dropdown
    [Arguments]     ${dropdown}  ${locator_label}

    #Log To Console  ${locator_label}
    #Verify elements is visible and displayed  ${dropdown}
    Click Item  ${dropdown}
    #wait until element is visible    ${dropdown}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${dropdown}
    ${bool}=    Execute Javascript      var a = document.querySelectorAll('input[type=radio]');for(var i=0;i<a.length;i++){if(a[i].checked==true && a[i].nextSibling.innerHTML.trim() === '${locator_label}') return true; else return false;}
    Log To Console  ------------------------
    Log To Console  ${bool}
    Log To Console  ------------------------
    IF    not ${bool}
        #Wait until element is visible    //label[text()='${locator_label}']
        #Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   //label[text()='${locator_label}']
        Click Item  //label[text()='${locator_label}' and @md='10']
        #Click Item  //label[text()='${locator_label}']
    END

#Set Radio Button
#     [Arguments]     ${label}  ${value}
#     Verify elements is visible and displayed  //input[@type='radio']
#     Select Radio Button   ${label}  ${value}

Set Input
    [Arguments]     ${locator}  ${value}

    #wait until element is visible    ${locator}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${locator}

    Click Item  ${locator}

    Run Keyword If  '${value}' == 'nan'  Log To Console  NANACONDITION
    ...  ELSE IF  '${value}' == 'BLANK'  Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      SeleniumLibrary.input text      ${locator}  \
    ...  ELSE  Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      SeleniumLibrary.input text      ${locator}  ${value}




Set Dropdown2
    [Arguments]     ${dropdown}  ${locator_li}

    Click Item  ${dropdown}
    Click Item  //li[text()='${locator_li}']



Search By ID
    [Arguments]     ${option}  ${id}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${option}
    Click Item  ${option}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      input text      ${HomePage}[HomeSearchBar]      ${id}
    Set Input  ${HomePage}[HomeSearchBar]      ${id}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element   ${HomePage}[HomeSearchButton]
    Click Item  ${HomePage}[HomeSearchButton]


Set Dropdown3
    [Arguments]     ${dropdown}  ${locator_label}

    #Log To Console  ${locator_label}
    #Verify elements is visible and displayed  ${dropdown}
    Click Item  ${dropdown}
    #wait until element is visible    ${dropdown}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${dropdown}
    ${bool}=    Execute Javascript      var a = document.querySelectorAll('input[type=radio]');for(var i=0;i<a.length;i++){if(a[i].checked==true && a[i].nextSibling.innerHTML.trim() === '${locator_label}') return true; else return false;}
    Log To Console  ------------------------
    Log To Console  ${bool}
    Log To Console  ------------------------
    IF    not ${bool}
        #Wait until element is visible    //label[text()='${locator_label}']
        #Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   //label[text()='${locator_label}']
        Click Item  //div[text()='${locator_label}']
    END

TakePic
    [Arguments]     ${picname}

    Seleniumlibrary.capture page screenshot  ${SCREENSHOT_LOC}/${picname}

Set dropdown4
    [Arguments]     ${dropdown}  ${Year}

    #Log To Console  ${locator_label}
    #Verify elements is visible and displayed  ${dropdown}
    Click Item  ${dropdown}
    #wait until element is visible    ${dropdown}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${dropdown}
    ${bool}=    Execute Javascript      var a = document.querySelectorAll('input[type=radio]');for(var i=0;i<a.length;i++){if(a[i].checked==true && a[i].nextSibling.innerHTML.trim() === '${Year}') return true; else return false;}
    Log To Console  ------------------------
    Log To Console  ${bool}
    Log To Console  ------------------------
    IF    not ${bool}
        #Wait until element is visible    //label[text()='${locator_label}']
        #Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   //label[text()='${locator_label}']
        Click Item  //option[text()='${Year}']
    END

Set Dropdown5
    [Arguments]     ${dropdown}  ${locator_label}

    #Log To Console  ${locator_label}
    #Verify elements is visible and displayed  ${dropdown}
    Click Item  ${dropdown}
    #wait until element is visible    ${dropdown}
    #Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${dropdown}
    ${bool}=    Execute Javascript      var a = document.querySelectorAll('input[type=radio]');for(var i=0;i<a.length;i++){if(a[i].checked==true && a[i].nextSibling.innerHTML.trim() === '${locator_label}') return true; else return false;}
    Log To Console  ------------------------
    Log To Console  ${bool}
    Log To Console  ------------------------
    IF    not ${bool}
        #Wait until element is visible    //label[text()='${locator_label}']
        #Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   //label[text()='${locator_label}']
        #Click Item  //label[text()='${locator_label}' and @md='10']
        Click Item  //label[text()='${locator_label}']
    END




#