*** Settings ***
Documentation   "View Audit History"
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../Resource/PageKeywords/NMS_UI_Keyword.robot
Resource    ../Resource/PageKeywords/SSO_Login_Keyword.robot
Resource    ../Resource/PageKeywords/CRM_UI_Keywords.robot


Resource    ../Resource/PageKeywords/Read_TestData_Keyword.robot
Library  ../Resource/TestData/Provision_Functions.py
Library  ../Resource/TestData/ReadDataFromExcel.py

Variables    ../Resource/PageObjects/PageObjects.yaml
Variables    ../Resource/PageObjects/TestData.yaml
Resource     ../Resource/PageKeywords/Common.robot

Test Setup        Execute Suite Setup as User
Test Teardown     Execute Suite Teardown

*** Variables ***

${CRM_TestData}     ${TestData}[CRM_TestData]
${CRM_CREDENTIAL}     ${TestData}[USER][crm_user]
${CRM_UI}  ${wkd}[SSOPage][crm]
${ProfileDetailsPage}  ${CRMPage}[ProfileDetailPage]
${AccoutDetailPage}  ${CRMPage}[AccoutDetailPage]
${ServiceDetailsPage}  ${CRMPage}[ServiceDetailsPage]
${HomePage}  ${CRMPage}[HomePage]        # Importing Home page Components

*** Test Cases ***
TEST CASE 011
    [Documentation]     "View Audit History"
    Login to SSO UI  ${CRM_CREDENTIAL}[username]  ${CRM_CREDENTIAL}[password]

    ${row}=  Read Number of Rows  ${WKD_CRM_TESTDATA}   AuditHistory_1
    Log To Console    ${row}
    AuditHistory  ${row}
    sleep  10s







