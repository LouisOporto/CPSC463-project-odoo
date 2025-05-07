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
    [Teardown]  Close Browser

Create patient and check inforamtion
    I want to login into odoo
    I want to open om_hospital page
    I want to create patient  John Doe
    [Teardown]  Close Browser

Create appointment and check patient record
    I want to login into odoo
    I want to create doctor  Main Doctor
    I want to create appointment  John Doe  Main Doctor
    [Teardown]  Close Browser

Remove patient and catch error 
    I want to login into odoo
    I want to open om_hospital page
    I want to remove patient  John Doe
    Page Should Contain Element  //*[contains(text(), 'Validation Error')]
    [Teardown]  Close Browser

Remove doctors and check availability
    I want to login into odoo
    I want to open om_hospital page
    I want to remove appointment  John Doe
    Go To  ${DOCTOR URL}
    Sleep  2s
    Page Should Contain Element  //*[contains(text(), 'Main Doctor')]
    Sleep  1s
    I want to remove doctor  Main Doctor
    Run Keyword And Expect Error  *  //*[contains(text(), 'Main Doctor')]
    Go To  ${HOSPITAL URL}
    Sleep  2s
    Page Should Contain Element  //*[contains(text(), 'John Doe')]
    I want to remove patient  John Doe
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

Text Should Match
    [Arguments]  ${match_text}
    Page Should Contain Element  //*[contains(text(), '${match_text}')]
    Sleep  1s

I want to create patient
    [Arguments]  ${name}
    Click Element  //*[contains(text(), 'Create')]
    Sleep  1s
    Input Text  //*[contains(text(), 'Name')]/parent::td/parent::tr/td[2]/input  ${name}
    Sleep  1s
    Input Text  //*[contains(text(), 'Responsible')]/parent::td/parent::tr/td[2]/div/div[1]/div/input  Administrator
    Sleep  1s
    Input Text  //*[contains(text(), 'Description')]/parent::td/parent::tr/td[2]/textarea[1]  New Patient Created and should match
    Sleep  1s
    Input Text  //*[contains(text(), 'Age')]/parent::td/parent::tr/td[2]/input  54
    Sleep  1s
    Click Element  //*[contains(text(), 'Save')]
    Sleep  1s
    Go To  ${DOCTOR URL}
    Sleep  2s
    Go To  ${HOSPITAL URL}
    Sleep  2s
    Click Element  //*[contains(text(), '${name}')]
    Sleep  1s
    Text Should Match  ${name}
    Text Should Match  Male
    Text Should Match  54
    Text Should Match  New Patient Created and should match
    Sleep  3s

I want to remove patient
    [Arguments]  ${name}
    Click Element  //*[contains(text(), '${name}')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Action')]
    Sleep  1s
    Mouse Over  //*[contains(text(), 'Delete')]
    Click Element  //*[contains(text(), 'Delete')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Ok')]
    Sleep  3s

I want to create doctor
    [Arguments]  ${doctor_name}
    Go To  ${DOCTOR URL}
    Sleep  2s
    Click Element  //*[contains(text(), 'Create')]
    Sleep  1s
    Input Text  //*[contains(text(), 'Name')]/parent::td/parent::tr/td[2]/input  ${doctor_name}
    Sleep  1s
    Input Text  //*[contains(text(), 'Age')]/parent::td/parent::tr/td[2]/input  32
    Sleep  1s
    Input Text  //*[contains(text(), 'Description')]/parent::td/parent::tr/td[2]/textarea  The only doctor here
    Sleep  1s
    Click Element  //*[contains(text(), 'Save')]
    Sleep  1s
    Go To  ${HOSPITAL URL}
    Sleep  2s
    Go To  ${DOCTOR URL}
    Sleep  2s
    Click Element  //*[contains(text(), '${doctor_name}')]
    Sleep  1s
    Text Should Match  ${doctor_name}
    Text Should Match  Male
    Text Should Match  32
    Text Should Match  The only doctor here
    Sleep  3s

I want to remove doctor
    [Arguments]  ${doctor_name}
    Click Element  //*[contains(text(), '${doctor_name}')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Action')]
    Sleep  1s
    Mouse Over  //*[contains(text(), 'Delete')]
    Click Element  //*[contains(text(), 'Delete')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Ok')]
    Sleep  3s

I want to create appointment
    [Arguments]  ${patient_name}  ${doctor_name}
    Go To  ${HOSPITAL URL}
    Sleep  2s
    Click Element  //*[contains(text(), '${patient_name}')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Appointments') and @class='o_stat_text']
    Sleep  2s
    Click Element  //*[contains(text(), 'Create')]
    Sleep  1s
    Input Text  //*[contains(text(), 'Date')]/parent::td/parent::tr/td[2]/div/input  05/14/2025
    Sleep  1s
    Input Text  //*[contains(text(), 'Doctor')]/parent::td/parent::tr/td[2]/div/div[1]/div/input   ${doctor_name}
    Sleep  1s
    Input Text  //*[contains(text(), 'Check Up Time')]/parent::td/parent::tr/td[2]/div/input  05/14/2025
    Sleep  1s
    Input Text  //*[contains(text(), 'Prescription') and @class='o_form_label']/parent::td/parent::tr/td[2]/textarea  Prescription details here...
    Sleep  1s
    Click Element  //*[contains(text(), 'Medicine')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Add a line')] 
    Sleep  1s 
    Input Text  //*[@class='o_field_char o_field_widget o_quick_editable o_input o_required_modifier' and @name='name']  Medicine for this appointment...
    Sleep  1s
    Click Element  //*[contains(text(), 'Confirm')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Ok')]
    Sleep  1s
    Go To  ${DOCTOR URL}
    Sleep  2s
    Go To  ${HOSPITAL URL}
    Sleep  2s
    Click Element  //*[contains(text(), '${patient_name}')]
    Sleep  1s
    Click Element  //*[contains(text(), '05/14/2025')]
    Sleep  1s
    Text Should Match  54
    Text Should Match  ${doctor_name}
    Text Should Match  Male
    Text Should Match  05/14/2025
    Text Should Match  Confirmed
    Text Should Match  Prescription details here...
    Click Element  //*[contains(text(), 'Medicine')]
    Sleep  1s
    Text Should Match  Medicine for this appointment...
    Click Element  //*[contains(text(), 'Other Info')]
    Sleep  1s
    Text Should Match  New Patient Created and should match
    Sleep  3s

I want to remove appointment
    [Arguments]  ${patient_name}
    Click Element  //*[contains(text(), '${patient_name}')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Appointments') and @class='o_stat_text']
    Sleep  2s
    Click Element  //*[contains(text(), '05/14/2025')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Action')]
    Sleep  1s
    Mouse Over  //*[contains(text(), 'Delete')]
    Click Element  //*[contains(text(), 'Delete')]
    Sleep  1s
    Click Element  //*[contains(text(), 'Ok')]
    Sleep  3s