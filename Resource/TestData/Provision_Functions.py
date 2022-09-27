import openpyxl
import requests
import json
import random

import http
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def OnBoarding_API(MSISDN, ICCID, IMSI, FAMILYNAME):
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

    KYC_REF = random.randint(10000, 20000)
    kycReferenceId = "2212334" + str(KYC_REF)
    identificationId = "P122355" + str(KYC_REF)
    languageCode = str(KYC_REF)

    ################################ ALTERING HEADER #####################################
    alter_header = json.loads(headers)
    alter_header['x-trace-id'] = str(KYC_REF)
    headers = json.dumps(alter_header)

    ################################ ALTERING REQUEST BODY #####################################
    alter_obj = json.loads(json_string)
    alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['serviceId'] = MSISDN
    alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['characteristics'][0]['value'] = ICCID
    alter_obj['profile']['account']['serviceGroups'][0]['services'][0]['characteristics'][1]['value'] = IMSI
    alter_obj['profile']['familyName'] = FAMILYNAME
    alter_obj['profile']['languageAbility'][0]['languageCode'] = languageCode
    alter_obj['profile']['individualIdentification'][0]['attachment'][0]['kycReferenceId'] = kycReferenceId
    alter_obj['profile']['individualIdentification'][0]['identificationId'] = identificationId

    json_string = json.dumps(alter_obj)
    print(kycReferenceId)
    print(identificationId)

    r_wakanda = requests.post(url, data=json_string, headers=json.loads(headers), verify=False)
    Response = r_wakanda.json()
    orderId = Response['orderId']

    print(Response)
    return orderId


def UpdateStatus(MSISDN):
    headers = ''' {
    "x-trace-id": "123278300",
    "username": "eKYC",
    "channel": "eKYC"
    }
    '''

    url = 'https://wakanda.apigw.10.0.14.241.nip.io/order-service/orders/update-starterpack-kyc'

    json_string = '''
    {
    "orderType": "UpdateStarterPackKYC",
    "externalId": "PO-456",
    "requestedCompletionDate": "2021-11-26T03:26:26.627Z",
    "requestedStartDate": "2021-11-26T03:26:26.627Z",
    "customerInfo": {
        "birthDate": "18-04-1999",
        "familyName": "Thomas",
        "serviceId": "${MSISDN}",
        "givenName": "Sruthy${trans_id}",
        "nationality": "3",
        "title": "1",
        "relatedParty": [
            {
                "id": "1",
                "name": "Navin",
                "role": "G",
                "emailAddress": "navin@gmail.com",
                "phoneNumber": "9876587855",
                "alternatePhoneNumber": "987654754544"
            }
        ],
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
                "name": "subscriberSubCategory",
                "valueType": "string",
                "value": "231"
            },
            {
                "name": "biometricId",
                "valueType": "string",
                "value": "32132434324"
            },
            {
                "name": "minorFlag",
                "valueType": "string",
                "value": "1"
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
                        "name": "passport copy",
                        "url": "wwww.docsshare.com/customer11/passport/passport.pdf",
                        "kycReferenceId": "1212323${trans_id}"
                    }
                ],
                "identificationId": "13213232${trans_id}",
                "identificationType": "107",
                "issuingAuthority": "ethiopian embassy",
                "issuingDate": "2021-11-09",
                "validFor": {
                    "endDateTime": "2001-11-10T07:00:43.894Z",
                    "startDateTime": "2026-11-09T07:00:43.894Z"
                }
            }
        ],
        "contactMedium": [
            {
                "preferred": false,
                "mediumType": "telephoneNumber",
                "characteristic": {
                    "phoneNumber": "9381231283213",
                    "contactType": "smsNumber"
                }
            },
            {
                "preferred": false,
                "mediumType": "telephoneNumber",
                "characteristic": {
                    "faxNumber": "11231283213",
                    "contactType": "faxNumber"
                }
            },
            {
                "characteristic": {
                    "contactType": "alternateSmsNumber",
                    "altPhoneNumber": "9738646475"
                },
                "mediumType": "telephoneNumber"
            },
            {
                "preferred": false,
                "mediumType": "emailAddress",
                "characteristic": {
                    "emailAddress": "testing@gmail.com",
                    "contactType": "emailAddress"
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
            },
            {
                "characteristic": {
                    "contactType": "residentialAddress",
                    "addrLine1": "house no R268",
                    "addrLine2": "1000 ADDIS RABABA",
                    "addrLine3": "Kebele 1, R1302/29",
                    "addrLine4": 2,
                    "addrLine5": 1,
                    "addrLine6": 1,
                    "addrLine7": 1,
                    "addrLine8": "R1000",
                    "addrLine9": "RP.O. Box 1519",
                    "addrLine10": "R8.9806",
                    "addrLine11": "R38.7578"
                },
                "mediumType": "address"
            }
        ]
    }
}

    '''

    KYC_REF = random.randint(10000, 20000)
    kycReferenceId = "2212334" + str(KYC_REF)
    identificationId = "P122355" + str(KYC_REF)
    languageCode = str(KYC_REF)

    ################################ ALTERING HEADER #####################################
    alter_header = json.loads(headers)
    alter_header['x-trace-id'] = str(KYC_REF)
    headers = json.dumps(alter_header)

    ################################ ALTERING REQUEST BODY #####################################
    alter_obj = json.loads(json_string)

    json_string = json.dumps(alter_obj)
    print(kycReferenceId)
    print(identificationId)

    r_wakanda = requests.post(url, data=json_string, headers=json.loads(headers), verify=False)
    Response = r_wakanda.json()
    orderId = Response['orderId']

    print(Response)
    return Response
