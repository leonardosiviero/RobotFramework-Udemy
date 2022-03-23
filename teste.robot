*** Settings ***
Documentation   Suite de exemplo do robot

*** Variable ***
${MENSAGEM}  Hello World!!

*** Test Cases ***
Cenário de teste 01: Olá Mundo
    Imprimir mensagem no console

*** Keywords ***
Imprimir mensagem no console
  Log To Console    ${MENSAGEM}