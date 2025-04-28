*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      http://localhost:8069/web/login/
${BROWSER}        Chrome

*** Test Cases ***
My login test case
    I want to open odoo login page
    Sleep    5s
    Input my username    louisoporto042@csu.fullerton.edu
    Sleep    5s   
    Input my password    odoo15
    Sleep    5s
    Submit my credentials
    Sleep    5s   
    I should see this page  
    Sleep    5s   
    [Teardown]    Close Browser

Positive test case of om_hospital
    Sleep   1s
Negative test case of om_hospital
    Sleep   1s
test case 4
    Sleep   1s
test case 5
    Sleep   1s

*** Keywords ***
I want to open odoo login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Login | My Website

Input my username
    [Arguments]    ${username}
    Input Text    login    ${username}

Input my password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit my credentials
    Click Element       //*[contains(text(),'Log in')]

I should see this page
    Title Should Be    Odoo - Discuss
