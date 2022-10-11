*** Settings ***
Documentation   "Service level functionalities for Enterprice level customer"
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
TEST CASE 017
    [Documentation]     "Service level functionalities for Enterprice level customer"
    Login to SSO UI  ${CRM_CREDENTIAL}[username]  ${CRM_CREDENTIAL}[password]


#    #Change Status To Bar Service     TC_001  TD_01         #424 :: Connection refused while invoki
#    View Transcation History          TC_001  TD_01
#    Plan Subscriptions                TC_001  TD_01
#    OrderDetails in Service           TC_001  TD_01
#    Notification Deatails             TC_001  TD_01
#    #change SIM ID                    TC_001  TD_01         # Api.comerrorcode400
#    View HLR Details                  TC_017  TD_04
#    Manage Service Address One        TC_001  TD_02
#    #Change Status To UnBar Service   TC_001  TD_01      #424 :: Connection refused while invoki
#    Update HLR Status    TC_001  TD_01
     Edit Service Details two          TC_001  TD_02
#    View and Update Language          TC_001  TD_02








