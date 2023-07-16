*** Settings ***
Library    BuiltIn
Library    Collections
Library    String
Library    helpers.py

*** Variables ***
@{fruits}    Apple    Banana    Orange
@{ten_fruits}    Apple    Banana    Orange    Guava    Papaya    Lychee    Mango    Blueberry    Lemon    Lime

*** Test Cases ***
Test 1
    [Tags]    test1

    @{additional_fruites}  Create List  Guava    Papaya    Lychee    Mango    Blueberry    Lemon    Lime
    Log To Console   \n Before: ${fruits}
    Log List     ${fruits}   INFO

    FOR    ${i}    IN RANGE    5
        Append To List    ${fruits}    ${additional_fruites}[${i}]
    END

    Log To Console    \n After: ${fruits}
    Log List    ${fruits}   INFO

Test 2
    [Tags]    test2

    ${i}=    Set Variable    ${0}
    ${full_alphabet} =    Set Variable  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    ${new_alphabet} =    Set Variable
    ${stop_letter} =    Set Variable  P
    @{full_alphabet_list} =  Split String  ${full_alphabet}    ,${SPACE}

    WHILE  True   limit=26
        ${current_letter}  Set Variable  ${full_alphabet_list}[${i}]
        IF    $current_letter != $stop_letter
            ${new_alphabet}  Set Variable  ${new_alphabet}${full_alphabet_list}[${i}]
        ELSE
            ${new_alphabet}  Set Variable  ${new_alphabet}${full_alphabet_list}[${i}]
            BREAK
        END

        ${i}=    Evaluate    ${i} + 1
    END

    Log To Console      \n New Alphabet:${new_alphabet}

Test 3
    [Tags]    test3
    ${search_letter} =  Set Variable  E
    @{fruites_with_letter_e}  Create List
    FOR   ${fruit}  IN  @{ten_fruits}
        ${has_letter_e}     helpers.contains    ${fruit}    ${search_letter}
        IF    ${has_letter_e}
              Append To List    ${fruites_with_letter_e}    ${fruit}
        END
    END

    Log To Console      \n Fruites with letter 'E':${fruites_with_letter_e}