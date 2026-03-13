*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables    ../resources/variables.py

*** Keywords ***
Create Token
    ${body}    Create Dictionary    userName=${username}    password=${password}
    ${response}    POST    url=${url}/Account/v1/GenerateToken    json=${body}

    Should Be Equal As Integers    ${response.status_code}    200
    ${response_body}    Set Variable    ${response.json()}

    Log To Console    RESPONSE BODY: ${response_body}
    
    # Validação da estrutura de resposta do JSON
    Dictionary Should Contain Item    ${response_body}    status    Success
    Should Not Be Empty    ${response_body}[token]
    Should Not Be Empty    ${response_body}[expires]
    Should Be Equal        ${response_body}[status]    Success
    Should Contain         ${response_body}[result]    User authorized

    # Guardando o token para os próximos testes
    ${Token}    Set Variable    ${response_body}[token]
    Set Suite Variable    ${Token}


Authorized User
    ${body}    Create Dictionary    userName=${username}    password=${password}
    ${response}    POST    url=${url}/Account/v1/Authorized    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}            ${{bool(True)}}
