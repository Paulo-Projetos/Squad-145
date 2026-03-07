*** Settings ***
Library    SeleniumLibrary               
Test Teardown    Close Browser          

*** Variables ***
${url}    https://demowebshop.tricentis.com/
${browser}    Chrome       
${timeout}    10000ms                  

*** Test Cases ***
Usuario nao consegue realizar login
    Dado que acesso o site demowebshop
    Entao sou direcionado para a pagina principal
    Quando clico no iten Log in
    Entao sou direcionado para a pagina de login
    E preencho o campo Email    rogerteste123@test.com
    E Preencho o campo Password    Vitoria@26
    E clico no botao Acessar em Log in
    Entao sou direcionado para a pagina principal do site
*** Keywords ***
Dado que acesso o site demowebshop
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window                                            
    Set Browser Implicit Wait    5000ms                               
    Wait Until Element Is Visible    css=img[alt="Tricentis Demo Web Shop"]    ${timeout} 
Entao sou direcionado para a pagina principal
    Element Attribute Value Should Be    css=img[alt="Tricentis Demo Web Shop"]    alt    Tricentis Demo Web Shop
Quando clico no iten Log in
    Click Element    css=a.ico-login
Entao sou direcionado para a pagina de login
    Element Text Should Be    xpath=//strong[normalize-space(.)="Returning Customer"]    Returning Customer
E preencho o campo Email
    [Arguments]    ${Email}
    Input Text    id=Email    ${Email}
E Preencho o campo Password
    [Arguments]    ${Senha}
    Input Password    id=Password    ${Senha}
E clico no botao Acessar em Log in
    Click Button    xpath=//input[@value="Log in"]
Entao sou direcionado para a pagina principal do site
    Wait Until Element Is Visible    xpath=//strong    ${timeout}
    Element Should Contain    xpath=//strong    CATEGORIES



