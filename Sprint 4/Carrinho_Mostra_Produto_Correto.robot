*** Settings ***
Library    SeleniumLibrary               
Test Teardown    Close Browser       

*** Variables ***
${url}    https://demowebshop.tricentis.com/
${browser}    Chrome       
${timeout}    10000ms                  

*** Test Cases ***
Carrinho mostra produto correto - Calsa Jeans
    Dado que acesso o site demowebshop
    Entao sou direcionado para a pagina principal
    Quando clico no item Apparel & Shoes
    Entao sou direcionado para a pagina de produtos
    Quando clico no produto    Picture of Blue Jeans    1,00
    Então sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de itens no carrinho    1
    Quando clico no icone do carrinho
    Entao sou direcionado para a pagina do carrinho
    E confirmo se a descrição do produto no carrinho esta correta
    Quando clico Remover Item
    E clico em Atualizar Carrinho de Compras
    Entao sou direcionado para a pagina Carrinho de Compras

*** Keywords ***
Dado que acesso o site demowebshop
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window                                            
    Set Browser Implicit Wait    5000ms                               
    Wait Until Element Is Visible    css=img[alt="Tricentis Demo Web Shop"]    ${timeout} 
Entao sou direcionado para a pagina principal
    Element Attribute Value Should Be    css=img[alt="Tricentis Demo Web Shop"]    alt    Tricentis Demo Web Shop
Quando clico no item Apparel & Shoes
    Click Element    css=a[href="/apparel-shoes"]
Entao sou direcionado para a pagina de produtos
    Element Text Should Be    css=h1    Apparel & Shoes
Quando clico no produto
    [Arguments]    ${Produto}    ${Price}
    Wait Until Element Is Visible    css=img[alt="${Produto}"]    ${timeout}
    Click Element    css=img[alt="${Produto}"]
Então sou direcionado para a pagina do produto
    Element Attribute Value Should Be    id=main-product-img-36    alt    Picture of Blue Jeans
    Element Text Should Be    css=span[itemprop="price"]    1.00
Quando clico em adicionar no carrinho
    Click Button    id=add-to-cart-button-36
Entao visualizo o numero de itens no carrinho
    [Arguments]    ${Items}
    Set Test Variable    ${Cart_items}    ${Items}
    Wait Until Element Contains    css=span.cart-qty    ${Cart_items}    ${timeout}
Quando clico no icone do carrinho
    Click Element    css=span.cart-label
Entao sou direcionado para a pagina do carrinho
    Wait Until Element Is Visible    css=h1    ${timeout}
    Element Text Should Be    css=h1    Shopping cart
E confirmo se a descrição do produto no carrinho esta correta
    Wait Until Element Is Visible    css=a.product-name    ${timeout}
    Element Text Should Be    css=a.product-name    Blue Jeans
    Element Text Should Be    css=span.product-unit-price    1.00
Quando clico Remover Item
    Click Element    name=removefromcart
E clico em Atualizar Carrinho de Compras
    Click Button    name=updatecart
Entao sou direcionado para a pagina Carrinho de Compras
    Wait Until Element Is Visible    css=h1    ${timeout}
    Element Text Should Be    css=h1    Shopping cart



