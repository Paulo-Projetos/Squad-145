*** Settings ***
Library    SeleniumLibrary               
Test Teardown    Close Browser          

*** Variables ***
${url}    https://demowebshop.tricentis.com/
${browser}    Chrome       
${timeout}    10000ms                  

*** Test Cases ***
Produto adicionado ao carrinho - Tenis           
    Dado que acesso o site demowebshop
    Entao sou direcionado para a pagina principal
    Quando clico no item Apparel & Shoes
    Entao sou direcionado para a pagina de produtos
    Quando clico no produto    Picture of Blue and green Sneaker    11,00
    Então sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de itens no carrinho    1
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
    Element Attribute Value Should Be    id=main-product-img-28    alt    Picture of Blue and green Sneaker
    Element Text Should Be    css=span[itemprop="price"]    11.00
Quando clico em adicionar no carrinho
    Click Button    id=add-to-cart-button-28
Entao visualizo o numero de itens no carrinho
    [Arguments]    ${Itens}
    Set Test Variable    ${Cart_itens}    ${Itens}
    Wait Until Element Contains    css=span.cart-qty    ${Cart_itens}    ${timeout}
    Sleep    4s



