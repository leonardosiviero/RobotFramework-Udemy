*** Settings ***

Library    SeleniumLibrary

*** Variables ***

${URL}                    https://www.amazon.com.br/
${MENU_ELETRONICOS}       //a[@data-csa-c-slot-id='nav_cs_8']
${HEADER_ELETRONICOS}     //h1[contains(.,'Eletrônicos e Tecnologia')]
${CATEGORA_COMPUT_INFO}   //img[@src='https://images-na.ssl-images-amazon.com/images/G/32/BR-hq/2021/img/Consumer_Electronics/Storefronts/Electronics/956.Storefront_categoria_computadores_icons_240x270.jpg']

*** Keywords ***
Abrir o navegador    

    Open Browser  browser=chrome
    Maximize Browser Window
    
Fechar o navegador 

    Capture Page Screenshot
    Close Browser

Acessar a home page do site amazon.com.br

    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"

    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"

    Wait Until Page Contains         text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}  

Verificar se o título da página fica "${TITULO}" 

    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME CATEGORIA}"

    Element Should Be Visible    locator=${CATEGORA_COMPUT_INFO}

Digitar o nome de produto "${BUSCA_PRODUTO}" no campo de pesquisa

    Input Text    locator=twotabsearchtextbox    text=${BUSCA_PRODUTO}

Clicar no botão de pesquisa 

    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa, listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]

Adicionar o produto "Console Xbox Series S" no carrinho
    ### Clicar no produto desejado
    Click Element    locator=(//span[contains(.,'Console Xbox Series S')])[2]
    ### Adicionar produto ao carrinho
    Wait Until Element Is Visible    locator=//input[contains(@name,'submit.add-to-cart')]
    Click Element    locator=//input[contains(@name,'submit.add-to-cart')]
    ### Negar o seguro para garantia extendida do produto
    Wait Until Element Is Visible    locator=//input[contains(@aria-labelledby,'attachSiNoCoverage-announce')]
    Click Element    locator=//input[contains(@aria-labelledby,'attachSiNoCoverage-announce')]

Verificar se o produto "${CAR_COMPRAS_PRODUTO}" foi adicionado com sucesso
    ### Ir para o carrinho de compras
    Click Element    locator=//span[@aria-hidden='true'][contains(.,'Carrinho')]
    ### Verificar se o produto consta no carrinho de compras
    Page Should Contain    text=Carrinho de compras
    Page Should Contain    text=Console Xbox Series S
    
Remover o produto "Console Xbox Series S" do carrinho
    ### Remover produto do carrinho+
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=//a[contains(@aria-label,'1 item no carrinho')]
    Click Element    locator=//a[contains(@aria-label,'1 item no carrinho')]
    Click Element    locator=a-autoid-0
    Click Element    locator=quantity_0

Verificar se o carrinho fica vazio
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=nav-cart
    Click Element    locator=nav-cart
    Page Should Contain    text=Seu carrinho da Amazon está vazio

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site amazon.com.br
Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"
Então o texto "${FRASE}" deve ser exibido na página
    Verificar se aparece a frase "${FRASE}"
E o título da página deve ficar "${TITULO}"
    Verificar se o título da página fica "${TITULO}" 
E a categoria ${NOME CATEGORIA}" deve ser exibida na página
    Verificar se aparece a categoria "${NOME CATEGORIA}"
Quando pesquisar pelo produto "${BUSCA_PRODUTO}"
    Digitar o nome de produto "${BUSCA_PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa 
Então o título da página deve ficar "${TITULO2}"
    Title Should Be    title=${TITULO2}
E um produto da linha "${PRODUTO}" deve ser mostrado na página
    Verificar o resultado da pesquisa, listando o produto "${PRODUTO}"
Quando adicionar o produto "Console Xbox Series S" no carrinho
    #Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=Xbox Series S
    #Clicar no botão de pesquisa 
    Click Element    locator=nav-search-submit-button
    #Verificar o resultado da pesquisa, listando o produto "Console Xbox Series S"
    Wait Until Element Is Visible    locator=(//span[contains(.,'Console Xbox Series S')])[2]
    ### Clicar no produto desejado
    Click Element    locator=(//span[contains(.,'Console Xbox Series S')])[2]
    ### Adicionar produto ao carrinho
    Wait Until Element Is Visible    locator=//input[contains(@name,'submit.add-to-cart')]
    Click Element    locator=//input[contains(@name,'submit.add-to-cart')]
    ### Negar o seguro para garantia extendida do produto
    Wait Until Element Is Visible    locator=//input[contains(@aria-labelledby,'attachSiNoCoverage-announce')]
    Click Element    locator=//input[contains(@aria-labelledby,'attachSiNoCoverage-announce')]

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    ### Ir para o carrinho de compras
    Click Element    locator=//span[@aria-hidden='true'][contains(.,'Carrinho')]
    ### Verificar se o produto consta no carrinho de compras
    Page Should Contain    text=Carrinho de compras
    Page Should Contain    text=Console Xbox Series S

E existe o produto "Console Xbox Series S" no carrinho
    Quando adicionar o produto "Console Xbox Series S" no carrinho
    Então o produto "Console Xbox Series S" deve ser mostrado no carrinho


Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio