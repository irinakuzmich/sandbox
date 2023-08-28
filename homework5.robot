*** Settings ***
Library    BuiltIn
Library    Collections
Library    String
Library    SeleniumLibrary

#в тесте реализовать:
#1 - открытие браузера и переход на страницу wikipedia
#2 - найти в wikipedia страницу про азубуку морзе(на русском языке)
#3 - собрать в словарь информацию "буква" = "напев" (А-Я)

*** Variables ***
${URL}  https://ru.wikipedia.org/wiki/%D0%90%D0%B7%D0%B1%D1%83%D0%BA%D0%B0_%D0%9C%D0%BE%D1%80%D0%B7%D0%B5
${BROWSER}  chrome

*** Test Cases ***
Open Browser And Extract Table Data
    Open Browser  ${URL}  ${BROWSER}
    ${morse_code_letters}=  Get Morse Code Letters
    Log  ${morse_code_letters}
    Log To Console  ${morse_code_letters}
    Close Browser

*** Keywords ***
Get Morse Code Letters
    ${morse_code_letters}=  Create Dictionary

    FOR    ${row_index}    IN RANGE    1    33
        ${letter}=  Get WebElement  xpath://*[@id="mw-content-text"]/div[1]/table/tbody/tr[${row_index}]/td[1]
        ${code}=  Get WebElement  xpath://*[@id="mw-content-text"]/div[1]/table/tbody/tr[${row_index}]/td[4]
        ${letter_text}=  Get Text  ${letter}
        ${code_text}=  Get Text  ${code}
        Set To Dictionary  ${morse_code_letters}  ${letter_text}  ${code_text}
    END
    [Return]  ${morse_code_letters}