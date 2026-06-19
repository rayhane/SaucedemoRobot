*** Settings ***
Library    SeleniumLibrary
Resource   ../keywords/variables.resource 
*** Variables ***
# ── Locators Login ───────────────────────────────
${USERNAME_FIELD}     id:user-name
${PASSWORD_FIELD}     id:password
${LOGIN_BTN}          id:login-button
${ERROR_MSG}          css:[data-test="error"]

# ── Locators Home ────────────────────────────────
${PRODUCTS_TITLE}     css:.title
${MENU_BTN}           id:react-burger-menu-btn
${LOGOUT_LINK}        id:logout_sidebar_link


# ── Locators Cart ────────────────────────────────
${ADD_BACKPACK_BTN}   id:add-to-cart-sauce-labs-backpack
${CART_ICON}          css:.shopping_cart_link
${CART_ITEM_NAME}     css:.inventory_item_name
${REMOVE_BTN}         id:remove-sauce-labs-backpack

# ── Locators Checkout ────────────────────────────
${CHECKOUT_BTN}       id:checkout
${FIRST_NAME}         id:first-name
${LAST_NAME}          id:last-name
${POSTAL_CODE}        id:postal-code
${CONTINUE_BTN}       id:continue
${FINISH_BTN}         id:finish
${SUCCESS_MSG}        css:.complete-header

*** Keywords ***

# ════════════ SETUP / TEARDOWN ═══════════════════


Ouvrir Le Navigateur

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    Call Method    ${options}    add_argument    --incognito

    Open Browser    ${URL}    ${BROWSER}    options=${options}
   
    Maximize Browser Window
    Set Selenium Implicit Wait    ${TIMEOUT}



Fermer Le Navigateur
    Close All Browsers

Capture Si Echec
    Run Keyword If Test Failed
    ...    Capture Page Screenshot
    ...    ../reports/echec_${TEST NAME}_{index}.png

# ════════════ LOGIN ══════════════════════════════

Se Connecter
    [Arguments]    ${user}    ${password}
    Input Text     ${USERNAME_FIELD}    ${user}
    Input Text     ${PASSWORD_FIELD}    ${password}
    Click Element  ${LOGIN_BTN}

La Page Produits Doit Etre Visible
    Wait Until Element Is Visible    ${PRODUCTS_TITLE}    ${TIMEOUT}
    Element Text Should Be           ${PRODUCTS_TITLE}    Products

Une Erreur Doit Etre Visible
    Wait Until Element Is Visible    ${ERROR_MSG}    ${TIMEOUT}

# ════════════ LOGOUT ═════════════════════════════

Se Deconnecter
    Click Element                    ${MENU_BTN}
    Wait Until Element Is Visible    ${LOGOUT_LINK}    ${TIMEOUT}
    Click Element                    ${LOGOUT_LINK}

La Page Login Doit Etre Visible
    Wait Until Element Is Visible    ${LOGIN_BTN}    ${TIMEOUT}
    Location Should Be               ${URL}/

# ════════════ CART ═══════════════════════════════

Ajouter Au Panier
    [Arguments]    ${add_btn_id}
    Click Element    ${add_btn_id}

Aller Au Panier
    Click Element    ${CART_ICON}
    Wait Until Element Is Visible    ${CART_ITEM_NAME}    ${TIMEOUT}

Le Panier Doit Contenir
    [Arguments]    ${product}
    Element Should Contain    ${CART_ITEM_NAME}    ${product}

Supprimer Du Panier
    Click Element    ${REMOVE_BTN}

Le Panier Doit Etre Vide
    Page Should Not Contain Element    ${CART_ITEM_NAME}

# ════════════ CHECKOUT ═══════════════════════════

Lancer Le Checkout
    Click Element    ${CHECKOUT_BTN}

Remplir Les Informations
    [Arguments]    ${prenom}    ${nom}    ${code_postal}
    Input Text     ${FIRST_NAME}     ${prenom}
    Input Text     ${LAST_NAME}      ${nom}
    Input Text     ${POSTAL_CODE}    ${code_postal}
    Click Element  ${CONTINUE_BTN}

Finaliser La Commande
    Click Element    ${FINISH_BTN}

La Commande Doit Etre Confirmee
    Wait Until Element Is Visible    ${SUCCESS_MSG}    ${TIMEOUT}
    Element Text Should Be           ${SUCCESS_MSG}    Thank you for your order!