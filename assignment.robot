*** Settings ***
Library          SeleniumLibrary
Resource         resources/keyword.resource
Resource         resources/variable.resource
Test Teardown    Close All Browsers

*** Test Cases ***
Scenario: Happy Case - All Valid Inputs
    [Documentation]    ตรวจสอบการจองโรงแรมด้วยข้อมูลที่ถูกต้องทั้งหมด
    [Tags]    Happy Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Select Number Of Adults    2
    Choose Pet Option          No
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_FNAME}    valid
    Check Field Status    ${XPATH_LNAME}    valid
    Check Field Status    ${XPATH_TEL}      valid
    Check Field Status    ${XPATH_MAIL}     valid

Scenario: Single False - Missing Firstname
    [Documentation]    ตรวจสอบกรณีไม่กรอกชื่อจริง (Require Field)
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${EMPTY}       ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Select Number Of Adults    2
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_FNAME}    invalid
    Check Field Status    ${XPATH_LNAME}    valid

Scenario: Single False - Missing Email
    [Documentation]    ตรวจสอบกรณีไม่กรอกอีเมล (Require Field)
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${EMPTY}
    Select Number Of Adults    2
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_MAIL}     invalid
    Check Field Status    ${XPATH_FNAME}    valid