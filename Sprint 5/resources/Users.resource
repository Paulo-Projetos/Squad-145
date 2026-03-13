*** Settings ***
Library    RequestsLibrary
Variables    ../resources/variables.py
Resource    ../resources/Authorized.resource

*** Keywords ***
Create User
    ${body}    Create Dictionary    userName=${username}    password=${password}
    ${response}    POST    url=${url}/Account/v1/User    json=${body}    expected_status=any
    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE TEXT: ${response.text}
    ${response_body}    Set Variable    ${response.json()}

    # Validação do status code
    Should Be Equal As Integers    ${response.status_code}    201

    # Validação da estrutura de resposta do JSON
    Should Not Be Empty    ${response_body}[userID]
    Should Be Equal       ${response_body}[username]    ${username}
    Length Should Be      ${response_body}[books]    0

    # Armazenando o userId para os próximos testes
    ${userId}    Set Variable    ${response_body}[userID]
    Set Suite Variable    ${userId}

Get User With Book
    ${headers}    Create Dictionary    Authorization=Bearer ${Token}
    ${response}    GET    url=${url}/Account/v1/User/${userId}    headers=${headers}

    Should Be Equal As Integers    ${response.status_code}    200

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE BODY: ${response.json()}
    Log    RESPONSE BODY: ${response.json()}

    ${body}=    Set Variable    ${response.json()}
    ${books}=    Set Variable    ${body["books"]}
    ${books_count}=    Evaluate    len($books)

    Should Be Equal    ${body["userId"]}    ${userId}
    Should Not Be Empty    ${body["username"]}
    Should Be True    isinstance($books, list)
    Should Be True    ${books_count} > 0    usuário deve possuir ao menos um livro

    Should Not Be Empty    ${books[0]["isbn"]}
    Should Not Be Empty    ${books[0]["title"]}
    Should Not Be Empty    ${books[0]["author"]}
    Should Be Equal    ${books[0]["isbn"]}    ${isbn}

Get User Without Book
    ${headers}    Create Dictionary    Authorization=Bearer ${Token}
    ${response}    GET    url=${url}/Account/v1/User/${userId}    headers=${headers}

    Should Be Equal As Integers    ${response.status_code}    200

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE BODY: ${response.json()}
    Log    RESPONSE BODY: ${response.json()}

    ${body}=    Set Variable    ${response.json()}
    ${books}=    Set Variable    ${body["books"]}

    Should Be Equal    ${body["userId"]}    ${userId}
    Should Not Be Empty    ${body["username"]}
    Should Be True    isinstance($books, list)
    Length Should Be    ${books}    0


Delete User
    ${headers}    Create Dictionary    Authorization=Bearer ${Token}
    ${response}    DELETE    url=${url}/Account/v1/User/${userId}    headers=${headers}

    Should Be Equal As Integers    ${response.status_code}    204

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE TEXT: ${response.text}
    Log    RESPONSE TEXT: ${response.text}

Get Deleted User
    ${headers}    Create Dictionary    Authorization=Bearer ${Token}
    ${response}    GET    url=${url}/Account/v1/User/${userId}    headers=${headers}    expected_status=401

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE TEXT: ${response.text}
    Log    RESPONSE TEXT: ${response.text}

    ${resp_body}=    Set Variable    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    401
    Should Be Equal    ${resp_body["code"]}    1207
    Should Be Equal    ${resp_body["message"]}    User not found!