*** Settings ***
Library    SeleniumLibrary              
Test Teardown    Close Browser           

*** Variables ***
${url}    https://www.iterasys.com/
${browser}    Chrome        
${timeout}    10000ms

*** Test Cases ***
Selecionar Curso Formação em Teste de Software - Turma 140
    Dado que acesso o site iterasys
    Quando clico no botao Acessar
    Quando preencho o campo identificação do usuario        teste@bol.com.br
    E preencho o campo senha                                Squad@2026
    E clico no botao Acessar
    Entao sou direcionado para a pagina principal
    Quando clico no botao Pagina inicial
    E clico no botao Ver todos os cursos
    E clico no botao numero 2
    E clico no curso Formação em Teste de Software - Turma 140
    Entao sou direcionado para a pagina do curso
    Quando clico no item Aula 01
    Então devo ser direcionado para a pagina da aula

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
E clico no curso Formação em Teste de Software - Turma 140
    Scroll Element Into View    css=a.view-course-url[href*="id=26"]
    Click Element    css=a.view-course-url[href*="id=26"]
Entao sou direcionado para a pagina do curso
    Wait Until Page Contains    Formação em Teste de Software - Turma 140    ${timeout}
Quando clico no item Aula 01
    Wait Until Element Is Visible    xpath=//li[normalize-space(.)='Aula 01 - Introdução - Parte 1']
    Click Element    xpath=//li[normalize-space(.)='Aula 01 - Introdução - Parte 1']
Então devo ser direcionado para a pagina da aula
    Wait Until Location Contains    lesson    10s


