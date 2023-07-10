*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    BuiltIn
Library    Collections
Library    String

*** Variables ***
${name}    Iryna Kuzmich
${age}    18
@{favorite_berries}    Strawberry    Cherry    Blueberry   Raspberry
&{person}    name=Iryna    age=18    city=Minsk
@{favorite_cities}     Tokyo     Osaka    Kyoto     Beijing     Hong Kong

*** Test Cases ***

Test Favorite Berries
  [Documentation]
  [Tags]    one    berries
  ...  Homework
  log    ${name}
  FOR     ${favorite_berry}     IN      @{favorite_berries}
      log        ${favorite_berry}
      Log To Console    ${favorite_berry}
  END


Test Favorite Cities
  [Documentation]
  [Tags]    two   cities
  ...  Homework
  log    ${name}
  FOR     ${favorite_city}     IN      @{favorite_cities}
      log        ${favorite_city}
      Log To Console    ${favorite_city}
  END