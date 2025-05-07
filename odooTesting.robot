*** Settings ***
Documentation     om_hospital testing using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      http://localhost:8069/web/login/
${HOSPITAL URL}   http://localhost:8069/web#cids=1&action=405
${DOCTOR URL}     http://localhost:8069/web#cids=1&action=407
${APPOINTMENT URL}  http://localhost:8069/web#cids=&action=409
${BROWSER}        Chrome

*** Test Cases ***
My login test case
    I want to login into odoo
    I should see this page  
    Sleep  1s   
    [Teardown]    Close Browser

Create patient and check inforamtion
    I want to login into odoo
    I want to open om_hospital page
    I want to create test patient
    [Teardown]    Close Browser

Remove doctors and check availability
    I want to login into odoo
    I want to open om_hospital page
    Run Keyword And Expect Error  *  Title Should Be  Odoo - Discuss
    [Teardown]    Close Browser

Create appointment and check patient record
    I want to login into odoo
    I want to open om_hospital page
    [Teardown]    Close Browser

Remove patient record and check if they exist
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

I want to create test patient
    Click Element  //*[contains(text(), 'Create')]
    Sleep  1s
    Input Text  //*[contains(text(), 'Name')]/parent::td/parent::tr/td[2]/input  John Doe
    Sleep  1s
    Input Text  //*[contains(text(), 'Responsible')]/parent::td/parent::tr/td[2]/div/div[1]/div/input  Administrator
    Sleep  1s
    Input Text  //*[contains(text(), 'Description')]/parent::td/parent::tr/td[2]/textarea[1]  New Patient Created and should match
    Sleep  1s
    Input Text  //*[contains(text(), 'Age')]/parent::td/parent::tr/td[2]/input  54
    Sleep  1s
    Click Element  //*[contains(text(), 'Save')]
    Sleep  3s