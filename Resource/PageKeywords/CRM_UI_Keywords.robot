*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ../../Resource/PageKeywords/Common.robot
Library  ../TestData/ReadDataFromExcel.py

Library     OperatingSystem
Library     SeleniumLibrary
Library    Collections
Library    String
Library    ReadDataFromExcel
Library    AppiumLibrary
Variables    ../../Resource/PageObjects/PageObjects.yaml
Variables    ../../Resource/PageObjects/TestData.yaml
Resource     ./Common.robot
Resource    Read_TestData_Keyword.robot


*** Variables ***
${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]
${OrderSearch}      ${CRMPage}[OrderSearch]
${LoginPage}      ${CRMPage}[LoginPage]
${TimeOut}      60s
${Start}        1s

${URL}      ${TestData}[URL]
${Broswer}  ${TestData}[Browser]
${Environment}      ${TestData}[Environment]
${OrderSearch}      ${CRMPage}[OrderSearch]
${TimeOut}      120s
${Start}        1s
${Orderid}=  960908078870589440


#############################################################

${CRM_TestData}     ${TestData}[CRM_TestData]
${WKD_CRM_TESTDATA}     ${TestData}[WKD_CRM_TESTDATA]
${CRM_CREDENTIAL}     ${TestData}[USER][crm_user]
${SCREENSHOT_LOC}  ${TestData}[SCREENSHOT_LOC]
${CRM_UI}  ${wkd}[SSOPage][crm]
${ProfileDetailsPage}  ${CRMPage}[ProfileDetailPage]
${AccoutDetailPage}  ${CRMPage}[AccoutDetailPage]
${ServiceDetailsPage}  ${CRMPage}[ServiceDetailsPage]
${HomePage}  ${CRMPage}[HomePage]        # Importing Home page Components
*** Keywords ***


Manage tab
    [Arguments]     ${Managetab}
    #Verify elements is visible and displayed  ${Managetab}
    wait until element is visible    ${Managetab}
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      Click Item       ${Managetab}
    

Set Month
   [Arguments]   ${Locator}  ${dropdown}     ${Month}
   Click Item    ${Locator}
   Set Dropdown4      ${dropdown}      ${Month}

Set Year
  [Arguments]    ${Locator}  ${Year}  ${dropdown}
  Click Item    ${Locator}
  Set dropdown4    ${dropdown}    ${Year}

Set Date
  [Arguments]   ${Locator}   ${Date}
  Click Item    ${Locator}
  Click Item   //div[@aria-label='${Date}']

Start Time
  [Arguments]    ${Locator}   ${StartTime}
  Click Item        ${Locator}
  Click Item    //li[normalize-space()='${StartTime}']    

#Refresh tab
#    [Arguments]     ${Refreshtab}
#    wait until element is visible    ${Refreshtab}
#    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      click element      ${Refreshtab}





Go Back to Home Page
    [Documentation]    To Navigate to Home screen of CRM UI
    Wait Until Keyword Succeeds    ${TimeOut}      ${Start}      Click Item    ${HomePage}[HomeButton]


Set Slider
    [Arguments]     ${label}  ${value}
    #${String}=  get text     ${locator}
    #Log To Console  ${String}
    ${Is_Checkbox_Selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    //label[text()='${label}']/following-sibling::div/label//span/input[@type='checkbox']
    #Run Keyword If  '${Is_Checkbox_Selected}' != 'False'  Log To Console  NANACONDITION

    #Click Item  ${locator}

    ${passed}=    Run Keyword If  '${Is_Checkbox_Selected}' == 'False'  Set Variable    NO
    ...  ELSE IF  '${Is_Checkbox_Selected}' == 'True'  Set Variable    YES
    ...  ELSE  Log To Console  SLIDER STATUS SHOULD BE BINARY[True/False]

    Log To Console  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    Log To Console  ${passed}
    Log To Console  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

    Run Keyword If  '${value}' != '${passed}'  Click Item  //label[text()='${label}']/following-sibling::div/label//div
    ...  ELSE IF  '${value}' == 'nan'  Log To Console  Blank
    ...  ELSE  Log To Console  SLIDER STATUS SHOULD BE BINARY[YES/NO]

File Uplaod
    [Arguments]     ${locator}  ${FilePath}
    Scroll Element Into View    ${locator}
    Sleep  4s
    Choose File    ${locator}  ${FilePath}





Edit Profile Details two
    [Documentation]    To Edit the Profile level details
    [Arguments]     ${caseID}  ${dataID}

    ${PROFILE}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
    ${email}=  getData  ${PROFILE}  EMAIL
    ${contact}=  getData  ${PROFILE}  CONTACT
    ${alternate_Contact}=  getData  ${PROFILE}  ALTERNATE CONTACT

    Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    Sleep  5s
    Click Item  ${ProfileDetailsPage}[EditProfileDetail]
    Sleep  2s
    Set Input  ${ProfileDetailsPage}[EmailInput]  ${email}
    Set Input  ${ProfileDetailsPage}[ContactNumberInput]  ${contact}
    Set Input  ${ProfileDetailsPage}[AlternateContactInput]  ${alternate_Contact}
    Sleep  2s
    Click Item  ${ProfileDetailsPage}[EditProfileSubmit]
    Sleep  2s
    #Click Item  //a//span[text()='Dashboard']
    #Sleep  10s
    #Go Back to Home Page



Edit Account Details two
    [Documentation]    To Edit Account level details
    [Arguments]     ${caseID}  ${dataID}

    ${ACCOUNT}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ACCOUNT_DETAILS  ${caseID}  ${dataID}
    Log To Console  ${ACCOUNT}
    ${ACCOUNT_ID}=  getData  ${ACCOUNT}  ACCOUNT_ID
    ${ACCOUNT_NAME}=  getData  ${ACCOUNT}  ACCOUNT_NAME
    ${EMAIL}=  getData  ${ACCOUNT}  EMAIL
    ${CONTACT_NO}=  getData  ${ACCOUNT}  CONTACT_NO
    ${LANGUAGE}=  getData  ${ACCOUNT}  LANGUAGE
    ${KEY_ACC_MANAGER}=  getData  ${ACCOUNT}  KEY_ACC_MANAGER
    ${BILL_MEDIUM}=  getData  ${ACCOUNT}  BILL_MEDIUM
    ${BANK_NAME}=  getData  ${ACCOUNT}  BANK_NAME
    ${BRANCH_CODE}=  getData  ${ACCOUNT}  BRANCH_CODE
    ${BRANCH_ACCOUNT_TYPE}=  getData  ${ACCOUNT}  BRANCH_ACCOUNT_TYPE
    ${BRANCH_ACCOUNT_NO}=  getData  ${ACCOUNT}  BRANCH_ACCOUNT_NO

    ${contact}=  Generate random string        12     0123456789
    ${ITEMIZED_BILL_STATEMENT}=  getData  ${ACCOUNT}  ITEMIZED_BILL_STATEMENT
    ${DIRECT_DEBT}=  getData  ${ACCOUNT}  DIRECT_DEBT
    ${EMAIL_NOTIFICATION}=  getData  ${ACCOUNT}  EMAIL_NOTIFICATION

    Search By ID  ${HomePage}[HomeSeachOptionAccountId]  ${ACCOUNT_ID}
    Sleep  7s
    TakePic  AccountDtails.png
    Click Item  ${AccoutDetailPage}[EditDetails]
    Set Input  ${AccoutDetailPage}[AccountName]  ${ACCOUNT_NAME}
    Sleep  2s
#    Set Dropdown  ${AccoutDetailPage}[LanguageDropdown]  ${LANGUAGE}
#    Set Input  ${AccoutDetailPage}[ContactInput]  ${CONTACT_NO}
#    Set Dropdown  ${AccoutDetailPage}[AccountManagerDropdown]  ${KEY_ACC_MANAGER}
#    Set Dropdown  ${AccoutDetailPage}[BillMediumDropdown]  ${BILL_MEDIUM}
#    Set Slider  Itemized Bill Statement  ${ITEMIZED_BILL_STATEMENT}
#    Set Slider  Email Notification  ${EMAIL_NOTIFICATION}
#    Set Slider  Direct Debit  ${DIRECT_DEBT}
#
#    IF    '${DIRECT_DEBT}' == 'YES'
#        #Log To Console  DEBIT PANEL ENABLLED OOOOOOOOOOOOOOOOOOOOOOOOOOOOO
#
#        Click Item  ${AccoutDetailPage}[BankNameDropdown]
#        Click Item  //label[text()='${BANK_NAME}' and @md='10']
#        Click Item  ${AccoutDetailPage}[AccountTypeDropdown]
#        Click Item  //label[text()='${BRANCH_ACCOUNT_TYPE}' and @md='10']
#
#        #Set Dropdown  ${AccoutDetailPage}[BankNameDropdown]  ${BANK_NAME}
#        #Set Dropdown  ${AccoutDetailPage}[AccountTypeDropdown]  ${BRANCH_ACCOUNT_TYPE}
#    END
#    #Sleep  10s
#    #Run Keyword If  '${DIRECT_DEBT}' == 'YES'  Set Dropdown  ${AccoutDetailPage}[BankNameDropdown]  ${BANK_NAME}
#    #Run Keyword If  '${DIRECT_DEBT}' == 'YES'  Set Dropdown  ${AccoutDetailPage}[AccountTypeDropdown]  ${BRANCH_ACCOUNT_TYPE}

    Click Item  ${AccoutDetailPage}[Submit]
    Sleep  2s
    Click Item   //div[@class='text-md-right action-button p-0 col-md-6']//div[2]
    Sleep  2s


    #Go Back to Home Page

Edit Service Details two
    [Documentation]    To edit Sevice level details
    [Arguments]     ${caseID}  ${dataID}
    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  SERVICE_DETAILS  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${serviceIndex}=  getData  ${data}  SERVICE_NAME

    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Sleep  7s
    Scroll Element Into View    //input[@id='ocsMaBalance']
    ${ServiceId}=  SeleniumLibrary.Get Text   //input[@id='serviceId']
    Log To Console   ${ServiceId}
    ${ServiceName}=  SeleniumLibrary.Get Text   //input[@id='serviceId']
    Log To Console   ${ServiceName}
    Click Item  ${ServiceDetailsPage}[EditDetails]
    Set Input  ${ServiceDetailsPage}[ServiceNameInput]      ${serviceIndex}
    Sleep  2s
    Click Item  ${ServiceDetailsPage}[Submit]
    Sleep  4s


Manage Profile Residential Address two
    [Documentation]    To edit Profile level recidential address
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_ADDRESS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${data}  PROFIE_ID
    ${REGION}=  getData  ${data}  REGION
    ${ZONE}=  getData  ${data}  ZONE
    ${WOREDA}=  getData  ${data}  WOREDA
    ${Union}=  getData  ${data}  UNION
    ${HomeNo}=  getData  ${data}  HOME_NO
    ${StreetNo}=  getData  ${data}  STREET_NO
    ${POCode}=  getData  ${data}  PO_CODE
    ${POBox}=  getData  ${data}  PO_BOX
    ${Latitude}=  getData  ${data}  LATITUDE
    ${Longitude}=  getData  ${data}  LONGITUDE
    ${Comment}=  getData  ${data}  COMMENT


    #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    #Sleep  2s
    ##Manage tab  ${ProfileDetailsPage}[ManageProfile]
    #Click Item  ${ProfileDetailsPage}[ManageProfile]
    #Sleep  2s
    Click Item  ${ProfileDetailsPage}[ManageProfileAddress]
    Sleep  2s
    Click Item   //form[@id='res-addr']//button[@name='buttonName'][normalize-space()='Edit Address']
    Sleep  2s
    Set Dropdown  ${ProfileDetailsPage}[Residential_ProfileRegionDropdown]  ${REGION}
    Set Dropdown  ${ProfileDetailsPage}[Residential_ProfileZoneDropdown]  ${ZONE}
    Set Input  ${ProfileDetailsPage}[Residential_UnionInput]      ${Union}
    Set Input  ${ProfileDetailsPage}[Residential_HouseNoInput]      ${HomeNo}
    Set Input  ${ProfileDetailsPage}[Residential_StreetInput]      ${StreetNo}
    Set Input  ${ProfileDetailsPage}[Residential_PostalCodeInput]      ${POCode}
    Set Input  ${ProfileDetailsPage}[Residential_POInput]      ${POBox}
    Set Input  ${ProfileDetailsPage}[Residential_LatitudeInput]      ${Latitude}
    Set Input  ${ProfileDetailsPage}[Residential_LongitudeInput]      ${Longitude}
    Set Input  ${ProfileDetailsPage}[Residential_AddressComment]      ${Comment}
    Sleep  4s
    Click Item  ${ProfileDetailsPage}[ResidentialAddressSubmit]
    Sleep  2s
    #Manage Profile Permanent Address twoGo Back to Home Page


Manage Profile Permanent Address two
    [Documentation]    To edit profile level permanent address
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_ADDRESS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${data}  PROFIE_ID
    ${REGION}=  getData  ${data}  REGION
    ${ZONE}=  getData  ${data}  ZONE
    ${WOREDA}=  getData  ${data}  WOREDA
    ${Union}=  getData  ${data}  UNION
    ${HomeNo}=  getData  ${data}  HOME_NO
    ${StreetNo}=  getData  ${data}  STREET_NO
    ${POCode}=  getData  ${data}  PO_CODE
    ${POBox}=  getData  ${data}  PO_BOX
    ${Latitude}=  getData  ${data}  LATITUDE
    ${Longitude}=  getData  ${data}  LONGITUDE
    ${Comment}=  getData  ${data}  COMMENT

    #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    Sleep  2s
    ##Manage tab  ${ProfileDetailsPage}[ManageProfile]
    #Click Item  ${ProfileDetailsPage}[ManageProfile]
    #Click Item  ${ProfileDetailsPage}[ManageProfileAddress]
    #Sleep  2s
    Click Item  //form[@id='permanent-addr']//button[@name='buttonName'][normalize-space()='Edit Address']
    #Sleep  2s
    #Click Item  ${ProfileDetailsPage}[PermanentAddressEdit]
    Sleep  2s
    Set Dropdown  ${ProfileDetailsPage}[ProfileRegionDropdown]  ${REGION}
    Set Dropdown  ${ProfileDetailsPage}[ProfileZoneDropdown]  ${ZONE}
    Set Input  ${ProfileDetailsPage}[UnionInput]      ${Union}
    Set Input  ${ProfileDetailsPage}[HouseNoInput]      ${HomeNo}
    Set Input  ${ProfileDetailsPage}[StreetInput]      ${StreetNo}
    Set Input  ${ProfileDetailsPage}[PostalCodeInput]      ${POCode}
    Set Input  ${ProfileDetailsPage}[POInput]      ${POBox}
    Set Input  ${ProfileDetailsPage}[LatitudeInput]      ${Latitude}
    Set Input  ${ProfileDetailsPage}[LongitudeInput]      ${Longitude}
    Set Input  ${ProfileDetailsPage}[AddressComment]      ${Comment}
    Sleep  4s
    Click Item  ${ProfileDetailsPage}[PermanentAddressSubmit]
    Sleep  2s
    #Go Back to Home Page

Manage Account Address One
    [Documentation]    To edit account level details
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ACCOUNT_ADDRESS  ${caseID}  ${dataID}
    ${ACCOUNT_ID}=  getData  ${data}  ACCOUNT_ID
    ${REGION}=  getData  ${data}  REGION
    ${ZONE}=  getData  ${data}  ZONE
    ${WOREDA}=  getData  ${data}  WOREDA
    ${Union}=  getData  ${data}  UNION
    ${HomeNo}=  getData  ${data}  HOME_NO
    ${StreetNo}=  getData  ${data}  STREET_NO
    ${POCode}=  getData  ${data}  PO_CODE
    ${POBox}=  getData  ${data}  PO_BOX
    ${Latitude}=  getData  ${data}  LATITUDE
    ${Longitude}=  getData  ${data}  LONGITUDE
    ${Comment}=  getData  ${data}  COMMENT

    Search By ID  ${HomePage}[HomeSeachOptionAccountId]  ${ACCOUNT_ID}
    Sleep  2s
    Click Item  ${AccoutDetailPage}[ManageAccount]
    Sleep  2s
    Click Item  ${AccoutDetailPage}[AddressDetail]
    Sleep  2s
    Click Item  ${AccoutDetailPage}[EditAccountDetail]
    Sleep  2s
    Set Dropdown  ${AccoutDetailPage}[RegionDropdown]  ${REGION}
    Set Dropdown  ${AccoutDetailPage}[ZoneDropdown]  ${ZONE}
    Set Input  ${AccoutDetailPage}[UnionInput]      ${Union}
    Set Input  ${AccoutDetailPage}[HouseNoInput]      ${HomeNo}
    Set Input  ${AccoutDetailPage}[StreetInput]      ${StreetNo}
    Set Input  ${AccoutDetailPage}[PostalCodeInput]      ${POCode}
    Set Input  ${AccoutDetailPage}[POInput]      ${POBox}
    Set Input  ${AccoutDetailPage}[LatitudeInput]      ${Latitude}
    Set Input  ${AccoutDetailPage}[LongitudeInput]      ${Longitude}
    Set Input  ${AccoutDetailPage}[AddressComment]      ${Comment}
    Sleep  4s
    Click Item  ${AccoutDetailPage}[Submit]
    Sleep  2s
    Go Back to Home Page


Manage Service Address One
    [Documentation]    To edit service level details
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  SERVICE_ADDRESS  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${REGION}=  getData  ${data}  REGION
    ${ZONE}=  getData  ${data}  ZONE
    ${WOREDA}=  getData  ${data}  WOREDA
    ${Union}=  getData  ${data}  UNION
    ${HomeNo}=  getData  ${data}  HOME_NO
    ${StreetNo}=  getData  ${data}  STREET_NO
    ${POCode}=  getData  ${data}  PO_CODE
    ${POBox}=  getData  ${data}  PO_BOX
    ${Latitude}=  getData  ${data}  LATITUDE
    ${Longitude}=  getData  ${data}  LONGITUDE
    ${Comment}=  getData  ${data}  COMMENT

#    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
#    #Manage tab  ${ServiceDetailsPage}[ManageService]
#    Click Item  ${ServiceDetailsPage}[ManageService]
#    Sleep  2s
    Click Item  ${ServiceDetailsPage}[AddressDetail]
    Sleep  2s
    Click Item  ${ServiceDetailsPage}[AddressEdit]
    Sleep  2s
    Set Dropdown  ${ServiceDetailsPage}[RegionDropdown]  ${REGION}
    Set Dropdown  ${ServiceDetailsPage}[ZoneDropdown]  ${ZONE}
    Set Input  ${ServiceDetailsPage}[UnionInput]      ${Union}
    Set Input  ${ServiceDetailsPage}[HouseNoInput]      ${HomeNo}
    Set Input  ${ServiceDetailsPage}[StreetInput]      ${StreetNo}
    Set Input  ${ServiceDetailsPage}[PostalCodeInput]      ${POCode}
    Set Input  ${ServiceDetailsPage}[POInput]      ${POBox}
    Set Input  ${ServiceDetailsPage}[LatitudeInput]      ${Latitude}
    Set Input  ${ServiceDetailsPage}[LongitudeInput]      ${Longitude}
    Set Input  ${ServiceDetailsPage}[AddressComment]      ${Comment}
    Sleep  2s
    Click Item  ${ServiceDetailsPage}[Submit]
    Sleep  4s
    Go Back to Home Page


##Add Supplementary Offer
#    #[Documentation]    To Buy Add-on offers
#    [Arguments]     ${caseID}  ${dataID}
#
#    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  OFFER  ${caseID}  ${dataID}
#    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
#    ${OFFER}=  getData  ${data}  OFFER
#
#    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
#    Sleep  20s
#    #wait until element is visible    ${ServiceDetailsPage}[PlanSubscriptionButton]
#    Click Item    ${ServiceDetailsPage}[PlanSubscriptionButton]
#    Click Item    ${ServiceDetailsPage}[BuyAddOnsButton]
#    Sleep  5s
#    scroll element into view    //div[contains(text(),'${OFFER}')]/child::input
#    Click Item    //div[contains(text(),'${OFFER}')]/child::input
#    Click Item    ${ServiceDetailsPage}[AddToCartButton]
#    Click Item    ${ServiceDetailsPage}[AddToCartSubmitButton]
#    Click Item    ${ServiceDetailsPage}[OrderOverviewSubmitButton]
#    Click Item    ${ServiceDetailsPage}[OrderOverViewDoneButton]
#    Go Back to Home Page

change SIM ID
    [Documentation]    To change SIM number
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  SIM_CHANGE  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${VALUE}=  getData  ${data}  PAYMENT
    ${REASON}=  getData  ${data}  REASON
    ${PAYMENT}=  getData  ${data}  PAYMENT
    ${WAVEOFF}=  getData  ${data}  WAVEOFF
    ${ICCIDNumber}=  getData  ${data}  ICCIDNumber
    ${COMMENT}=  getData  ${data}  COMMENT


    #Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    #Click Item    ${ServiceDetailsPage}[ManageService]
    Click Item  //div[contains(text(),'Manage Service')]
    #Click Item    ${ServiceDetailsPage}[ManageSim]
    Click Item  //a[normalize-space()='Change SIM']
    Sleep  2s
    TakePic    SimDetails.png
    Click Item    ${ServiceDetailsPage}[ChangeSimButton]
    #Set Input     //input[@placeholder='Search']    ${ICCIDNumber}
    #Sleep  2s
    #Click Item     //div[@class='search-box d-flex ']//span//*[name()='svg']
    Sleep  5s
    Click Item    ${ServiceDetailsPage}[NewICCIDSimID]
    #Click Item    ${ServiceDetailsPage}[SimChangeReasonDropdown]
    #Click Item    ${ServiceDetailsPage}[SimChangeReasonDropdownOption1]
    Set Dropdown  ${ServiceDetailsPage}[SimChangeReasonDropdown]  ${REASON}
    Click Item    ${ServiceDetailsPage}[SimChangeComment]
    Set Input  ${ServiceDetailsPage}[SimChangeComment]      ${COMMENT}
    Click Item    //button[normalize-space()='Submit']
    Sleep  5s

    #Select Radio Button   upfrontPayment    2
    #Click Item    //input[@type='checkbox']
    #Select Checkbox  //input[@type='checkbox']
    #Sleep  10s
    #Set Radio Button  Upfront  ${VALUE}
    #Set Radio Button  Invoice  ${VALUE}
    #Click Item    //span[text()='Upfront']/preceding-sibling::span//input
    #Set Slider  Wave off Handling Charges  ${WAVEOFF}

#    IF    '${WAVEOFF}' == 'NO'
#        IF    '${PAYMENT}' == 'Upfront'
#            Select Radio Button   upfrontPayment    1
#        END
#
#        IF    '${PAYMENT}' == 'Invoice'
#            Select Radio Button   upfrontPayment    2
#        END
#    END
#
#    Click Item    (//button[text()='Submit'])[2]
#    Click Item    //span[@class='MuiIconButton-label']//*[name()='svg']
     Click Item   //div[@class='col-md-12']//div[1]//div[2]
     Sleep  4s




View Identification Details
    [Documentation]    To view and validate identification details
    [Arguments]     ${caseID}  ${dataID}
    ${PROFILE}=   Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
    ${ID_NUMBER}=  getData  ${PROFILE}  ID_NUMBER
    #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    Click Item  ${ProfileDetailsPage}[ManageProfile]
    Click Item  ${ProfileDetailsPage}[IdentificationDetails]
    Verify elements is visible and displayed  //td[normalize-space()='${ID_NUMBER}']
    Click Item    //tbody//div[2]
    Sleep  2s
    Click Item     //button[@aria-label='Download']//div[2]
    Sleep  2s
    Click Item    //button[normalize-space()='Done']
    #Go Back to Home Page

View Document Details
    [Documentation]    To view and validate document details
    [Arguments]     ${caseID}  ${dataID}
    ${PROFILE}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
    ${DOCUMENT_NAME}=  getData  ${PROFILE}  DOCUMENT_NAME

    #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    #Click Item  ${ProfileDetailsPage}[ManageProfile]
    scroll element into view     ${ProfileDetailsPage}[ViewDocumentDetails]
    Click Item  ${ProfileDetailsPage}[ViewDocumentDetails]
    Set Input         ${ProfileDetailsPage}[InputDocumentID]   ${DOCUMENT_NAME}
    Click Item  ${ProfileDetailsPage}[DocumentSearch]
    Sleep  4s
    Click Item   //button[@aria-label='Download']//div[2]
    Sleep  4s
    #Go Back to Home Page


Create Ticket
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}   CREATE_TICKET  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  ServiceID
    ${PRODUCT_TYPE}=  getData  ${data}  Product_Type
    ${CASE_TYPE}=  getData  ${data}     Case_Type
    ${CASE_CATEGORY}=  getData  ${data}   Case_Category
    ${PRIORITY}=  getData  ${data}      Priority
    ${TEAM}=  getData  ${data}      Team
    ${ASSIGNE}=  getData  ${data}      Assigne
    ${SUBJECT}=  getData  ${data}       Subject
    ${CAUSED_CODE}=  getData  ${data}   Caused_Code
    ${CHANNEL}=  getData  ${data}       Channel
    ${CASE_NATURE}=  getData  ${data}       Case_Nature
    ${CASE_SUB_NATURE}=  getData  ${data}  Case_Sub_Nature
    ${NAME}=  getData  ${data}  Name
    ${EMAIL}=  getData  ${data}       Email
    ${CONTACT_NUMBER}=  getData  ${data}   Contact_Number
    ${DESCRIPTION}=  getData  ${data}      Description
    ${REGION}=  getData  ${data}  REGION
    ${ZONE}=  getData  ${data}  ZONE
    ${WOREDA}=  getData  ${data}  WOREDA
    ${Union}=  getData  ${data}  UNION
    ${HomeNo}=  getData  ${data}  HOME_NO
    ${StreetNo}=  getData  ${data}  STREET_NO
    ${POCode}=  getData  ${data}  PO_CODE
    ${POBox}=  getData  ${data}  PO_BOX

    Search By ID      ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item        ${ServiceDetailsPage}[ViewTickets]
    Click Item        ${ServiceDetailsPage}[CreateTicketButton]
    Switch Window    new
    #Login to SSO UI   ${CRM_CREDENTIAL}[username]  ${CRM_CREDENTIAL}[password]
    Set Dropdown2     ${ServiceDetailsPage}[ProductTypeDropdown]  ${PRODUCT_TYPE}
    Set Dropdown2     //span[@id='select2-Category_TypeCreate-container']     ${CASE_CATEGORY}
    Set Dropdown2     ${ServiceDetailsPage}[CaseTypeDropdown]    ${CASE_TYPE}
    Set Dropdown2     //span[@id='select2-TeamCreate-container']   ${TEAM}
    Set Dropdown2     //span[@id='select2-User_NameCreate-container']    ${ASSIGNE}
    Scroll Element Into View      //span[@id='select2-Source_Code-container']
    Set Dropdown2      //span[@id='select2-Source_Code-container']    ${CHANNEL}
    Set Dropdown2      //span[@id='select2-languageCase-container']     English
    Set Input         ${ServiceDetailsPage}[NameInput]   ${NAME}
    Set Input         ${ServiceDetailsPage}[EmailInput]   ${EMAIL}
    Set Input         ${ServiceDetailsPage}[Contact Number]   ${CONTACT_NUMBER}
    Set Input         ${ServiceDetailsPage}[Descripion]     ${DESCRIPTION}
    Sleep  2s
    Scroll Element Into View     //button[normalize-space()='Address Details']
    Click Item      //button[normalize-space()='Address Details']
    Set Dropdown2  ${ServiceDetailsPage}[Region]  ${REGION}
    Set Dropdown2  ${ServiceDetailsPage}[Zone]  ${ZONE}
    Set Input  ${ServiceDetailsPage}[Kebele]      ${Union}
    Set Input  ${ServiceDetailsPage}[HouseNumber]      ${HomeNo}
    Set Input  ${ServiceDetailsPage}[StreetName]      ${StreetNo}
    Set Input  ${ServiceDetailsPage}[PostCode]      ${POCode}
    Set Input  ${ServiceDetailsPage}[POBoxNumber]      ${POBox}
    #Click Item        ${ServiceDetailsPage}[Save]
    #Sleep  3s
    #${TicketId}=  get text    ${ServiceDetailsPage}[TicketCreationPopUp]
    #log to console   ${TicketId}



Filter Ticket By Status Open
    [Documentation]    To filter tickets based on priority and Ticket ID
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  FILTER_TICKETS  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${STATUS}=  getData  ${data}  STATUS
    ${TICKET_ID}=  getData  ${data}  TICKET_ID
    ${PRIORITY}=  getData  ${data}  PRIORITY

    Search By ID      ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item        ${ServiceDetailsPage}[ViewTickets]
    Click Item        ${ServiceDetailsPage}[AdvanceSearchinViewTicket]
    Set Input         ${ServiceDetailsPage}[InputTicketID]   ${TICKET_ID}
    Set Dropdown      ${ServiceDetailsPage}[ViewTicketStatusDropdown]   ${STATUS}
    Set Dropdown      ${ServiceDetailsPage}[ViewTicketPriorityDropdown]   ${PRIORITY}
    Click Item        ${ServiceDetailsPage}[ViewTicketSearch]
    Verify elements is visible and displayed  //td[normalize-space()='${TICKET_ID}']
    Go Back to Home Page


Alter Account State
    [Documentation]    To alter account state
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ALTER_ACCOUNT_STATE  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  ServiceID
    ${STATUS}=  getData  ${data}  STATUS
    ${REASON}=  getData  ${data}  REASON
    ${COMMENT}=  getData  ${data}  COMMENT

    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item  ${ServiceDetailsPage}[ManageService]
    scroll element into view     ${ServiceDetailsPage}[ChangeLifeCycle]
    Click Item     ${ServiceDetailsPage}[ChangeLifeCycle]
    Set Dropdown   ${ServiceDetailsPage}[ChangeLifeCycleStatusDropdown]  ${STATUS}
    Set Dropdown   ${ServiceDetailsPage}[ChangeLifeCycleReasonDropdown]  ${REASON}
    Set Input      ${ServiceDetailsPage}[CommentsChangeLifeCycleInput]   ${COMMENT}
    Click Item     ${ServiceDetailsPage}[SubmitChangeLifeCycleButton]
    Go Back to Home Page


Suspend Supplementary Plan
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}   SERVICE_DETAILS  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID

    Click Item      ${HomePage}[HomeSeachOptionServiceId]
    Set Input      ${HomePage}[HomeSearchBar]    ${SERVICE_ID}
    Click Item   ${HomePage}[HomeSearchButton]
    Click Item      ${ServiceDetailsPage}[PlanSubscriptionButton]
    Sleep  3s
    scroll element into view  ${ServiceDetailsPage}[ActiomToCancelSubscriptionButton]
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[ActiomToCancelSubscriptionButton]
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[SuspendPlanButton]
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[YesButton]
    Handle PopUp   ${ServiceDetailsPage}[OrderPlacedSuccessfully]    Order Placed Successfully
    Go Back to Home Page

Update HLR Status

    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}   HLR  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  ServiceID
    ${NEW_DEVICE_STATUS}=  getData  ${data}  New device status
    ${Action}=  getData  ${data}  Action

    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item    ${ServiceDetailsPage}[ManageService]
    Click Item    ${ServiceDetailsPage}[HLR/EIR Status]
    Set Dropdown    ${ServiceDetailsPage}[HLRNewDeviceStatus]   ${NEW_DEVICE_STATUS}
    Set Dropdown    ${ServiceDetailsPage}[HLRStatusAction]      ${Action}
    Click Item    ${ServiceDetailsPage}[HLRStatusSubmitButton]
    Sleep  4s
    Go Back to Home Page

Cancel and Add Supplementary Offer

    [Documentation]    Add Supplementary Offer
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  OFFER  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${OFFER}=  getData  ${data}  OFFER

    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Sleep  5s
    Click Item      ${ServiceDetailsPage}[PlanSubscriptionButton]
    Sleep  5s
    scroll element into view    ${ServiceDetailsPage}[3GB Offer]
    Verify elements is visible and displayed       ${ServiceDetailsPage}[3GB Offer]
    Sleep  7s

    Click Item    ${ServiceDetailsPage}[SubscriptionDropdown]
    scroll element into view  ${ServiceDetailsPage}[PlanDetailsbutton]
    Click Item  ${ServiceDetailsPage}[PlanDetailsbutton]
    Verify elements is visible and displayed   ${ServiceDetailsPage}[PlanStatusText]
    Verify elements is visible and displayed   ${ServiceDetailsPage}[PlanStatusActive]
    Sleep  7s

    #Click Item    ${ServiceDetailsPage}[BuyAddOnsButton]
    #Verify elements is visible and displayed   ${ServiceDetailsPage}[OptionalOffer]
    #scroll element into view    //div[contains(text(),'${OFFER}')]/child::input
    #Verify elements is visible and displayed     //div[contains(text(),'${OFFER}')]/child::input
    #scroll element into view    ${ServiceDetailsPage}[OptionalOfferCancelButton]
    #Sleep  7s
    #Click Item    ${ServiceDetailsPage}[OptionalOfferCancelButton]


    scroll element into view  ${ServiceDetailsPage}[ActionToCancelSubscriptionButton]
    Click Item    ${ServiceDetailsPage}[ActionToCancelSubscriptionButton]
    Sleep  5s
    Click Item    ${ServiceDetailsPage}[RemovePlanButton]
    Sleep  4s
    Click Item    ${ServiceDetailsPage}[YesButton]
    Sleep  3s
    Handle PopUp    ${ServiceDetailsPage}[OrderPlacedSuccessfully]    Order Placed Successfully

    Sleep  5s
    Click Item    ${ServiceDetailsPage}[BuyAddOnsButton]
    Verify elements is visible and displayed   ${ServiceDetailsPage}[OptionalOffer]
    scroll element into view    //div[contains(text(),'${OFFER}')]/child::input
    Verify elements is visible and displayed     //div[contains(text(),'${OFFER}')]/child::input
    Sleep  5s

    scroll element into view    //div[contains(text(),'${OFFER}')]/child::input
    Sleep  3s
    Click Item    //div[contains(text(),'${OFFER}')]/child::input
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[AddToCartButton]
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[AddToCartSubmitButton]
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[OrderOverviewSubmitButton]
    Sleep  3s
    Click Item   ${ServiceDetailsPage}[OrderOverViewDoneButton]
    Sleep  3s
    Click Item    ${ServiceDetailsPage}[SubscriptionDropdown]
    Sleep  10s
    Click Item    ${ServiceDetailsPage}[ReloadButton]


#Suspend and Resume Supplementary Plan
    #[Documentation]    Suspend and Resume Supplementary Plan
    #[Arguments]     ${caseID}  ${dataID}

    #${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  OFFER  ${caseID}  ${dataID}
    #${SERVICE_ID}=  getData  ${data}  SERVICE_ID

    #Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    #scroll element into view    ${ServiceDetailsPage}[3GB Offer]
    #Verify elements is visible and displayed     ${ServiceDetailsPage}[3GB Offer]
    #Click Item      ${ServiceDetailsPage}[PlanSubscriptionButton]
    #scroll element into view  ${ServiceDetailsPage}[ActionToCancelSubscriptionButton]
    #Click Item    ${ServiceDetailsPage}[ActionToCancelSubscriptionButton]
    #Sleep  2s
    #click element    ${ServiceDetailsPage}[SuspendPlanButton]
    #click element    ${ServiceDetailsPage}[YesButton]
    #Sleep  2s
    #Handle PopUp    ${ServiceDetailsPage}[OrderPlacedSuccessfully]    Order Placed Successfully
    #Sleep  25s
    #Click Item    ${ServiceDetailsPage}[ReloadButton]
    #Sleep  5s


   #scroll element into view  ${ServiceDetailsPage}[ActionToCancelSubscriptionButton]
   #Click Item    ${ServiceDetailsPage}[ActionToCancelSubscriptionButton]
   #Click Item    ${ServiceDetailsPage}[ResumePlanButton]
   #Click Item    ${ServiceDetailsPage}[YesButton]
   #Sleep  2s
   #Handle PopUp    ${ServiceDetailsPage}[OrderPlacedSuccessfully]    Order Placed Successfully

   scroll element into view  ${ServiceDetailsPage}[BasePlan]
   Verify elements is visible and displayed   ${ServiceDetailsPage}[BasePlan]
   Sleep  7s
   ${BasePlan}=  get text     ${ServiceDetailsPage}[BasePlan]
   Log To Console   ${BasePlan}
   Verify elements is visible and displayed   ${ServiceDetailsPage}[PrepaidStarterPackPO]
   ${PrepaidStarterPackPO}=  get text     ${ServiceDetailsPage}[PrepaidStarterPackPO]
   Log To Console   ${PrepaidStarterPackPO}



   scroll element into view      ${ServiceDetailsPage}[BucketDetailsButton]
   Click Item  ${ServiceDetailsPage}[BucketDetailsButton]
   Sleep  7s
   Verify elements is visible and displayed   ${ServiceDetailsPage}[Bucket DetailsText]
   Click Item  ${ServiceDetailsPage}[BucketDetailsDoneButton]
   ${BucketCurrentBalance}=  get text     ${ServiceDetailsPage}[BucketCurrentBalance]
   Log To Console   ${BucketCurrentBalance}
   ${BucketCurrentBalanceValue}=  get text     ${ServiceDetailsPage}[BucketCurrentBalanceValue]
   Log To Console   ${BucketCurrentBalanceValue}


   Verify elements is visible and displayed  ${ServiceDetailsPage}[ExpiryDateHeader]
   ${ExpiryDateHeader}=  get text     ${ServiceDetailsPage}[ExpiryDateHeader]
   Sleep  7s
   Log To Console   ${ExpiryDateHeader}
   Verify elements is visible and displayed  ${ServiceDetailsPage}[ExpiryDate]
   ${ExpiryDateHeader}=  get text     ${ServiceDetailsPage}[ExpiryDate]
   Log To Console   ${ExpiryDateHeader}

   Go Back to Home Page


Edit Profile Details at Enterprise Level
    [Documentation]    To Edit the Profile level details
    [Arguments]     ${caseID}  ${dataID}

    ${PROFILE}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
    ${email}=  getData  ${PROFILE}  EMAIL
    ${contact}=  getData  ${PROFILE}  CONTACT
    ${alternate_Contact}=  getData  ${PROFILE}  ALTERNATE CONTACT
    ${IndustryName}=  getData  ${PROFILE}  IndustryName
    ${CompanyName}=  getData  ${PROFILE}   CompanyName
    ${WebAddress}=  getData  ${PROFILE}    WebAddress
    ${RegistrationNumber}=  getData  ${PROFILE}    RegistrationNumber
    ${TINNumber}=  getData  ${PROFILE}      TINNumber
    ${VATNumber}=  getData  ${PROFILE}      VATNumber
    ${NoOfEmployees}=  getData  ${PROFILE}      NoOfEmployees
    ${AnnualTurnover}=  getData  ${PROFILE}      AnnualTurnover
    ${NoOfVoiceLines}=  getData  ${PROFILE}      NoOfVoiceLines
    ${BusinessDescription}=  getData  ${PROFILE}      BusinessDescription



    Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    Sleep  5s
    TakePic    ProfileDetails2.png
    Click Item  ${ProfileDetailsPage}[EditProfileDetail]
    Sleep  4s
    Set Input    (//input[@id='companyName'])[2]   ${CompanyName}
    Set Input     (//input[@id='companyContactNumber'])[2]   ${contact}
    Set Input     (//input[@id='socialMediaAddress'])[2]    ${WebAddress}
    Set Input  ${ProfileDetailsPage}[EmailInput]  ${email}
    Set Dropdown      (//div[@class=' css-1uccc91-singleValue'])[1]    ${IndustryName}
    Set Input     (//input[@id='registrationNumber'])[2]   ${RegistrationNumber}
    Set Input     (//input[@id='tinNumber'])[2]   ${TINNumber}
    Set Input     (//input[@id='vatNumber'])[2]   ${VATNumber}
    Set Dropdown  (//div[@class=' css-g1d714-ValueContainer'])[2]   ${NoOfEmployees}
    Set Input       (//input[@id='annualTurnover'])[2]   ${AnnualTurnover}
    Set Input      //input[@id='noOfVoiceLines']   ${NoOfVoiceLines}
    Set Input      //textarea[@name='businessDescription']  ${BusinessDescription}
    Click Item  ${ProfileDetailsPage}[EditProfileSubmit]
    Sleep  12s
    Click Item     //div[@class='text-md-right action-button p-0 col-md-6']//div[2]
    Sleep  05s

    Click Item    //span[normalize-space()='Accounts - 1']
    Click Item    //tbody//div[2]
    Sleep  07s
    ${AccountId}=  SeleniumLibrary.Get Element Attribute   //input[@id='accountId']     value
    Log To Console   ${AccountId}
    ${AccountName}=  SeleniumLibrary.Get Element Attribute   //input[@id='accountName']     value
    Log To Console   ${AccountName}
    Sleep  4s

    Click Item    //span[normalize-space()='Services - 2']
    Click Item    //tbody//div[2]
    Sleep  07s
    ${ServiceId}=  SeleniumLibrary.Get Element Attribute   //input[@id='serviceId']     value
    Log To Console    ${ServiceId}
    ${SericeName}=  SeleniumLibrary.Get Element Attribute   //input[@id='serviceName']     value
    Log To Console  ${SericeName}
    Sleep  4s
    Click Item    //span[normalize-space()='Profile ID']




Onboarding-SA_FORMS
   [Arguments]     ${caseID}  ${dataID}

   ${PROFILE}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  Onboarding_SA_FORM   ${caseID}  ${dataID}
   ${SAFORM_ID}=  getData  ${PROFILE}  SAFORM_ID
   ${BusinessDescription}=  getData  ${PROFILE}  BusinessDescription
   ${WebAdrress}=  getData  ${PROFILE}  WebAdrress
   ${DocumentType}=  getData  ${PROFILE}  DocumentType
   ${FilePath}=  getData  ${PROFILE}  FilePath



   Click Item     //div[contains(text(),'Onboarding')]
   Click Item     //a[@id='/saForms']

#   IF   //span[normalize-space()='Host Not Found. Contact Admin.'] ==    Host Not Found. Contact Admin.
#    Go Back to Home Page
#    Click Item     //a[@id='/saForms']
#   ELSE
#     Go Back to Home Page
#
#
#   END

   Click Item     //span[@class='adv_search']
   Set Input      //input[@id='saFormId']   ${SAFORM_ID}
   Click Item     //button[normalize-space()='Search']

   Click item     //button[@class='action-btn-popover btn btn-secondary']

   Click Item     //button[@aria-label='Release']//div[2]
   Handle PopUp   //span[text()='Release SuccessFully']    Release SuccessFully
   Sleep  10s
   Click Item     //button[@aria-label='Assign']//div[2]
   Sleep  10s
   #Handle PopUp   //span[text()='Assigned SuccessFully']     Assigned SuccessFully
   #sleep  4s
   Click Item    //button[@aria-label='SignedFileDownload']//div[2]
   Sleep  10s
 #  ${files}    List Files In Directory      C:/Users/jagadisha.eshwara/Downloads
   #Length Should Be    ${files}    3
   Click item     //button[@class='action-btn-popover btn btn-secondary']
   #Click Item     //button[@aria-label='Assign']//div[2]


   Click Item     //button[@aria-label='Provisioning']//div[2]
   Sleep  4s
   Click Item     //button[normalize-space()='Next >>']
   Set Input      //textarea[@id='businessDesc']   ${BusinessDescription}
   Set Input   //input[@id='socialMediaAddress']   ${WebAdrress}
   Click Item     //button[normalize-space()='Next >>']
   Sleep  4s
   Click Item     //button[normalize-space()='Next >>']
   Set Dropdown    //div[@class=' css-g1d714-ValueContainer']   ${DocumentType}
   Execute Javascript    var xpath = document.evaluate("//input[@id='file']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
   File Uplaod    //input[@id='file']     ${FilePath}
   Sleep  4s
   Click Item      //button[text()='Add Files']
   Sleep  4s
   Click Item     //button[normalize-space()='Next >>']
   Click Item     //button[normalize-space()='Submit']
   Sleep  10s
   TakePic   Onboarding.png
   ${OrderId}=   SeleniumLibrary.Get Text   //span[starts-with(text(),'102')]
   Log To Console   ${OrderId}
   Click Item     //button[normalize-space()='Done']
   Sleep  2s
#   Click Item     //span[@class='adv_search']
#   Set Input      //input[@id='saFormId']  ${SAFORM_ID}
#   Click Item     //button[normalize-space()='Search']
#   Click item     //button[@class='action-btn-popover btn btn-secondary']
#   Click Item    //button[@aria-label='Completed']//div[2]
#   Click Item     //button[text()='YES']
#   Sleep  5s

   Click Item   ${OrderSearch}[Ordertab]
   Sleep  2s
   Click Item    ${OrderSearch}[viewOrder]
   Sleep  2s
   Set Input  ${OrderSearch}[OrderSearchbar]     ${OrderId}
   Click Item   ${OrderSearch}[SearchButton]
   Sleep  4s
   ${OnboardingOrderStatus}   SeleniumLibrary.Get Text   //tbody/tr[1]/td[4]/b[1]
   Log To Console  ${OnboardingOrderStatus}
   TakePic   OnboardingStatus.png
   scroll element into view     (//button[@type='button'])[7]
   Click Item    (//button[@type='button'])[7]
   Click Item    //button[@aria-label='View']
   Sleep  5s
   Scroll Element Into View    //td[normalize-space()='Pair Sim in NMS']
   TakePic   FailureStatus.png
   Click Item     //button[text()='Cancel']



Add Service
   [Arguments]     ${caseID}  ${dataID}

   ${PROFILE}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  Onboarding_SA_FORM   ${caseID}  ${dataID}
   ${SAFORM_ID}=  getData  ${PROFILE}  SAFORM_ID


   Click Item     //div[contains(text(),'Onboarding')]
   Click Item     //a[@id='/saForms']

   Click Item     //span[@class='adv_search']
   Set Input      //input[@id='saFormId']   ${SAFORM_ID}
   Click Item     //button[normalize-space()='Search']

   Click item     //button[@class='action-btn-popover btn btn-secondary']
   Click Item     //button[@aria-label='Add Service']//div[2]
   Click Item     //button[normalize-space()='Next >>']
   Click Item     //button[normalize-space()='Submit']
   Sleep  10s
   TakePic   AddService.png
   ${OrderId}=  SeleniumLibrary.Get Text   //span[starts-with(text(),'102')]
   Log To Console   ${OrderId}
   Click Item     //button[normalize-space()='Done']
   Sleep  4s

   #click element   ${OrderSearch}[Ordertab]
   #Sleep  2s
   Click Item    ${OrderSearch}[viewOrder]
   Sleep  2s
   Set Input  ${OrderSearch}[OrderSearchbar]     ${OrderId}
   Click Item    ${OrderSearch}[SearchButton]
   ${AddServiceOrderStatus}   SeleniumLibrary.Get Text   //tbody/tr[1]/td[4]/b[1]
   Log To Console  ${AddServiceOrderStatus}
   Sleep  4s
   TakePic   AddSeviceStatus.png
   scroll element into view     (//button[@type='button'])[7]
   Click Item    (//button[@type='button'])[7]
   Click Item    //button[@aria-label='View']
   Sleep  4s
   Scroll Element Into View    //td[normalize-space()='Pair Sim in NMS']
   TakePic   FailureStatus.png
   Sleep  5s
   Click Item     //button[text()='Cancel']
   #Should Be Equal As Strings    ${OnboardingOrderStatus}    Completed
   Should Be Equal As Strings    ${AddServiceOrderStatus}     Completed

Create, Edit and Delete Message Template
   [Arguments]     ${caseID}  ${dataID}

   ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  Message_Template   ${caseID}  ${dataID}
   ${Message_ID}=  getData  ${data}  Message_ID
   ${Message_Text}=  getData  ${data}  Message_Text
   ${Message_Description}=  getData  ${data}  Message_Description
   ${Comment}=  getData  ${data}  Comment
   ${Remessage_Text}=  getData  ${data}  Remessage_Text
   ${ReComment}=  getData  ${data}  ReComment
   ${Language}=  getData  ${data}  Language


  Click Item     //div[contains(text(),'Configurations')]
  Click Item     //a[@id='/template']
  Click Item     //button[normalize-space()='Create Message Template']
  Set Input      (//input[@id='messageId'])[2]    ${Message_ID}
  Set Input      (//input[@id='messageText'])[2]   ${Message_Text}
  Set Input       //input[@id='messageDescription']   ${Message_Description}
  Set Dropdown    //div[@class=' css-1wa3eu0-placeholder']    ${Language}
  Set Input       //textarea[@id='comment']      ${Comment}
  Sleep  4s
  Click Item      //button[normalize-space()='Submit']
  Sleep  4s
  Handle PopUp    //span[normalize-space()='Message Template Creation Success']   Message Template Creation Success

  Set Input      (//input[@id='messageId'])[1]   ${Message_ID}
  Click Item     //button[normalize-space()='Search']
  Sleep  2s
  TakePic  Created Message Template.png
  Click Item     //button[@aria-label='Edit']//div[2]
  Set Input      (//input[@id='messageText'])[2]   ${Remessage_Text}
  Set Input       //textarea[@id='comment']      ${ReComment}
  Sleep  4s
  Click Item      //button[normalize-space()='Modify']
  Sleep  4s
  Handle PopUp     //span[normalize-space()='Message Template Updation Success']   Message Template Updation Success

  Set Input      (//input[@id='messageId'])[1]   ${Message_ID}
  Click Item     //button[normalize-space()='Search']
  sleep  2s
  TakePic   Modified Message Template.png
  Click Item     //button[@aria-label='Delete']//div[2]
  Sleep  2s
  Click Item     //button[normalize-space()='YES']
  Sleep  2s
  TakePic   Deleted Message Template.png
  Handle PopUp    //span[normalize-space()='Message Template Delete Success']    Message Template Delete Success

Create, Edit and Delete Token Management
  [Arguments]     ${caseID}  ${dataID}

  ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  Token_Management   ${caseID}  ${dataID}
  ${Token_ID}=  getData  ${data}  Token_ID
  ${Token_Name}=  getData  ${data}  Token_Name
  ${Token_Description}=  getData  ${data}  Token_Description
  ${Modify_Token_ID}=  getData  ${data}  Modify_Token_ID
  ${Modify_Token_Name}=  getData  ${data}  Modify_Token_Name
  ${Modify_Token_Description}=  getData  ${data}  Modify_Token_Description


  #Click Item     //div[contains(text(),'Configurations')]
  Click Item     //a[@id='/token']
  Click Item     //button[normalize-space()='Create Token']
  Set Input      (//input[@id='tokenId'])[2]  ${Token_ID}
  Set Input      (//input[@id='tokenName'])[2]   ${Token_Name}
  Set Input      //textarea[@id='tokenDesc']   ${Token_Description}
  Sleep  4s
  Click Item     //button[normalize-space()='Submit']
  Sleep  4s
  Handle PopUp    //span[normalize-space()='Token Creation Success']    Token Creation Success

  Set Input    //input[@id='tokenId']     ${Token_ID}
  Click Item   //button[normalize-space()='Search']
  Sleep  2s
  TakePic   Token Creation.png
  Click Item    //button[@aria-label='Edit']//div[2]
  Set Input      (//input[@id='tokenId'])[2]  ${Modify_Token_ID}
  Set Input      (//input[@id='tokenName'])[2]   ${Modify_Token_Name}
  Set Input      //textarea[@id='tokenDesc']   ${Modify_Token_Description}
  Sleep  4s
  Click Item     //button[normalize-space()='Modify']
  Sleep  4s
  Handle PopUp    //span[normalize-space()='Token Modify Success']     Token Modify Success

  Set Input    //input[@id='tokenId']     ${Modify_Token_ID}
  Click Item   //button[normalize-space()='Search']
  Sleep  2s
  TakePic   Token Modified.png
  Click Item     //button[@aria-label='Delete']//div[2]
  Click Item     //button[normalize-space()='YES']
  Sleep  4s
  Handle PopUp    //span[normalize-space()='Token Deletion Success']    Token Deletion Success
  Sleep  2s
  TakePic   Token Deleted.png
  Sleep  5s


Skip OrderId
  [Documentation]    To look Up order by Order ID
  [Arguments]     ${caseID}  ${dataID}
  ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ORDER_INFO  ${caseID}  ${dataID}
  ${ORDER_ID}=  getData  ${data}  ORDER_ID
  Log To Console  ${ORDER_ID}

  Click Item   ${OrderSearch}[Ordertab]
  Sleep  2s
  Click Item   //a[@id='/failedOrders']
  Sleep  2s
  Set Input  ${OrderSearch}[OrderSearchbar]     ${ORDER_ID}
  Click Item   ${OrderSearch}[SearchButton]
  Sleep  4s
  Click Item   //button[@aria-label='Skip']//span[@class='MuiIconButton-label']
  Sleep  4s
  Handle PopUp    //span[normalize-space()='Your Request is Processed for Skip']   Your Request is Processed for Skip
  Sleep  4s
  Click Item    ${OrderSearch}[viewOrder]
  Sleep  2s
  Click Item    //div[@class='table_refreshIcon']//div[2]
  Set Input  ${OrderSearch}[OrderSearchbar]      ${ORDER_ID}
  Click Item    ${OrderSearch}[SearchButton]
  Sleep  4s
  scroll element into view     (//button[@type='button'])[7]
  Click Item    (//button[@type='button'])[7]
  Sleep  4s
  Click Item    //button[@aria-label='View']
  Sleep  4s
  Scroll Element Into View    //div[text()='Pair Sim in NMS']//following-sibling::span[2]
  Sleep  4s
  TakePic   Skipped.png
  ${String}=  SeleniumLibrary.get text    //div[text()='Pair Sim in NMS']//following-sibling::span[2]
  Log To Console  ${String}
  Should be equal  ${String}   Skipped
  Click Item    ${OrderSearch}[OrderCloseButton]
  Sleep  5s






#Search Order By OrderId
#    [Documentation]    To look Up order by Order ID
#    [Arguments]     ${caseID}  ${dataID}
#    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ORDER_INFO  ${caseID}  ${dataID}
#    ${ORDER_ID}=  getData  ${data}  ORDER_ID
#    Log To Console  ${ORDER_ID}
#    #click element   ${OrderSearch}[Ordertab]
#    Sleep  2s
#    click element   ${OrderSearch}[viewOrder]
#    Sleep  2s
#    Click Item    //div[@class='table_refreshIcon']//div[2]
#    Set Input  ${OrderSearch}[OrderSearchbar]      ${ORDER_ID}
#    click element   ${OrderSearch}[SearchButton]
#    Sleep  4s
#    scroll element into view     (//button[@type='button'])[7]
#    click element   (//button[@type='button'])[7]
#   # click element   //button[@aria-label='View']
#    #Sleep  10s
#    #click element   ${OrderSearch}[OrderCloseButton]
#    #Sleep  5s
#    #Go Back to Home Page

Retry OrderId
    [Documentation]    To Retry OrderId
    [Arguments]     ${caseID}  ${dataID}
    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ORDER_INFO  ${caseID}  ${dataID}
    ${ORDER_ID}=  getData  ${data}  ORDER_ID
    Log To Console  ${ORDER_ID}

    Click Item   ${OrderSearch}[Ordertab]
    Sleep  2s
    Click Item   //a[@id='/failedOrders']
    Sleep  2s
    Set Input  ${OrderSearch}[OrderSearchbar]      ${ORDER_ID}
    Click Item   ${OrderSearch}[SearchButton]
    Sleep  4s
    ${Status}=  SeleniumLibrary.Get Text   //td[starts-with(text(),'424 :: Connection')]
    Print    FailedReason: ${Status}
    Click Item   //button[@aria-label='retry']//span[@class='MuiIconButton-label']
    Sleep  4s
    Handle PopUp   //span[normalize-space()='Your Request is Processed for Retry']   Your Request is Processed for Retry
    Click Item    ${OrderSearch}[viewOrder]
    Set Input  ${OrderSearch}[OrderSearchbar]       ${ORDER_ID}
    Click Item    ${OrderSearch}[SearchButton]
    Sleep  25s
    Click Item    //div[@class='table_refreshIcon']//div[2]
    Sleep  2s
    scroll element into view     (//button[@type='button'])[7]
    Click Item    (//button[@type='button'])[7]
    Sleep  4s
    Click Item    //button[@aria-label='View']
    Sleep  4s
    Scroll Element Into View        (//td[starts-with(text(),'400 :: Protected MSISDN')])[2]
    ${FailedStatusAfterRetry}=  SeleniumLibrary.Get Text      (//td[starts-with(text(),'400 :: Protected MSISDN')])[2]
    Print    FailedReason: ${FailedStatusAfterRetry}
    Should Not Be Equal   ${Status}     ${FailedStatusAfterRetry}
    TakePic   Retry.png
    Sleep  4s


#BulkOperation
#    Click Item    //tbody/tr[1]/td[1]/div[1]/input[1]
#    Click Item    //tbody/tr[2]/td[1]/div[1]/input[1]
#    Click Item    //button[normalize-space()='Skip']
#    Click Item    //button[normalize-space()='Retry']

Search Order By OrderId
    [Documentation]    To look Up order by Order ID
    [Arguments]     ${caseID}  ${dataID}
    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ORDER_INFO  ${caseID}  ${dataID}
    ${ORDER_ID}=  getData  ${data}  ORDER_ID
    Log To Console  ${ORDER_ID}
    Click Item    ${OrderSearch}[Ordertab]
    Click Item    ${OrderSearch}[viewOrder]
    Set Input  ${OrderSearch}[OrderSearchbar]      ${ORDER_ID}
    Click Item    ${OrderSearch}[SearchButton]
    scroll element into view     (//button[@type='button'])[7]
    Click Item    (//button[@type='button'])[7]
    Click Item    //button[@aria-label='View']
    Sleep  10s
    Click Item    ${OrderSearch}[OrderCloseButton]

 Audit History
    [Documentation]    To look Up Audit History
    [Arguments]     ${row}

    Click Item    //div[contains(text(),'Reports')]
    Click Item    //a[@id='/auditHistory']
    Click Item    //span[@class='adv_search']

    FOR  ${i}  IN RANGE  0  ${row}-1

      ${data}=  Fetch Row Data   ${WKD_CRM_TESTDATA}  AuditHistory_1   ${i}
      ${Feature_Name}=  get_Value1  ${data}  Feature_Name
      ${Operation_Name}=  get_Value1  ${data}  Operation_Name
      ${Status}=  get_Value1  ${data}  Status
      ${StartDate}=  get_Value1  ${data}  StartDate
      ${User}=  get_Value1  ${data}  User
      ${IP Addess}=  get_Value1  ${data}  IP Addess
      ${ServiceId}=  get_Value1  ${data}  ServiceId
      ${AccountId}=  get_Value1  ${data}  AccountId
      ${ProfileId}=  get_Value1  ${data}  ProfileId
      ${Scenario}=  get_Value1  ${data}   Scenario



      IF    '${Scenario}' == 'FilterBy FeatureName and Operation Name'
      Set Dropdown  (//label[normalize-space()='Feature Name']/following-sibling::div//div)[2]     ${Feature_Name}
      Set Dropdown  (//label[normalize-space()='Operation Name']/following-sibling::div//div)[2]   ${Operation_Name}
      Click Item    //button[normalize-space()='Search']
      Scroll Element Into View    //tbody/tr[7]/td[1]
      Sleep  2s
      Take pic  AuditHistory1.png
      Sleep  4s
      ${Featurename}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[1]
      ${Operationname}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[2]
      Should Be Equal As Strings     ${Featurename}    ${Feature_Name}
      Should Be Equal As Strings     ${Operationname}    ${Operation_Name}
      Log To Console   ${Featurename}
      Log To Console   ${Operationname}
      Click Item  //button[normalize-space()='Reset']
      END

      IF    '${Scenario}' == 'FilterBy Success Status with StartDate'
      Scroll Element Into View    (//label[normalize-space()='Status']/following-sibling::div//div)[2]
      Set Dropdown   (//label[normalize-space()='Status']/following-sibling::div//div)[2]   ${Status}
      Sleep  2s
      #${ele}   SeleniumLibrary.Get WebElement      //input[@class='react-datepicker-ignore-onclickoutside']
      #Execute Javascript   arguments[0].click();    ARGUMENTS      ${ele}
      Scroll Element Into View     (//div[@class='react-datepicker-wrapper'])[1]
      Set Date   (//div[@class='react-datepicker-wrapper'])[1]   ${StartDate}
      Click Item    //button[normalize-space()='Search']
      Sleep  4s
      Scroll Element Into View    //tbody/tr[7]/td[1]\
      Take pic     AuditHistory2.png
      ${Status}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[6]
      ${Startdate}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[7]
      Should Be Equal As Strings     ${Status}   Success
      #Should Be Equal As Strings     ${Startdate}   29/09/2022
      Log To Console   ${Status}
      Log To Console     ${Startdate}
      Sleep  4s
      Click Item  //button[normalize-space()='Reset']
      #Set Dropdown    (//label[normalize-space()='User']/following-sibling::div//div)[2]    ${User}
      END

      IF    '${Scenario}' == 'FilterBy Badrequest Status with StartDate'
      Scroll Element Into View    (//label[normalize-space()='Status']/following-sibling::div//div)[2]
      Set Dropdown   (//label[normalize-space()='Status']/following-sibling::div//div)[2]   ${Status}
      Scroll Element Into View     (//div[@class='react-datepicker-wrapper'])[1]
      Set Date   (//div[@class='react-datepicker-wrapper'])[1]    ${StartDate}
      Click Item    //button[normalize-space()='Search']
      Scroll Element Into View    //tbody/tr[7]/td[1]
      ${Status}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[6]
      ${Startdate}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[7]
      Should Be Equal As Strings     ${Status}     ${Status}
      #Should Be Equal As Strings     ${Startdate}   29/09/2022
      Log To Console   ${Status}
      Log To Console     ${Startdate}
      Sleep  2s
      TakePic     AuditHIstory3.png
      Sleep  4s
      Click Item  //button[normalize-space()='Reset']
      END

      IF    '${Scenario}' == 'FilterBy IP Address'
      Scroll Element Into View   //input[@id='ip']
      Set Input   //input[@id='ip']   ${IP Addess}
      Click Item    //button[normalize-space()='Search']
      Scroll Element Into View    //tbody/tr[7]/td[1]
      Sleep  4s
      ${IPaddress}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[5]
      Log To Console    ${IPaddress}
      Should Be Equal As Strings   ${IPaddress}  ${IP Addess}
      Sleep  2s
      TakePic   AuditHistory4.png
      Sleep  4s
      Click Item  //button[normalize-space()='Reset']
      END

      IF    '${Scenario}' == 'FilterBy ServiceId'
      Scroll Element Into View   //input[@id='serviceId']
      Set Input   //input[@id='serviceId']   ${ServiceId}
      Click Item    //button[normalize-space()='Search']
      Scroll Element Into View    //tbody/tr[7]/td[1]
      sleep  2s
      TakePic  AuditHistory5.png
      ${Serviceid}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[8]
      Log To Console    ${IPaddress}
      Should Be Equal As Strings   ${Serviceid}  ${ServiceId}
      Sleep  4s
      Click Item  //button[normalize-space()='Reset']
      END

      IF    '${Scenario}' == 'FillterBy AccountId'
      Scroll Element Into View    //input[@id='accountId']
      Set Input   //input[@id='accountId']   ${AccountId}
      Click Item    //button[normalize-space()='Search']
      Scroll Element Into View    //tbody/tr[7]/td[09]
      ${Accountid}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[9]
      Log To Console   ${Accountid}
      Should Be Equal As Strings   ${Accountid}  ${AccountId}
      Sleep  2s
      TakePic    AuditHistory6.png
      Sleep  4s
      Click Item  //button[normalize-space()='Reset']
      END

      IF    '${Scenario}' == 'FilterBy ProfileId'
      Scroll Element Into View  //input[@id='profileId']
      Set Input   //input[@id='profileId']   ${ProfileId}
      Click Item    //button[normalize-space()='Search']
      Sleep  2s
      Scroll Element Into View    //tbody/tr[5]/td[10]
      ${Profileid}=  SeleniumLibrary.Get Text     //tbody/tr[1]/td[10]
      Log To Console   ${Profileid}
      Should Be Equal As Strings   ${Profileid}  ${ProfileId}

      sleep  2s
      TakePic     AuditHistory7.png
      Sleep  4s
      #Click Item  //button[normalize-space()='Reset']
      END
    END


View Voucher details and Recharge Voucher
  [Arguments]     ${caseID}  ${dataID}

  ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  Voucher_Management   ${caseID}  ${dataID}
  ${Serial_Number}=  getData  ${data}  Serial_Number
  ${Action}=  getData  ${data}  Action
  ${Reason}=  getData  ${data}  Reason
  ${ServiceID}=  getData  ${data}  ServiceID
  ${CardPin}=  getData  ${data}  CardPin

   Click Item    //div[contains(text(),'Voucher Management')]
   Click Item    //a[@id='/voucherDetails']
   Set Input     //input[@id='cardSerialNumber']    ${Serial_Number}
   Click Item    //button[normalize-space()='Search']
   Sleep  4s
   ${SerialNumber}=  SeleniumLibrary.Get Element Attribute    //input[@id='serialNumber']  value
   Should be equal  ${SerialNumber}    12345678
   Print     Serial_Number: ${SerialNumber}

   ${MSISDN}=  SeleniumLibrary.Get Element Attribute    //input[@id='msisdn']  value
   Should be equal  ${MSISDN}    861347865213
   Print     MSISDN: ${MSISDN}

   ${CardStatus}=  SeleniumLibrary.Get Element Attribute   //input[@id='cardStatus']  value
   Should be equal  ${CardStatus}    new
   Print     Card_Status: ${CardStatus}
   Sleep  5s

   Set Dropdown   (//label[normalize-space()='Action']/following-sibling::div//div)[2]  ${Action}
   Set Dropdown     (//label[normalize-space()='Reason']/following-sibling::div//div)[2]  ${Reason}
   Set Input      //input[@id='serviceId']   ${ServiceID}
   Set Input     //input[@id='cardPinNumber']  ${CardPin}
   Click Item    //button[normalize-space()='Submit']
   Sleep  2s
   TakePic   ErrorMessage.png

Create Batch file upload
  [Arguments]     ${caseID}  ${dataID}

  ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  BatchFileUpload   ${caseID}  ${dataID}
  ${BatchType}=  getData  ${data}  BatchType
  ${SheduleDate}=  getData  ${data}  SheduleDate
  ${SheduleTime}=  getData  ${data}  SheduleTime
  ${FilePath}=  getData  ${data}  FilePath
  ${FileDescription}=  getData  ${data}  FileDescription
  ${Plan_ID}=  getData  ${data}   Plan_ID
  ${ProfileType}=  getData  ${data}  ProfileType
  ${Segment}=  getData  ${data}  Segment
  ${SubSegment}=  getData  ${data}  SubSegment
  ${ServiceType}=  getData  ${data}  ServiceType
  ${ConnectionType}=  getData  ${data}  ConnectionType
  ${Offer}=  getData  ${data}  Offer


  Click Item    //div[contains(text(),'Batch')]
  Click Item    //a[@id='/batchProcess']

  Click Item    //button[normalize-space()='Create Batch File upload']
  Set Dropdown  //div[@class='select_style error css-2b097c-container']//div[contains(@class,'css-1wa3eu0-placeholder')][normalize-space()='Select One']  ${BatchType}

  IF       '${BatchType}'== 'AdjustMainAccount'
  Set Date   //input[@placeholder='Select Date']   ${SheduleDate}
  Click Item     //li[normalize-space()='${SheduleTime}']
  Set Input      //input[@name='description']    ${FileDescription}
  Execute Javascript   var xpath = document.evaluate("//input[@accept='.txt,.pdf']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
  File Uplaod      //input[@accept='.txt,.pdf']    ${FilePath}
  Click Item    //button[normalize-space()='Submit']
  END

   IF       '${BatchType}'== 'CancelSubscription'
  Set Date   //input[@placeholder='Select Date']   ${SheduleDate}
  Click Item     //li[normalize-space()='${SheduleTime}']
  Set Input      //input[@id='planId']   ${Plan_ID}
  Set Input      //input[@name='description']    ${FileDescription}
  Execute Javascript   var xpath = document.evaluate("//input[@accept='.txt,.pdf']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
  File Uplaod      //input[@accept='.txt,.pdf']    ${FilePath}
  Click Item    //button[normalize-space()='Submit']
  Sleep  4s
  Handle PopUp      //span[normalize-space()='Batch file is uploaded successfully to processed']    Batch file is uploaded successfully to processed
  END

  IF       '${BatchType}'== 'AddSubscription'
  Set Date   //input[@placeholder='Select Date']   ${SheduleDate}
  Click Item         //li[normalize-space()='${SheduleTime}']
  Set Input      //input[@name='description']    ${FileDescription}
  Execute Javascript   var xpath = document.evaluate("//input[@accept='.txt,.pdf']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
  File Uplaod      //input[@accept='.txt,.pdf']    ${FilePath}
  Set Dropdown      (//label[normalize-space()='Profile Type']/following-sibling::div//div)[2]   ${ProfileType}
  Set Dropdown      (//label[normalize-space()='Segment']/following-sibling::div//div)[2]     ${Segment}
  Set Dropdown      (//label[normalize-space()='Sub Segment']/following-sibling::div//div)[2]  ${SubSegment}
  Set Dropdown      (//label[normalize-space()='Service Type']/following-sibling::div//div)[2]    ${ServiceType}
  Set Dropdown      (//label[normalize-space()='Connection Type']/following-sibling::div//div)[2]   ${ConnectionType}
  Click Item        //button[normalize-space()='Load Base Plans']
  Set Dropdown      (//label[normalize-space()='Base Plan']/following-sibling::div//div)[2]   Prepaid Starter Pack PO
  Click Item        //button[normalize-space()='Load Plans']
  Click Item        //div[contains(text(),'${Offer}')]/child::input
  Click Item        ${ServiceDetailsPage}[AddToCartButton]
  Click Item        //button[normalize-space()='Submit']
  Sleep  4s
  Handle PopUp      //span[normalize-space()='Batch file is uploaded successfully to processed']    Batch file is uploaded successfully to processed
  END

View and Download Batch file upload
  [Arguments]     ${caseID}  ${dataID}

  ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  BatchFileUpload   ${caseID}  ${dataID}
  ${BatchId}=  getData  ${data}  BatchId
  ${BatchType}=  getData  ${data}  BatchType
  ${Status}=  getData  ${data}  Status
  ${Channel}=  getData  ${data}  Channel

  Click Item    //div[contains(text(),'Batch')]
  Click Item    //a[@id='/batchProcess']

  Click Item    //span[@class='adv_search']
  #Set Input   //input[@id='batchId']    ${BatchId}
  Set Dropdown   (//label[normalize-space()='Batch Type']/following-sibling::div//div)[2]  ${BatchType}
  Set Dropdown   (//label[normalize-space()='Status']/following-sibling::div//div)[2]     ${Status}
  Set Dropdown   (//label[normalize-space()='Channel']/following-sibling::div//div)[2]   ${Channel}
  Click Item  //button[normalize-space()='Search']
  Sleep  4s
  Click Item    //tbody//div[2]
  Sleep  4s
  Takepic  BatchfileDetails.png
  Click Item  //button[normalize-space()='Done']

  Click Item    //button[@class='action-btn-popover btn btn-secondary']
  Click Item    //div[@class='popover-body']//div[2]
  Sleep  4s

  Click Item    //button[@class='action-btn-popover btn btn-secondary']
  Click Item  //button[@aria-label='detailed Report']//div[2]
  Sleep  4s


Manage Contact
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_ADDRESS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${data}  PROFIE_ID

    #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    #Click Item  ${ProfileDetailsPage}[ManageProfile]
    Click Item  //a[@id='/crm-ui/profile/contactManagement']
    Click Item  //button[normalize-space()='Attach Contact']
    Click Item   //tbody/tr[1]/td[1]/div[1]/input[1]
    #Click Item   //tbody/tr[2]/td[1]/div[1]/input[1]
    Click Item   //button[normalize-space()='Submit']
    Sleep  10s
    Click Item   //div[@class='table_refreshIcon']//div[2]

    ${ContactNumber}=  SeleniumLibrary.Get Text    //tbody/tr[1]/td[3]
    Should be equal  ${ContactNumber}    8147681411
    Print     Serial_Number: ${ContactNumber}

    Click Item    //tbody/tr[1]/td[5]/strong[1]/button[1]/span[1]/div[1]/div[2]
    Click Item   //button[normalize-space()='YES']
    Sleep  4s
    Handle PopUp  //span[normalize-space()='Order Placed Successfully']  Order Placed Successfully
    Click Item   //div[@class='table_refreshIcon']//div[2]
    SLeep  15s
    #Page Should Not Contain     8147681411


Create Identification Details for Enterprice

   [Documentation]    To view and validate identification details
   [Arguments]     ${caseID}  ${dataID}
   ${PROFILE}=   Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
   ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
   ${ID_NUMBER}=  getData  ${PROFILE}  ID_NUMBER
   ${Filepath}=  getData  ${PROFILE}   Filepath
   ${StartDate}=  getData  ${PROFILE}   StartDate
   ${Expiry Date}=  getData  ${PROFILE}  Expiry Date
   ${IDType}=  getData  ${PROFILE}       IDType
   ${DocumentDescription}=  getData  ${PROFILE}      DocumentDescription

   #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
   Click Item  ${ProfileDetailsPage}[ManageProfile]
   Click Item  ${ProfileDetailsPage}[IdentificationDetails]

   Click Item    //button[normalize-space()='Attach ID Details']
   Set Dropdown   (//label[normalize-space()='ID Type']/following-sibling::div//div)[2]   ${IDType}
   Set Input      //input[@id='identificationNumber']   ${ID_NUMBER}
   Set Date     (//div[@class='react-datepicker__input-container'])[1]     ${StartDate}
   Click Item   (//div[@class='react-datepicker__input-container'])[2]
   Click Item    //div[@id='actionPopUp']//select[2]
   Click Item   //option[@value='2025']
   Set Input   //input[@name='fileDescription']   ${DocumentDescription}
   Execute Javascript   var xpath = document.evaluate("//input[@accept='.txt,.pdf']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
   File Uplaod     //input[@type='file']    ${Filepath}
   Sleep  4s
   Click Item  //button[normalize-space()='Submit']
   Sleep  4s
   Handle PopUp     //span[normalize-space()='Order Placed Successfully']   Order Placed Successfully
   TakePic     Identificationdetails.png
   Click Item    //div[@class='table_refreshIcon']


   Click Item    //button[@aria-label='View']//div[2]
   Click Item    //button[normalize-space()='Upload Document']
   Set Input     //input[@name='fileDescription']  ${DocumentDescription}
   Execute Javascript   var xpath = document.evaluate("//input[@accept='.txt,.pdf']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
   File Uplaod     //input[@type='file']       ${Filepath}
   Click Item    //button[normalize-space()='Submit']
   Sleep  4s
   Handle PopUp     //span[normalize-space()='Order Placed Successfully']   Order Placed Successfully
   Click Item   //button[@aria-label='Download']//div[2]
   Sleep  4s
   Click Item     //button[normalize-space()='Done']

Modify and Delete Identification Details for Enterprice

   [Documentation]    To view and validate identification details
   [Arguments]     ${caseID}  ${dataID}
   ${PROFILE}=   Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
   ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
   ${ID_NUMBER}=  getData  ${PROFILE}  ID_NUMBER
   ${Filepath}=  getData  ${PROFILE}   Filepath
   ${StartDate}=  getData  ${PROFILE}   StartDate
   ${Expiry Date}=  getData  ${PROFILE}  Expiry Date
   ${IDType}=  getData  ${PROFILE}       IDType
   ${DocumentDescription}=  getData  ${PROFILE}      DocumentDescription


   Click Item     //button[@aria-label='Edit']//div[2]
   Set Dropdown    (//label[normalize-space()='ID Type']/following-sibling::div//div)[2]   ${IDType}
   Set Input       //input[@id='identificationNumber']    ${ID_NUMBER}
   Click Item    (//div[@class='react-datepicker__input-container'])[1]
   Set Date     (//div[@class='react-datepicker__input-container'])[1]   ${StartDate}
   Click Item    (//div[@class='react-datepicker__input-container'])[2]
   Set Date     (//div[@class='react-datepicker__input-container'])[2]   ${Expiry Date}
   Sleep  2s
   Click Item    //button[normalize-space()='Modify']
   Sleep  4s
   Handle PopUp     //span[normalize-space()='Order Placed Successfully']   Order Placed Successfully
   Sleep  10s
   Click Item    //div[@class='table_refreshIcon']
   TakePic     ModifiedIdenticationDetails.png
   ${IDNumber}=  SeleniumLibrary.Get Text    //tr[1]/td[3]
   Should Be Equal As Strings    ${IDNumber}    ${ID_NUMBER}

   Click Item     //button[@aria-label='Delete']//div[2]
   Click Item    //button[text()='YES']
   Sleep  4s
   Handle PopUp     //span[normalize-space()='Order Placed Successfully']   Order Placed Successfully
   Click Item    //div[@class='table_refreshIcon']
   sleep  10s
   Page Should Not Contain    ${ID_NUMBER}
   TakePic     DeleteIdentificationDetails.png
   #Go Back to Home Page


Manaage Profile Company Address
   [Documentation]    To edit Profile level recidential address
   [Arguments]     ${caseID}  ${dataID}

   ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_ADDRESS  ${caseID}  ${dataID}
   ${PROFIE_ID}=  getData  ${data}  PROFIE_ID
   ${REGION}=  getData  ${data}  REGION
   ${ZONE}=  getData  ${data}  ZONE
   ${WOREDA}=  getData  ${data}  WOREDA
   ${Union}=  getData  ${data}  UNION
   ${HomeNo}=  getData  ${data}  HOME_NO
   ${StreetNo}=  getData  ${data}  STREET_NO
   ${POCode}=  getData  ${data}  PO_CODE
   ${POBox}=  getData  ${data}  PO_BOX
   ${Latitude}=  getData  ${data}  LATITUDE
   ${Longitude}=  getData  ${data}  LONGITUDE
   ${Comment}=  getData  ${data}  COMMENT


   #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
   #Sleep  2s
   #Click Item  ${ProfileDetailsPage}[ManageProfile]
   #Sleep  2s
   Click Item  ${ProfileDetailsPage}[ManageProfileAddress]
   Sleep  2s
   Click Item  //button[normalize-space()='Edit Address']
   Sleep  2s
   Set Dropdown   (//label[normalize-space()='Region/City Administration']/following-sibling::div//div)[2]  ${REGION}
   Set Dropdown  (//label[normalize-space()='Zone/Sub-City']/following-sibling::div//div)[2]  ${ZONE}
   Set Dropdown    (//label[normalize-space()='Woreda']/following-sibling::div//div)[2]    ${WOREDA}
   Set Input     //input[@id='addressLine3']     ${Union}
   Set Input    //input[@id='addressLine1']      ${HomeNo}
   Set Input    //input[@id='addressLine2']    ${StreetNo}
   Set Input    //input[@id='addressLine8']      ${POCode}
   Set Input    //input[@id='addressLine9']   ${POBox}
   Set Input   //input[@id='addressLine10']      ${Latitude}
   Set Input   //input[@id='addressLine11']     ${Longitude}
   Set Input   //textarea[@id='addressComment']    ${Comment}
   Sleep  4s
   Click Item  //button[normalize-space()='Submit']
   Sleep  2s
   Handle PopUp     //span[normalize-space()='Order Placed Successfully']   Order Placed Successfully
   Click Item   //div[@class='text-md-right action-button p-0 col-md-6']//div[2]
   Sleep  4s

Document Details of ENterprise level
    [Documentation]    To view and validate document details
    [Arguments]     ${caseID}  ${dataID}
    ${PROFILE}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  PROFILE_DETAILS  ${caseID}  ${dataID}
    ${PROFIE_ID}=  getData  ${PROFILE}  PROFIE_ID
    ${DOCUMENT_NAME}=  getData  ${PROFILE}  DOCUMENT_NAME
    ${Filepath}=  getData  ${PROFILE}   Filepath
    ${DocumentDescription}=  getData  ${PROFILE}   DocumentDescription

    #Search By ID  ${HomePage}[HomeSeachOptionProfileId]  ${PROFIE_ID}
    #Click Item  ${ProfileDetailsPage}[ManageProfile]
    scroll element into view     ${ProfileDetailsPage}[ViewDocumentDetails]
    Click Item  ${ProfileDetailsPage}[ViewDocumentDetails]
    Click Item  //button[normalize-space()='Add Document']
    Set Dropdown   (//label[normalize-space()='Document Type']/following-sibling::div//div)[2]   ${DOCUMENT_NAME}
    Set Input   //input[@name='fileDescription']   ${DocumentDescription}
    Execute Javascript   var xpath = document.evaluate("//input[@accept='.txt,.pdf']", document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.style.setProperty('display', 'block');
    File Uplaod     //input[@type='file']       ${Filepath}
    Click Item    //button[normalize-space()='Submit']
    Sleep  4s

    Set Input         ${ProfileDetailsPage}[InputDocumentID]   ${DOCUMENT_NAME}
    Click Item  ${ProfileDetailsPage}[DocumentSearch]
    Sleep  4s


    Click Item   //button[@aria-label='Download']//div[2]
    Sleep  4s

    Click Item   //button[@aria-label='Delete']//div[2]
    Click Item   //button[normalize-space()='YES']
    Sleep  4s
    Click Item  //div[@class='table_refreshIcon']//div[2]
    Sleep  4s


View Transcation History
    [Arguments]     ${caseID}  ${dataID}
    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  TranscationHistory  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${SheduleDate}=  getData  ${data}  SheduleDate
    ${SheduleMonth}=  getData  ${data}  SheduleMonth
    ${SheduleTime}=  getData  ${data}  SheduleTime
    #${TranscationType}=  List len    TranscationType

    #Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item   //span[normalize-space()='Transaction History']
    Click Item   //span[@class='adv_search']
    Sleep  2s
    #Set Dropdown5    (//label[normalize-space()='Transaction Type']/following-sibling::div//div)[2]     ${TranscationType}
    Click Item   (//div[@class='react-datepicker__input-container'])[1]
    Set Month       (//select[1])[1]   //option[@value='September']  ${SheduleMonth}
    Click Item   //div[@aria-label='${SheduleDate}']
    Click Item   //li[normalize-space()='${SheduleTime}']
    Click Item  //button[normalize-space()='Search']
    Sleep  7s
    Scroll Element Into View    //div[@class='pagination_record']
    Sleep  4s

    Click Item   (//span[contains(text(),'Details')])[4]
    Sleep   4s
    TakePic   Details.png
    Click Item   //button[normalize-space()='Done']
    sleep  4s

    Click Item  (//span[contains(text(),'Bucket Details')])[1]
    Sleep  4s
    TakePic    Bucketdetails.png
    Click Item   //button[normalize-space()='Done']
    Sleep  4s

    Click Item     //button[normalize-space()='Export']
    Sleep  4s
    TakePic  Export.png
    Sleep  4s


Plan Subscriptions
    [Documentation]   View Plan Subscrptions
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  OFFER  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${OFFER}=  getData  ${data}  OFFER
    ${PlanId}=  getData  ${data}  PlanId
    ${PlanStatus}=  getData  ${data}  PlanStatus
    ${PlanType}=  getData  ${data}  PlanType

    #Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item      ${ServiceDetailsPage}[PlanSubscriptionButton]
    Sleep  2s
    Scroll Element Into View   //div[@class='pagination_pageno']
    Sleep  2s
    TakePic   ViewPlan.png
    Sleep  2s

    Click Item   //span[@class='adv_search']
    Set Input  //input[@id='planId']   ${PlanId}
    Set Dropdown   (//label[normalize-space()='Status']/following-sibling::div//div)[2]    ${PlanStatus}
    Set Dropdown   (//label[normalize-space()='Plan Type']/following-sibling::div//div)[2]   ${PlanType}
    Click Item  //button[normalize-space()='Search']
    Scroll Element Into View   //div[@class='pagination_pageno']
    Sleep  4s
    TakePic  ViewPlanByFilter.png
    Sleep  4s


OrderDetails in Service
   [Documentation]   View OrderDetails
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  OFFER  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${OFFER}=  getData  ${data}  OFFER
    ${PlanId}=  getData  ${data}  PlanId
    ${PlanStatus}=  getData  ${data}  PlanStatus
    ${PlanType}=  getData  ${data}  PlanType
    ${OrderId}=  getData  ${data}  OrderId

    #Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item      //span[normalize-space()='Order Details']
    Sleep  2s
    Scroll Element Into View   //div[@class='pagination_record']
    Sleep  4s
    TakePic   ViewOrderDetails.png
    Sleep  2s

    Click Item   //span[@class='adv_search']
    Set Input  //input[@id='orderId']   ${OrderId}
    #Set Dropdown   (//label[normalize-space()='Status']/following-sibling::div//div)[2]    ${PlanStatus}
    #Set Dropdown   (//label[normalize-space()='Plan Type']/following-sibling::div//div)[2]   ${PlanType}
    Click Item  //button[normalize-space()='Search']
    Scroll Element Into View   //div[@class='pagination_record']
    Sleep  4s
    TakePic  ViewOrderByFilter.png
    Sleep  4s


Notification Deatails
    [Documentation]   View Notification Deatails
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  NotificationDetails  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${Channel}=  getData  ${data}  Channel
    ${SheduleDate}=  getData  ${data}  SheduleDate
    ${SheduleMonth}=  getData  ${data}  SheduleMonth
    ${SheduleTime}=  getData  ${data}  SheduleTime

    #Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item   //span[normalize-space()='Notification Details']
    Sleep  2s
    Scroll Element Into View    //div[@class='pagination_pageno']
    Sleep  2s
    TakePic   ViewNotificationDetails.png
    Click Item   //th[normalize-space()='Transaction ID']
    Sleep  4s
    Click Item   //span[@class='adv_search']
    Set Dropdown  (//label[normalize-space()='Channel']/following-sibling::div//div)[2]    ${Channel}\
    Click Item   (//div[@class='react-datepicker__input-container'])[1]
    Set Month       (//select[1])[1]   //option[@value='August']  ${SheduleMonth}
    Click Item   //div[@aria-label='${SheduleDate}']
    Click Item   //li[text()='${SheduleTime}']

#    Set Date   (//div[@class='react-datepicker__input-container'])[1]   ${SheduleDate}
#    Click Item    //li[text()='${SheduleTime}']
    Click Item  //button[normalize-space()='Search']
    Scroll Element Into View    //div[@class='pagination_pageno']
    Sleep  2s
    TakePic   NotificationDetailsByFilter.png
    #Click Item   //th[normalize-space()='Transaction ID']
    Click Item  (//span[contains(text(),'Message')])[1]
    Sleep  4s
    TakePic  Message.png
    Click Item    //button[normalize-space()='Done']


View HLR Details
    [Documentation]    To View HLR Details
    [Arguments]     ${caseID}  ${dataID}
    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  SERVICE_DETAILS  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID


#    Search By ID  ${HomePage}[HomeSeachOptionServiceId]  ${SERVICE_ID}
    Click Item  ${ServiceDetailsPage}[ManageService]
    Click Item    //a[@id='/crm-ui/profile/account/service/hlrManagement']
    Sleep  2s
    Scroll Element Into View     //div[@class='pagination_record']
    Sleep  7s
    TakePic  HLRDetails.png
    ${ServiceName}=  SeleniumLibrary.Get Text   //tbody/tr[1]/td[1]
    Print    ServiceName: ${ServiceName}

    ${ServiceNameStatus}=  SeleniumLibrary.Get Text   //tbody/tr[1]/td[2]
    Print    ServiceNameStatus: ${ServiceNameStatus}



Change Status To Bar Service
    [Documentation]    To Change Status
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ChangeStatus  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${Reason}=  getData  ${data}  Reason
    ${Bar Service}=  getData  ${data}  Bar Service
    ${UnBar Service}=  getData  ${data}  UnBar Service

    Go Back to Home Page
    Search By ID  ${HomePage}[HomeSeachOptionServiceId]    ${SERVICE_ID}
    Click Item  ${ServiceDetailsPage}[ManageService]
    Click Item    //a[@id='/crm-ui/profile/account/service/changeStatus']
    Set Slider    Bar Service   ${Bar Service}
    Set Dropdown   (//label[normalize-space()='Reason']/following-sibling::div//div)[2]    ${Reason}
    Click Item    //button[normalize-space()='Submit']
    #Sleep  300s
    log to console     ${SERVICE_ID}

    Click Item  //div[contains(text(),'Order Management')]
    Click Item    ${OrderSearch}[viewOrder]
    Sleep  2s
    #Click Item    //div[@class='table_refreshIcon']//div[2]
    Click Item   //span[@class='adv_search']
    Set Dropdown   (//label[normalize-space()='Order Type']/following-sibling::div//div)[2]    LineBarring
    Set Input     //input[@id='serviceId']   ${SERVICE_ID}
    Click Item   (//div[@class='react-datepicker__input-container'])[1]
    Click Item   //div[@class='react-datepicker__today-button']
    Click Item   (//div[@class='react-datepicker__input-container'])[2]
    Click Item   //div[@class='react-datepicker__today-button']
    Click Item    ${OrderSearch}[SearchButton]
    Sleep  4s
    ${OrderStatus}=   Seleniumlibrary.Get Text  //tbody/tr[1]/td[4]
    Log To Console    ${OrderStatus}

Change Status To UnBar Service
    [Documentation]    To Change Status
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  ChangeStatus  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${Reason}=  getData  ${data}  Reason
    ${Bar Service}=  getData  ${data}  Bar Service
    ${UnBar Service}=  getData  ${data}  UnBar Service

    Go Back to Home Page
    Click Item   //div[contains(text(),'Order Management')]
    Click Item    ${OrderSearch}[viewOrder]
    Sleep  2s
    #Click Item    //div[@class='table_refreshIcon']//div[2]
    Click Item   //span[@class='adv_search']
    Set Dropdown   (//label[normalize-space()='Order Type']/following-sibling::div//div)[2]    LineBarring
    Set Input     //input[@id='serviceId']   ${SERVICE_ID}
    Click Item   (//div[@class='react-datepicker__input-container'])[1]
    Click Item   //div[@class='react-datepicker__today-button']
    Click Item   (//div[@class='react-datepicker__input-container'])[2]
    Click Item   //div[@class='react-datepicker__today-button']
    Click Item    ${OrderSearch}[SearchButton]
    Sleep  4s
    ${OrderStatus}=   Seleniumlibrary.Get Text  //tbody/tr[1]/td[4]
    Log To Console    ${OrderStatus}

    Should Be Equal As Strings   ${OrderStatus}   Completed

    Go Back to Home Page
    Search By ID  ${HomePage}[HomeSeachOptionServiceId]    ${SERVICE_ID}
    Click Item  ${ServiceDetailsPage}[ManageService]
    Click Item    //a[@id='/crm-ui/profile/account/service/changeStatus']
    Set Slider    UnBar Service   ${UnBar Service}
    Click Item    //button[normalize-space()='Submit']
    Sleep  4s


View and Update Language
    [Documentation]    View and Update Lunguage
    [Arguments]     ${caseID}  ${dataID}

    ${data}=  Fetch From Excel  ${WKD_CRM_TESTDATA}  UpdateLanguage  ${caseID}  ${dataID}
    ${SERVICE_ID}=  getData  ${data}  SERVICE_ID
    ${Languge}=  getData  ${data}  Languge
    ${Comment}=  getData  ${data}  Comment

    Search By ID  ${HomePage}[HomeSeachOptionServiceId]    ${SERVICE_ID}
    Click Item  ${ServiceDetailsPage}[ManageService]
    Click Item   //div[@class='MuiTypography-root MuiTreeItem-label MuiTypography-body1'][normalize-space()='Details']
    Click Item    //a[@id='/crm-ui/profile/account/service/updateLanguage']
    Sleep  2s
    ${ActiveLanguage}=  SeleniumLibrary.Get Text    //div[@class='mdash-root col-md']//div[@class='mdash-value']
    Log To Console    ${ActiveLanguage}
    TakePic   ActiveLanguage.png

    Set Dropdown   (//label[normalize-space()='Language']/following-sibling::div//div)[2]   ${Languge}
    Set Input     //textarea[@id='comment']   ${Comment}
    Click Item    //button[normalize-space()='Submit']

    Sleep  4s
    Click Item    //div[@class='col-md-12']//div[1]//div[2]
    Sleep  4s
    ${UpdatedActiveLanguage}=  SeleniumLibrary.Get Text    //div[@class='mdash-root col-md']//div[@class='mdash-value']
    Log To Console    ${UpdatedActiveLanguage}
    TakePic  UpdatedActiveLanguage.png

    Should Be Equal As Strings    ${UpdatedActiveLanguage}    ${Languge}








































