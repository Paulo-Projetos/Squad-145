*** Settings ***
Library    RequestsLibrary
Variables    ../resources/variables.py
Resource    ../resources/Authorized.resource
Resource    ../resources/Users.resource

*** Keywords ***
Get Books
    ${response}    GET    url=${url}/BookStore/v1/Books

    Should Be Equal As Integers    ${response.status_code}    200

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE BODY: ${response.json()}
    Log    RESPONSE BODY: ${response.json()}

    ${body}=    Set Variable    ${response.json()}
    ${books}=    Set Variable    ${body["books"]}
    ${books_count}=    Evaluate    len($books)

    Should Be True    isinstance($books, list)    books deve ser uma lista
    Should Be True    ${books_count} > 0    a lista de livros não deve estar vazia

    Should Not Be Empty    ${books[0]["isbn"]}
    Should Not Be Empty    ${books[0]["title"]}
    Should Not Be Empty    ${books[0]["subTitle"]}
    Should Not Be Empty    ${books[0]["author"]}
    Should Not Be Empty    ${books[0]["publish_date"]}
    Should Not Be Empty    ${books[0]["publisher"]}
    Should Be True         ${books[0]["pages"]} >= 0
    Should Not Be Empty    ${books[0]["description"]}
    Should Not Be Empty    ${books[0]["website"]}

    ${isbn}    Set Variable    ${books[0]["isbn"]}
    Set Suite Variable    ${isbn}

Add Book
    ${headers}    Create Dictionary    Authorization=Bearer ${Token}    Content-Type=application/json
    ${isbn_obj}    Create Dictionary    isbn=${isbn}
    ${list}    Create List    ${isbn_obj}
    ${body}    Create Dictionary    userId=${userId}    collectionOfIsbns=${list}
    ${response}    POST    url=${url}/BookStore/v1/Books    headers=${headers}    json=${body}

    Should Be Equal As Integers    ${response.status_code}    201

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE BODY: ${response.json()}
    Log    RESPONSE BODY: ${response.json()}

    ${resp_body}=    Set Variable    ${response.json()}
    ${books}=    Set Variable    ${resp_body["books"]}

    Should Be True    isinstance($books, list)    books deve ser uma lista
    Should Be True    len($books) > 0    books não deve estar vazio
    Should Not Be Empty    ${books[0]["isbn"]}
    Should Be Equal    ${books[0]["isbn"]}    ${isbn}

Delete Book
    ${headers}    Create Dictionary    Authorization=Bearer ${Token}    Content-Type=application/json
    ${body}    Create Dictionary    isbn=${isbn}    userId=${userId}
    ${response}    DELETE    url=${url}/BookStore/v1/Book    headers=${headers}    json=${body}

    Should Be Equal As Integers    ${response.status_code}    204

    Log To Console    STATUS CODE: ${response.status_code}
    Log To Console    RESPONSE TEXT: ${response.text}
    Log    RESPONSE TEXT: ${response.text}