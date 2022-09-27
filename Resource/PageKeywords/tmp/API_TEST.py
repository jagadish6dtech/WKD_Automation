import requests
import json

import http
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


kyc_ref="278600"
Random="3242342644"
MSISDN="251793000732"
ICCID="8925102406450009248"
IMSI="636024060001111"

url = 'https://wakanda.apigw.10.0.14.241.nip.io/order-service/orders/onboarding'

json_string = ''' {
    "orderType": "Onboarding",
    "description": "Onboarding order",
    "externalId": "12131201260471312",
    "profile": {
        "birthDate": "18-04-1997",
        "familyName": "Joy${kyc_ref}",
        "givenName": "hmmm",
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
                                    "value": "${ICCID}"
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




headers= ''' {
"x-trace-id": "123278300",
"username": "eKYC",
"channel": "eKYC"
}
'''

JSON_HEADER=json.loads(headers)
request_body = json.loads(json_string)
#print(stud_obj)
#print(stud_obj)
#print("The type of object is: ", type(stud_obj))
#json_obj = json.dumps(stud_obj)

#print("The type of object is: ", type(json_obj))

uri='https://reqres.in/api/register'
req= ''' {
    "email": "eve.holt@reqres.in",
    "password": "pistol"
    }
'''

r = requests.post(uri, data=json.loads(req))
print(dir(r))
print(r.__attrs__)

respone_output=json.loads(r.content)
#print(respone_output["id"])
#print(respone_output["token"])

r_wakanda = requests.post(url, data=json_string,headers=json.loads(headers),verify = False)
print(r_wakanda.content.orderId)
