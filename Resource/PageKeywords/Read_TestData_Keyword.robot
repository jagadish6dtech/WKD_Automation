*** Settings ***

Library  ../TestData/ReadDataFromExcel.py
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../../Resource/PageKeywords/Common.robot
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
${TimeOut}      60s
${Start}        1s


*** Keywords ***
Read Number of Rows
    [Arguments]  ${filename}  ${sheetname}
    ${maxr}=  fetch_no_rows  ${filename}  ${sheetname}
    [Return]  ${maxr}

Read Excel Data of cell
    [Arguments]  ${filename}  ${sheetname}  ${row}  ${cell}
    ${celldata}=  fetch_cell_data  ${filename}  ${sheetname}  ${row}  ${cell}
    [Return]  ${celldata}

Fetch From Excel
    [Arguments]  ${filename}  ${sheetname}  ${TestCaseID}  ${TestDataID}
    ${celldata}=  fetch_from_ExcelData  ${filename}  ${sheetname}  ${TestCaseID}  ${TestDataID}
    [Return]  ${celldata}

Dummy Keyword
    ${celldata}=  dummy
    [Return]  ${celldata}

OnboardingEKYC API
    [Arguments]  ${MSISDN}  ${ICCID}  ${IMSI}  ${FAMILYNAME}
    ${ORDER_ID}=  OnBoarding_API  ${MSISDN}  ${ICCID}  ${IMSI}  ${FAMILYNAME}
    [Return]  ${ORDER_ID}

