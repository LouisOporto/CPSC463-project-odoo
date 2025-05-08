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
- Create patient and check information
- Remove patient record and check if they exist
- Remove doctors and check availability
- Create appointment and check patient record

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
