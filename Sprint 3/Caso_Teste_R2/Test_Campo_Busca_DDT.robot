*** Settings ***
Library    SeleniumLibrary          
Test Teardown    Close Browser
Test Template    Campo de Busca Ignora Termo Parcial

*** Variables ***
${url}    https://www.iterasys.com/
${browser}    Chrome       
${timeout}    10000ms                  

*** Test Cases ***
TC001    Test    
TC002    QA
TC003    Pyth
TC004    ${EMPTY}
TC005    2024

*** Keywords ***
Campo de Busca Ignora Termo Parcial
    [Arguments]    ${Termo_Parcial}
    Dado que acesso o site iterasys
    Quando clico no botao Acessar
    Quando preencho o campo identificação do usuario        teste@bol.com.br
    E preencho o campo senha                                Squad@2026
    E clico no botao Acessar
    Entao sou direcionado para a pagina principal
    Quando clico no botao Pagina inicial
    E clico no botao Ver todos os cursos
    Então clico no campo Buscar cursos
    Então preencho o campo de busca e dou enter        ${Termo_Parcial}

*** Keywords ***
Dado que acesso o site iterasys
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window                                            
    Set Browser Implicit Wait    5000ms                               
    Wait Until Element Is Visible    css=a.nav-link.active    ${timeout}
Quando clico no botao Acessar
    Click Element    id=user-menu-toggle
Quando preencho o campo identificação do usuario
    [Arguments]    ${usuario}
    Input Text    name=username    ${usuario}
E preencho o campo senha
    [Arguments]    ${Senha}
    Input Password    id=password    ${Senha}
E clico no botao Acessar
    Click Button    id=loginbtn
Entao sou direcionado para a pagina principal
    Wait Until Element Is Visible    css=h3.welcome-note    ${timeout}        
    Element Text Should Be    css=h3.welcome-note    Olá, Paulo! 👋
Quando clico no botao Pagina inicial
    Click Element    xpath=//a[contains(@class,"nav-link") and normalize-space(.)="Página inicial"]
E clico no botao Ver todos os cursos
    Click Element    css=.btn.btn-primary.mt-2
    Sleep    2s
Então clico no campo Buscar cursos
    Click Element    name=q
Então preencho o campo de busca e dou enter
    [Arguments]    ${Termo_Parcial}
    Input Text   name=q    ${Termo_Parcial}
    Press Keys   name=q    ENTER
    Sleep    3s
