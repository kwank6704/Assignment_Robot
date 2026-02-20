*** Settings ***
Library         SeleniumLibrary
Resource        variable.resource

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

Input Notes
    [Arguments]    ${notes}
    Input Text    //*[@id='input_comp-lt33fct3']    ${notes}

Accept Terms
    Click Element    xpath=//label[contains(., 'I accept terms & conditions')]

Click Submit
    Click Element    ${XPATH_SUBMIT}

Check Field Status
    [Arguments]    ${xpath}    ${expected_state}
    ${status_to_check}=    Set Variable If    '${expected_state}' == 'valid'    false    true
    ${actual_result}=      Get Element Attribute    ${xpath}    aria-invalid
    Should Be Equal    ${actual_result}    ${status_to_check}    msg=Field status mismatch at ${xpath}