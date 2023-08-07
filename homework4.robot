*** Settings ***
Library    BuiltIn
Library    Collections
Library    String
Resource    GlobalKeywords.robot

#1 - написать тест в котором будет создаваться список(новый) в который будут добавленны только зеленые фрукты из
#       переменной ${fruits}(подумать над типом переменной а так же создать эту переменную перед тестом)
#2 - сделать задание 1 через циклы FOR и WHILE

*** Variables ***
@{GREEN_FRUITES}    Limes    Avocado    Soursop    Pear    Kiwi
@{RED_FRUITES}    Beetroot    Plum    Cranberry
&{FRUIT_CATEGORIES}   red=@{RED_FRUITES}    green=@{GREEN_FRUITES}

*** Keywords ***
Create a list with green fruites using for loop
    [Arguments]    ${CURRENT_FRUIT_COLOR}=green
    @{RESULT_FRUITES}    Create List
    FOR    ${fruit_category_key}    IN    @{FRUIT_CATEGORIES}
        IF    '${fruit_category_key}' == '${CURRENT_FRUIT_COLOR}'
             Append To List  ${RESULT_FRUITES}  ${FRUIT_CATEGORIES}[${fruit_category_key}]
             Log Result  ${RESULT_FRUITES}  'Test #1 Result'
        END
    END

Create a list with green fruites using while loop
    [Arguments]    ${CURRENT_FRUIT_COLOR}=green
    @{RESULT_FRUITES}    Create List
    @{FRUIT_CATEGORIES_KEYS}   Set Variable  @{FRUIT_CATEGORIES.keys()}
    ${FRUIT_CATEGORY_KEY_INDEX}    Get Index From List  ${FRUIT_CATEGORIES_KEYS}  ${CURRENT_FRUIT_COLOR}
    ${i}    Set Variable    ${0}

    WHILE    True
        IF    '${FRUIT_CATEGORIES_KEYS}[${i}]' == '${CURRENT_FRUIT_COLOR}'
            ${RESULT_FRUITES}   Get From Dictionary  ${FRUIT_CATEGORIES}  ${FRUIT_CATEGORIES_KEYS}[${i}]
            BREAK
        END

        ${i}=    Evaluate    ${i} + 1
    END

    Log Result  ${RESULT_FRUITES}  'Test #2 Result'

*** Test Cases ***
Test 1
    Create a list with green fruites using for loop

Test 2
    Create a list with green fruites using while loop