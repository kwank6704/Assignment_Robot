*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Test Teardown   Close All Browsers

*** Variables ***
${URL}              https://panaryco.wixsite.com/myhotel
${BROWSER}          Chrome

${MY_FNAME}         Nattarat
${MY_LNAME}         Samartkit
${MY_PHONE}         0812345678
${MY_EMAIL}         kwan@chula.com

${XPATH_FNAME}      //*[@id='input_comp-lt33fcq41']
${XPATH_LNAME}      //*[@id='input_comp-lt33fcs1']
${XPATH_TEL}        //*[@id='input_comp-lt33fcsi1']
${XPATH_MAIL}       //*[@id='input_comp-lt33fcsf1']
${XPATH_SUBMIT}     //*[@class='uDW_Qe wixui-button PlZyDq']

*** Test Cases ***
Scenario: Happy Case - All Valid Inputs
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
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${EMPTY}       ${MY_LNAME}    ${MY_PHONE}    ${MY_EMAIL}
    Select Number Of Adults    2
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_FNAME}    invalid
    Check Field Status    ${XPATH_LNAME}    valid

Scenario: Single False - Missing Email
    [Tags]    Bad Case
    Open Booking Page
    Input Guest Information    ${MY_FNAME}    ${MY_LNAME}    ${MY_PHONE}    ${EMPTY}
    Select Number Of Adults    2
    Accept Terms
    Click Submit
    Check Field Status    ${XPATH_MAIL}     invalid
    Check Field Status    ${XPATH_FNAME}    valid

*** Keywords ***
Open Booking Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3s
    Scroll Element Into View    ${XPATH_SUBMIT}
    Wait Until Element Is Visible    ${XPATH_FNAME}    timeout=30s

Input Guest Information
    [Arguments]    ${f}    ${l}    ${p}    ${e}
    Input Text    ${XPATH_FNAME}    ${f}
    Input Text    ${XPATH_LNAME}    ${l}
    Input Text    ${XPATH_TEL}      ${p}
    Input Text    ${XPATH_MAIL}     ${e}

Select Number Of Adults
    [Arguments]    ${amount}
    Scroll Element Into View         id=collection_comp-lt33fcsl1
    Click Element                    id=collection_comp-lt33fcsl1
    Wait Until Element Is Visible    xpath=//div[@role="listbox"]    timeout=10s
    Sleep    1s
    Click Element                    xpath=//div[@class="P6sHUt" and text()="${amount}"]

Choose Pet Option
    [Arguments]    ${option}
    Click Element    xpath=//label[contains(.,'${option}')]

Accept Terms
    Click Element    xpath=//label[contains(., 'I accept terms & conditions')]

Click Submit
    Click Element    ${XPATH_SUBMIT}

Check Field Status
    [Arguments]    ${xpath}    ${expected_state}
    ${status_to_check}=    Set Variable If    '${expected_state}' == 'valid'    false    true
    ${actual_result}=      Get Element Attribute    ${xpath}    aria-invalid
    Should Be Equal    ${actual_result}    ${status_to_check}    msg=Field status mismatch at ${xpath}