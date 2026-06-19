*** Settings ***
Resource       ../keywords/keywords.resource
Resource      ../keywords/variables.resource
Library        SeleniumLibrary

Suite Setup      Ouvrir Le Navigateur
Suite Teardown   Fermer Le Navigateur
Test Teardown    Capture Si Echec

*** Test Cases ***

TC01 - Ajouter Un Produit Au Panier
    [Documentation]    Ajoute le Backpack → vérifie qu'il est dans le panier
    [Tags]             smoke    cart    positif
    Se Connecter                     ${VALID_USER}    ${VALID_PASS}
    La Page Produits Doit Etre Visible
    Ajouter Au Panier                ${ADD_BACKPACK_BTN}
    Aller Au Panier
    Le Panier Doit Contenir          ${PRODUCT_NAME}

TC02 - Supprimer Un Produit Du Panier
    [Documentation]    Ajoute puis supprime → panier vide
    [Tags]             cart    negatif
    Se Connecter                     ${VALID_USER}    ${VALID_PASS}
    La Page Produits Doit Etre Visible
    Ajouter Au Panier                ${ADD_BACKPACK_BTN}
    Aller Au Panier
    Supprimer Du Panier
    Le Panier Doit Etre Vide