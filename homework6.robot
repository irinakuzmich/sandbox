*** Settings ***
Library    BuiltIn
Library    Collections
Library    String
Library    SeleniumLibrary

#в тесте реализовать:
#1-открыть браузер
#2-перейти на страницу Онлайнера
#3-в любом разделе выбрать двух производителей
#4-составить два словаря(по одному для каждого выбранного производителя) с наименованиями продуктов в виде ключей и с соответствующими ценами в виде значений, для первых 10 позиций
#5-сравнить соответвующие значения из обоих словарей
#6-вывести в лог или в консоль запись о том какой из списков дешевле

*** Variables ***
${URL}  https://catalog.onliner.by/mobile?mfr%5B0%5D=apple&mfr%5B1%5D=xiaomi&mobile_type%5B0%5D=smartphone&mobile_type%5Boperation%5D=union&segment=second
${BROWSER}  chrome
${PRODUCT_APPLE}  Apple
${PRODUCT_XIAOMI}  Xiaomi

*** Test Cases ***
Open browser and compare prices of the Apple and Xiaomi products
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window

    ${result_apple_offers}=  Find Product  Apple  xpath://*[@id="schema-second-offers"]/div[@class='schema-product__group']
    Log To Console    ${result_apple_offers}

    ${result_xiaomi_offers}=  Find Product  Xiaomi  xpath://*[@id="schema-second-offers"]/div[@class='schema-product__group']
    Log To Console    ${result_xiaomi_offers}

    ${lowest_prices_dict}=  Find dictionary with lowest total prices  ${result_apple_offers}  ${result_xiaomi_offers}
    Log To Console    Lowest Prices: ${lowest_prices_dict}

    Close Browser

    [Teardown]  Close Browser

*** Keywords ***
Find Product
    [Arguments]  ${product_name}  ${product_table_xpath}
    ${product_page_count}=  Get Element Count  ${product_table_xpath}
    Log To Console    Result: ${product_page_count}

    ${result_product_offers}=  Create Dictionary

    ${allowed_chars}=  Set Variable  0123456789,
    ${i}    Set Variable    ${1}
    FOR    ${row_index}    IN RANGE    1    ${product_page_count}
        IF    ${i} == 11
            BREAK
        END

        ${title}=  Get WebElement  xpath://*[@id="schema-second-offers"]/div[@class='schema-product__group'][${row_index}]/div/div[2]/div[2]/div[1]/a/span
        ${price}=  Get WebElement  xpath://*[@id="schema-second-offers"]/div[@class='schema-product__group'][${row_index}]/div/div[2]/div[1]/div[2]/div[1]/div/a/strong
        ${title_text}=  Get Text  ${title}
        ${price_text}=  Get Text  ${price}

        ${result}=    Run Keyword And Return Status    Should Contain    ${title_text}    ${product_name}

        IF    ${result} == True
            ${price}=  Evaluate  ''.join(char for char in '${price_text}' if char in '${allowed_chars}')
            Set To Dictionary  ${result_product_offers}  ${title_text}  ${price}
            ${i}=    Evaluate    ${i} + 1
        END
    END

    [Return]  ${result_product_offers}

Find dictionary with lowest total prices
    [Arguments]  ${dict1}  ${dict2}
    ${dict1_values}=  Get Dictionary Values  ${dict1}
    ${dict2_values}=  Get Dictionary Values  ${dict2}

    ${total_price1}=  Evaluate  sum(float(dict1_value.replace(',', '.')) for dict1_value in @{dict1_values})
    ${total_price2}=  Evaluate  sum(float(dict2_value.replace(',', '.')) for dict2_value in @{dict2_values})

    ${result}=  Set Variable If  ${total_price1} <= ${total_price2}  ${dict1}  ${dict2}
    [Return]  ${result}