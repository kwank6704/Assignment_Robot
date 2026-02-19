*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://panaryco.wixsite.com/myhotel
${BROWSER}      Chrome
${fname}        Nattarat
${lname}        Samartkit
${phone}        0812345678
${email}        kwan@chula.com
${amount}       2
${pet_option}   No

*** Test Cases ***
Verify Hotel Booking
    [Documentation]    ทดสอบกรอกฟอร์ม
    Open Booking Page
    Input Guest Information
    Select Number Of Adults    2
    Choose Pet Option          No
    Accept Terms And Submit
    # Close Browser

*** Keywords ***
Open Booking Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3s
    Scroll Element Into View    id=SCROLL_TO_BOTTOM
    Sleep    2s
    Wait Until Element Is Visible    id=input_comp-lt33fcq41    timeout=30s

Input Guest Information
    Input Text    id=input_comp-lt33fcq41    ${fname}
    Input Text    id=input_comp-lt33fcs1     ${lname}
    Input Text    id=input_comp-lt33fcsi1    ${phone}
    Input Text    id=input_comp-lt33fcsf1    ${email}

Select Number Of Adults
    [Arguments]    ${amount}
    Click Element    id=collection_comp-lt33fcsl1
    Wait Until Element Is Visible    xpath=//div[@role="listbox"]    timeout=5s
    Click Element    xpath=//div[@class="P6sHUt" and text()="${amount}"]

Choose Pet Option
    [Arguments]    ${option}
    Click Element    xpath=//label[contains(.,'${option}')]

Accept Terms And Submit
    Click Element    xpath=//label[contains(., 'I accept terms & conditions')]
    # Click Element    id=comp-lt33fcu0