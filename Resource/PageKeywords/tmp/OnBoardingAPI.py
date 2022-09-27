import requests
import json
import random

import http
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


kyc_ref="278600"
MSISDN="251793000732"
ICCID="8925102406450009248"
IMSI="636024060001111"
FAMILYNAME="ABHIRAM"


def OnBoarding_API(MSISDN,ICCID,IMSI,FAMILYNAME):


    headers = ''' {
    "x-trace-id": "123278300",
    "username": "eKYC",
    "channel": "eKYC"
    }
    '''

    url = 'https://wakanda.apigw.10.0.14.241.nip.io/order-service/orders/onboarding'

    json_string = ''' {
        "orderType": "Onboarding",
        "description": "Onboarding order",
        "externalId": "12131201260471312",
        "profile": {
            "birthDate": "18-04-1997",
            "familyName": "Joy${kyc_ref}",
            "givenName": "Joy",
            "nationality": "3",
            "title": "1",
            "partyCharacteristic": [
                {
                    "name": "profileType",
                    "valueType": "string",
                    "value": "0"
                },
                {
                    "name": "subscriberCategory",
                    "valueType": "string",
                    "value": "23"
                },
                {
                    "name": "minorFlag",
                    "valueType": "string",
                    "value": "0"
                },
                {
                    "name": "subscriberSubCategory",
                    "valueType": "string",
                    "value": "231"
                },
                {
                    "name": "biometricId",
                    "valueType": "string",
                    "value": "42132430338"
                },
                {
                    "name": "paymentPreference",
                    "valueType": "string",
                    "value": "2,1"
                }
            ],
            "languageAbility": [
                {
                    "languageCode": "${__Random(1,5)}"
                }
            ],
            "individualIdentification": [
                {
                    "attachment": [
                        {
                            "content": "pdf",
                            "description": "passport pdf",
                            "mimeType": "pdf",
                            "name": "passport_joy.pdf",
                            "url": "wwww.docsshare.com/customer11/passport/passport_joy.pdf",
                            "kycReferenceId": "2212334${kyc_ref}"
                        }
                    ],
                    "identificationId": "P122355${kyc_ref}",
                    "identificationType": "107",
                    "issuingAuthority": "ethiopian embassy",
                    "issuingDate": "28-02-2019 12:00:00",
                    "validFor": {
                        "endDateTime": "01-03-2028 00:00:00",
                        "startDateTime": "01-03-2019 00:00:00"
                    }
                }
            ],
            "contactMedium": [
                {
                    "preferred": false,
                    "mediumType": "telephoneNumber",
                    "characteristic": {
                        "phoneNumber": "251187000069",
                        "contactType": "smsNumber"
                    }
                },
                {
                    "preferred": false,
                    "mediumType": "telephoneNumber",
                    "characteristic": {
                        "faxNumber": "251187000070",
                        "contactType": "faxNumber"
                    }
                },
                {
                    "characteristic": {
                        "contactType": "alternateSmsNumber",
                        "altPhoneNumber": "251187000071"
                    },
                    "mediumType": "telephoneNumber"
                },
                {
                    "preferred": false,
                    "mediumType": "emailAddress",
                    "characteristic": {
                        "emailAddress": "Williamjoy2@87@gmail.com",
                        "contactType": "emailAddress"
                    }
                },
                {
                    "mediumType": "address",
                    "characteristic": {
                        "contactType": "residentialAddress",
                        "addrLine1": "house no 268",
                        "addrLine2": "1000 ADDIS ABABA",
                        "addrLine3": "Kebele 1, 1302/29",
                        "addrLine4": 2,
                        "addrLine5": 1,
                        "addrLine6": 1,
                        "addrLine7": 1,
                        "addrLine8": "1000",
                        "addrLine9": "P.O. Box 1519",
                        "addrLine10": "8.9806",
                        "addrLine11": "38.7578"
                    }
                },
                {
                    "characteristic": {
                        "contactType": "permanentAddress",
                        "addrLine1": "house no 268",
                        "addrLine2": "1000 ADDIS ABABA",
                        "addrLine3": "Kebele 1, 1302/29",
                        "addrLine4": 2,
                        "addrLine5": 1,
                        "addrLine6": 1,
                        "addrLine7": 1,
                        "addrLine8": "1000",
                        "addrLine9": "P.O. Box 1519",
                        "addrLine10": "8.9806",
                        "addrLine11": "38.7578"
                    },
                    "mediumType": "address"
                }
            ],
            "account": {
                "chargingPattern": "2",
                "languageId": "1",
                "name": "Joy",
                "remarks": "string",
                "title": "Mr",
                "preferredCurrency": "USSD",
                "contactMedium": [
                    {
                        "mediumType": "address",
                        "characteristic": {
                            "contactType": "billingAddress",
                            "addrLine1": "house no 268",
                            "addrLine2": "1000 ADDIS ABABA",
                            "addrLine3": "Kebele 1, 1302/29",
                            "addrLine4": 2,
                            "addrLine5": 1,
                            "addrLine6": 1,
                            "addrLine7": 1,
                            "addrLine8": "1000",
                            "addrLine9": "P.O. Box 1519",
                            "addrLine10": "8.9806",
                            "addrLine11": "38.7578"
                        }
                    }
                ],
                "serviceGroups": [
                    {
                        "services": [
                            {
                                "serviceId": "${MSISDN}",
                                "isSimPaired": "false",
                                "name": "GSM Service",
                                "languageId": "1",
                                "serviceType": "Master",
                                "networkServiceId": "1",
                                "chargingPattern": "2",
                                "contactMedium": [
                                    {
                                        "mediumType": "address",
                                        "characteristic": {
                                            "contactType": "residentialAddress",
                                            "addrLine1": "house no 268",
                                            "addrLine2": "1000 ADDIS ABABA",
                                            "addrLine3": "Kebele 1, 1302/29",
                                            "addrLine4": 2,
                                            "addrLine5": 1,
                                            "addrLine6": 1,
                                            "addrLine7": 1,
                                            "addrLine8": "1000",
                                            "addrLine9": "P.O. Box 1519",
                                            "addrLine10": "8.9806",
                                            "addrLine11": "38.7578"
                                        }
                                    }
                                ],
                                "characteristics": [
                                    {
                                        "name": "ICCID",
                                        "valueType": "string",
                                        "value": "{ICCID}"
                                    },
                                    {
                                        "name": "IMSI",
                                        "valueType": "string",
                                        "value": "${IMSI}"
                                    }
                                ],
                                "subscriptions": [
                                    {
                                        "planId": "23",
                                        "planType": "0",
                                        "planName": "Prepaid StarterPack PO",
                                        "autoRenewal": "0"
                                    }

                                ]
                            }
                        ]
                    }
                ]
            }
        },
        "authentication": {
            "authType": "Biometric",
            "authId": "Biometric"
        }
    }
    '''

    KYC_REF=random.randint(10000, 20000)
    kycReferenceId="2212334"+str(KYC_REF)
    identificationId="P122355"+str(KYC_REF)
    languageCode=str(KYC_REF)

    ################################ ALTERING HEADER #####################################
    alter_header=json.loads(headers)
    alter_header['x-trace-id']=str(KYC_REF)
    headers = json.dumps(alter_header)

    ################################ ALTERING REQUEST BODY #####################################
    alter_obj = json.loads(json_string)
    alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['serviceId']=MSISDN
    alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['characteristics'][0]['value']=ICCID
    alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['characteristics'][1]['value']=IMSI
    alter_obj['profile']['familyName']=FAMILYNAME
    alter_obj['profile']['languageAbility'][0]['languageCode']=languageCode
    alter_obj['profile']['individualIdentification'][0]['attachment'][0]['kycReferenceId']=kycReferenceId
    alter_obj['profile']['individualIdentification'][0]['identificationId']=identificationId


    json_string = json.dumps(alter_obj)
    print(kycReferenceId)
    print(identificationId)

    r_wakanda = requests.post(url, data=json_string, headers=json.loads(headers), verify=False)
    Response = r_wakanda.json()
    orderId = Response['orderId']

    print("MSISDN - " + MSISDN)
    print("ICCID - " + ICCID)
    print("IMSI - " + IMSI)
    print("FAMILYNAME - " + FAMILYNAME)
    print("languageCode - " + languageCode)
    print("kycReferenceId - " + kycReferenceId)
    print("identificationId - " + identificationId)

    print(Response)
    return orderId




kyc_ref="278600"
MSISDN="251711017093"
ICCID="8925102406450009999"
IMSI="636024060009999"
FAMILYNAME="ABHIRAM"


OnBoarding_API(kyc_ref,MSISDN,ICCID,IMSI,FAMILYNAME)






#alter_obj = json.loads(json_string)
#alter_obj['profile']['familyName']='Sasi'
#print ("+++++++++++++++++++++++++++++++++++++")
#print(alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['serviceId'])
#print(alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['characteristics'][0]['value'])
#print(alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['characteristics'][1]['value'])
#print(alter_obj['profile']['familyName'])
#print(alter_obj['profile']['languageAbility'][0]['languageCode'])
#print ("+++++++++++++++++++++++++++++++++++++")
#print("The type of object is: ", type(alter_obj))
#json_obj = json.dumps(alter_obj)
#print(json_obj)
#print("The type of object is: ", type(json_obj))

#r_wakanda = requests.post(url, data=json_obj, headers=json.loads(headers), verify=False)
#Response = r_wakanda.json()
#orderId = Response['orderId']
#print ("+++++++++++++++++++++++++++++++++++++")
#print (orderId)
#print ("+++++++++++++++++++++++++++++++++++++")
#print(random.randint(10000, 20000))