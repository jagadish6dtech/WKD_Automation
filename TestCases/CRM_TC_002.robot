*** Settings ***
Documentation   "-To validate Order Mangement functionalities  and Validate Onboarded Customer details"
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../Resource/PageKeywords/NMS_UI_Keyword.robot
Resource    ../Resource/PageKeywords/SSO_Login_Keyword.robot
Resource    ../Resource/PageKeywords/CRM_UI_Keywords.robot
#Resource    ../Resource/PageKeywords/CRM_UI_Keywords_NEW.robot

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
TEST CASE 002
    [Documentation]     "-To validate Order Mangement functionalities  and Validate Onboarded Customer details"
    Login to SSO UI  ${CRM_CREDENTIAL}[username]  ${CRM_CREDENTIAL}[password]
    #NAVIGATE SSO UI  ${CRM_UI}

    ${UserInfo}=  Fetch From Excel  ${WKD_CRM_TESTDATA}   UserInfo  TC_001  TD_01

    ${PROFILE_ID}=  getData  ${UserInfo}  ProfileId
    ${ACCOUNT_ID}=  getData  ${UserInfo}  AccountID
    ${SERVICE_ID}=  getData  ${UserInfo}  ServiceID



     Search Order By OrderId  TC_001  TD_01
     Search By ID  ${HomePage}[HomeSeachOptionAccountId]  ${ACCOUNT_ID}
     Sleep  10s
     Page should contain  ${ACCOUNT_ID}
     Go Back to Home Page
     Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFILE_ID}
     Sleep  10s
     wait until element is visible    ${ProfileDetailsPage}[ProfileTab]
     Page should contain  ${PROFILE_ID}
     Go Back to Home Page
     Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
     Sleep  10s
     wait until element is visible    ${ServiceDetailsPage}[ServiceTab]
     Page should contain  ${SERVICE_ID}
     View Identification Details  TC_001  TD_01
     View Document Details  TC_003  TD_02
     Go Back to Home Page
     Search By ID  ${HomePage}[HomeSeachOptionContactNumber]  097431917
     Sleep  10s

     Go Back to Home Page




