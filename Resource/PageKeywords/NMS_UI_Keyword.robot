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
${TimeOut}      60s
${Start}        1s
${SSO}      ${WKD}[SSOPage]
${NMS}            ${WKD}[NMSPage]


*** Keywords ***
ACCESS NMS UI as nms user
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${SSO}[nms]
    Sleep  10s
    Switch Window    new
    Sleep  5s

CREATE SUPPLIER in NMS UI
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[search]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${NMS}[search]      Configuration
    Sleep  3s
    click element   ${NMS}[configurtion]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${NMS}[search]      Configuration
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Supplier]
    Sleep  3s

CREATE SUPPLIER PROFILE in NMS UI
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[search]
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${NMS}[search]      Configuration
    Sleep  3s
    click element   ${NMS}[configurtion]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${NMS}[search]      Configuration
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[profile]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Create]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[close]

CREATE STOCK IMSI in NMS UI
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Stock]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[IMSI]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Create]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[close]

CREATE STOCK ICCID in NMS UI
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Stock]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[ICCID]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Create]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[close]


CREATE STOCK MSISDN in NMS UI
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Stock]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[MSISDN]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Create]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Cancel]

CREATE PROCUREMENT in NMS UI
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      input text      ${NMS}[search]      procurement
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[PROCUREMENT]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Create]
    Sleep  3s
    Wait Until Keyword Succeeds     ${TimeOut}      ${Start}      click element   ${NMS}[Cancel]

