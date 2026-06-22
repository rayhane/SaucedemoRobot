*** Settings ***
Resource       ../keywords/keywords.resource
Resource      ../keywords/variables.resource
Library        SeleniumLibrary
#doit etre executé avant une seule fois pour tout les tests
Suite Setup      Ouvrir Le Navigateur
#doit etre executé une seule fois pour tout les tests
Suite Teardown   Fermer Le Navigateur
#doit etre executé aprés chaque test
Test Setup       Go To    ${URL} 
Test Teardown    Capture Si Echec

*** Test Cases ***
TC04 - Logout
    [Documentation]    Login puis logout → retour page login
    [Tags]             smoke    logout
    Se Connecter                     ${VALID_USER}    ${VALID_PASS}
    La Page Produits Doit Etre Visible
    Se Deconnecter
    La Page Login Doit Etre Visible