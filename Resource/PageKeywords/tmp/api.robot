*** Settings ***
Library    Collections
Library    RequestsLibrary

Suite Setup    Create Session  jsonplaceholder  https://jsonplaceholder.typicode.com

*** Test Cases ***

  Get Request Test
      Create Session    google  http://www.google.com

      ${resp_google}=   GET On Session  google  /  expected_status=200
      ${resp_json}=     GET On Session  jsonplaceholder  /posts/1

      Should Be Equal As Strings          ${resp_google.reason}  OK
      Dictionary Should Contain Value     ${resp_json.json()}  sunt aut facere repellat provident