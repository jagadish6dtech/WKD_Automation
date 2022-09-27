*** Settings ***
Documentation   Sample TestCase For Automation FrameWork
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

Library  OperatingSystem
Suite Setup  Setup chromedriver

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

*** Keywords ***
Setup chromedriver
  Set Environment Variable  webdriver.chrome.driver  C:/Users/abhishek.jayalal/Desktop/Wakanda/20-06-2022/wkd_auto-20-06-2022/venv/Scripts/chromedriver.exe

*** Test Cases ***
TEST CASE 001
    [Documentation]     Sample TestCase For Automation FrameWork
    Login to SSO UI  ${CRM_CREDENTIAL}[username]  ${CRM_CREDENTIAL}[password]
    NAVIGATE SSO UI  ${CRM_UI}
#-----------------------------------------------------------------------------------------------

    Manage Profile Residential Address two  TC_001  TD_01           #completed 1
    Manage Profile Permanent Address two  TC_001  TD_01             #completed 1
    Manage Service Address One  TC_001  TD_01                      #completed 1
    Edit Profile Details two  TC_001  TD_01                         #completed 1
    Edit Service Details two  TC_001  TD_01                        #completed 1
    Edit Account Details two  TC_001  TD_01                        #completed 1
    Manage Account Address One  TC_001  TD_02                      #completed 1
    View Identification Details  TC_001  TD_01     #complete        1
    Filter Ticket By Status Open    TC_001  TD_01  #complete        1
    #Create Ticket  TC_001  TD_01                                     #completed 1





