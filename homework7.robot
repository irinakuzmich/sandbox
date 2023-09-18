*** Settings ***
Library    BuiltIn
Library    Collections
Library    String
Library    SeleniumLibrary

#в тесте реализовать:
#1-открыть браузер
#2-перейти на страницу IMDB
#3-в поле поиска поочередно ввести названия своих любимых сериалов или фильмов(не менее 10 штук)
#4-составить словарь используя в качестве ключа название сериала или фильма, а в качестве значения - его рейтинг
#TODO - NOT FINISHED
#5-вывести в консоль получившиеся пары по убываю рейтинга

*** Variables ***
${IMDB_URL}       https://www.imdb.com

*** Test Cases ***
Search for Top 10 Movies on IMDb
    @{movies} =    Create List
    ...    The Lord of the Rings: The Fellowship of the Ring
    ...    The Shawshank Redemption
    ...    The Godfather
    ...    Pulp Fiction
    ...    Fight Club
    ...    Forrest Gump
    ...    Schindler's List
    ...    12 Angry Men
    ...    The Dark Knight
    ...    The Godfather Part II

    ${result_movies}=  Collect rating for my 10 Favorite Movies on IMDb    @{movies}
    Log To Console  ${result_movies}


*** Keywords ***
Collect rating for my 10 Favorite Movies on IMDb
    [Arguments]    @{input_list}

    ${result_movies}=  Create Dictionary

    Open Browser    ${IMDB_URL}    browser=chrome
    Maximize Browser Window

    FOR    ${search_term}    IN    @{input_list}
        Click Element  xpath://*[@id="suggestion-search"]
        Input Text    id=suggestion-search    ${search_term}
        Press Keys    id=suggestion-search-button    ENTER
        Wait Until Page Contains    ${search_term}
        Click Link    link=${search_term}
        ${rating} =    Get Text    xpath=//*[@id="__next"]/main/div/section[1]/section/div[3]/section/section/div[2]/div[2]/div/div[1]/a/span/div/div[2]/div[1]/span[1]
        Set To Dictionary  ${result_movies}  ${search_term}  ${rating}
    END

    Close Browser
    [Return]    ${result_movies}