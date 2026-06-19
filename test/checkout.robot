*** Settings ***
Resource       ../keywords/keywords.resource
Resource     ../keywords/variables.resource
Library        SeleniumLibrary

Suite Setup      Ouvrir Le Navigateur
Suite Teardown   Fermer Le Navigateur
Test Teardown    Capture Si Echec

*** Test Cases ***

TC01 - Checkout Complet
    [Documentation]    Flux complet : login → panier → checkout → confirmation
    [Tags]             smoke    e2e    checkout
    Se Connecter                     ${VALID_USER}    ${VALID_PASS}
    La Page Produits Doit Etre Visible
    Ajouter Au Panier                ${ADD_BACKPACK_BTN}
    Aller Au Panier
    Le Panier Doit Contenir          ${PRODUCT_NAME}
    Lancer Le Checkout
    Remplir Les Informations         Ahmed    Ben Ali    1001
    Finaliser La Commande
    La Commande Doit Etre Confirmee