*** Settings ***
Library    BuiltIn
Library    Collections
Library    String

*** Keywords ***
Log Result
    [Arguments]    ${LOG_RESULT}    ${LOG_TEXT_PREFIX}='Result:'
    Log To Console    ${LOG_TEXT_PREFIX}: ${LOG_RESULT}