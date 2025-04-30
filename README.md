# CPSC 463 Project
## GIT REPO
Initiated inside the custom addons folder of odoo15.

# Python Unit Testing 
## Current Test Cases
- test_compute_appointment_count
- test_get_name
- test_patient_actions
- test_onchange_id
- test_unlink

Run ```./odoo-bin --test-tags /om_hospital```

# Selenium Testing
## Current Test Cases
- My login test case
- Positive test case of om_hospital
- Negative tes case of om_hospital
- test case 4
- test case 5

## Requirements
Selenium testing via robot framework

Required python packages:
- selenium
- robotframework
- robotframework-seleniumlibrary

Run ```robot odooTesting.robot``` to run selenium browser testing

## Contents
> /om_hospital
> > /tests
> > 
> > test_hospital.py
>
> odooTesting.robot
