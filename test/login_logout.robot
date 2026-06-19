*** Settings ***
Resource       ../keywords/keywords.resource
Resource      ../keywords/variables.resource
Library        SeleniumLibrary
#doit etre executé avant une seule fois pour tout les tests
Suite Setup      Ouvrir Le Navigateur
#doit etre executé une seule fois pour tout les tests
Suite Teardown   Fermer Le Navigateur
#doit etre executé aprés chaque test
Test Teardown    Capture Si Echec

*** Test Cases ***

TC01 - Login Valide
    [Documentation]    Login avec standard_user → page Products visible
    [Tags]             smoke    login    positif
    Se Connecter       ${VALID_USER}    ${VALID_PASS}
    La Page Produits Doit Etre Visible

TC02 - User Bloque
    [Documentation]    Login avec locked_out_user → message d'erreur
    [Tags]             login    negatif
    Se Connecter       ${LOCKED_USER}    ${VALID_PASS}
    Une Erreur Doit Etre Visible

 TC03 - Mot De Passe Vide
      [Documentation]    Soumettre sans mot de passe → message d'erreur
      [Tags]             login    negatif
      Se Connecter       ${VALID_USER}    ${EMPTY}
      Une Erreur Doit Etre Visible

