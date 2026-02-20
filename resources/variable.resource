*** Variables ***
# Configuration
${URL}              https://panaryco.wixsite.com/myhotel
${BROWSER}          Chrome

# Test Data
${MY_FNAME}         Nattarat
${MY_LNAME}         Samartkit
${MY_PHONE}         0812345678
${MY_EMAIL}         kwan@chula.com

# Locators (XPaths)
${XPATH_FNAME}      //*[@id='input_comp-lt33fcq41']
${XPATH_LNAME}      //*[@id='input_comp-lt33fcs1']
${XPATH_TEL}        //*[@id='input_comp-lt33fcsi1']
${XPATH_MAIL}       //*[@id='input_comp-lt33fcsf1']
${XPATH_SUBMIT}     //*[@class='uDW_Qe wixui-button PlZyDq']
${XPATH_LISTBOX}    xpath=//div[@role="listbox"]
${XPATH_ACCEPT_TERMS}     //*[@id="comp-ltubl84u"]/input
${ID_ADULTS_DROP}   id=collection_comp-lt33fcsl1