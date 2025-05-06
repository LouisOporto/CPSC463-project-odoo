*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      http://localhost:8069/web/login/
${HOSPITAL URL}   http://localhost:8069/web#cids=1&action=405
${BROWSER}        Chrome

*** Test Cases ***
My login test case
    I want to open odoo login page
    Sleep    1s
    Input my username    louisoporto042@csu.fullerton.edu
    Sleep    1s   
    Input my password    odoo15
    Sleep    1s
    Submit my credentials
    Sleep    3s   
    I should see this page  
    Sleep    1s   
    [Teardown]    Close Browser

Positive test case of om_hospital    
    I want to login into odoo
    I want to open om_hospital page
    [Teardown]    Close Browser

Negative test case of om_hospital
    I want to login into odoo
    I want to open om_hospital page
    Run Keyword And Expect Error  *  Title Should Be  Odoo - Discuss
    [Teardown]    Close Browser

test case 4
    I want to login into odoo
    I want to open om_hospital page
    [Teardown]    Close Browser

test case 5
    I want to login into odoo
    I want to open om_hospital page
    [Teardown]    Close Browser


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

I want to login into odoo
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Login | My Website
    Sleep    1s
    Input my username    louisoporto042@csu.fullerton.edu
    Sleep    1s   
    Input my password    odoo15
    Sleep    1s
    Submit my credentials
    Sleep    3s

I want to open om_hospital page
    Go To    ${HOSPITAL URL}
    Sleep    1s
    Title Should Be    Odoo - Patients
    Sleep    1s