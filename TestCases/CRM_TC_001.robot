*** Settings ***
Documentation   "-To Search , view and Edit  customer details  under Service ID ,Profile ID ,and  Account ID"
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
TEST CASE 001
    [Documentation]     "-To Search , view and Edit  customer details  under Service ID ,Profile ID ,and  Account ID"
    Login to SSO UI  ${CRM_CREDENTIAL}[username]  ${CRM_CREDENTIAL}[password]


   # Manage Service Address One   TC_001  TD_02
  #  Edit Service Details two     TC_001  TD_02
 #   Manage Profile Residential Address two  TC_001  TD_02
#    Manage Profile Permanent Address two  TC_001  TD_02
#    Edit Account Details two  TC_001  TD_01                         #SCREEN ISSUE - DATA SUBMISSION
#    Manage Account Address One  TC_001  TD_01
#    Edit Profile Details two  TC_001  TD_01                   #CHANGE IN THE SCREEN *****
    # Edit Profile Details at Enterprise Level      TC_001  TD_02


    #Sleep  10s
    #Filter Ticket By Status Open    TC_001  TD_01
    #Update HLR Status  TC_001  TD_01
   # Create Ticket  TC_001  TD_03
    Sleep   10s




