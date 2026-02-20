*** Settings ***
Library          SeleniumLibrary
Resource         resources/keyword.resource
Resource         resources/variable.resource
Test Teardown    Close All Browsers

*** Test Cases ***
Scenario: Happy Case - All Valid Inputs
    [Documentation]    ตรวจสอบการจองโรงแรมด้วยข้อมูลที่ถูกต้องทั้งหมด (Positive Case)
    [Tags]    Happy Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Input Notes                Test Note
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
    Choose Pet Option          No
    Input Notes                Test Note
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_FNAME}    invalid

Scenario: Single False - Missing Lastname
    [Documentation]    ตรวจสอบกรณีไม่กรอกนามสกุล (Require Field)
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${EMPTY}       ${MY_PHONE}    ${MY_EMAIL}
    Select Number Of Adults    2
    Choose Pet Option          No
    Input Notes                Test Note
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_LNAME}    invalid

Scenario: Single False - Missing Telephone
    [Documentation]    ตรวจสอบกรณีไม่กรอกเบอร์โทรศัพท์ (Require Field)
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${EMPTY}       ${MY_EMAIL}
    Select Number Of Adults    2
    Choose Pet Option          No
    Input Notes                Test Note
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_TEL}      invalid

Scenario: Single False - Missing Email
    [Documentation]    ตรวจสอบกรณีไม่กรอกอีเมล (Require Field)
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${EMPTY}
    Select Number Of Adults    2
    Choose Pet Option          No
    Input Notes                Test Note
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_MAIL}     invalid

Scenario: Single False - Missing Number Of Adults
    [Documentation]    ตรวจสอบกรณีไม่เลือกจำนวนผู้ใหญ่ (Require Field)
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Choose Pet Option          No
    Input Notes                Test Note
    Accept Terms
    Click Submit
    Check Field Status    id=collection_comp-lt33fcsl1    invalid

Scenario: Single False - Missing Pet Option
    [Tags]    Happy Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Select Number Of Adults    2
    Accept Terms
    Click Submit
    Page Should Not Contain Element    xpath=//*[@id="comp-ltubl4ab"]//*[contains(@class, 'error')]

Scenario: Single False - Missing Accept Terms
    [Documentation]    ตรวจสอบกรณีไม่กดยอมรับเงื่อนไข
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Select Number Of Adults    2
    Click Submit
    Sleep    1s
    Check Field Status    ${XPATH_ACCEPT_TERMS}    invalid

Scenario: Single False - Missing Note
    [Documentation]    ตรวจสอบกรณีไม่กรอก Note
    [Tags]    Happy Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Input Text                 id=input_comp-lt33fct3    ${EMPTY}
    Select Number Of Adults    2
    Accept Terms
    Click Submit
    Check Field Status    id=input_comp-lt33fct3    valid