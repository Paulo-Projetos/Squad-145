*** Settings ***
Library    SeleniumLibrary              
Test Teardown    Close Browser           

*** Variables ***
${url}    https://www.iterasys.com/
${browser}    Chrome        
${timeout}    10000ms

*** Test Cases ***
Teste do envio de exercicio - Satisfação do Cliente
    Dado que acesso o site iterasys
    Quando clico no botao Acessar
    Quando preencho o campo identificação do usuario        teste@bol.com.br
    E preencho o campo senha                                Sabbat@18*68
    E clico no botao Acessar
    Entao sou direcionado para a pagina principal
    Quando clico no botao Pagina inicial
    E clico no botao Ver todos os cursos
    E clico no botao numero 2
    E clico no curso Formação em Teste de Software - Turma 142
    Entao sou direcionado para a pagina do curso
    Quando clico no item Lista 01
    Então sou direcionado para a pagina de envio do exercicio
    Quando clico no item comentario
    E Clico no campo comentario
    E preencho o campo comentario
    Entao clico em Adicionar envio

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
E clico no botao numero 2
    Click Element    xpath=//a[contains(@class,"page-link") and normalize-space(.)="2"]
E clico no curso Formação em Teste de Software - Turma 142
    Wait Until Element Is Visible    css=a.view-course-url[href*="id=41"]
    Click Element    css=a.view-course-url[href*="id=41"]
Entao sou direcionado para a pagina do curso
    Wait Until Page Contains    Planejamento e Análise    ${timeout}
Quando clico no item Lista 01
    Scroll Element Into View    xpath=//a[.//span[contains(normalize-space(.),'Lista 01 - Mapas Mentais')]]
    Click Element    xpath=//a[.//span[contains(normalize-space(.),'Lista 01 - Mapas Mentais')]]
Então sou direcionado para a pagina de envio do exercicio
    Wait Until Element Is Visible    css=h1.header-heading    ${timeout}        
    Element Text Should Be    css=h1.header-heading    Lista 01 - Mapas Mentais
Quando clico no item comentario
    Scroll Element Into View    xpath=//span[starts-with(@id,'comment-link-text')]
    Wait Until Element Is Visible    xpath=//span[starts-with(@id,'comment-link-text')]    ${timeout}
    Click Element    xpath=//span[starts-with(@id,'comment-link-text')]
E Clico no campo comentario
    Wait Until Element Is Visible    name=content    ${timeout}
    Scroll Element Into View    name=content
    Click Element    name=content
E preencho o campo comentario
    Wait Until Element Is Enabled    name=content    ${timeout}
    Input Text    name=content    Texto de teste automatizado
Entao clico em Adicionar envio
    Wait Until Element Is Visible    xpath=//button[starts-with(@id,'single_button')]    ${timeout}
    Click Button                    xpath=//button[starts-with(@id,'single_button')]



