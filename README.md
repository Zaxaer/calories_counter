# Пет проект -  Калькулятор калорий

Это приложение позволяет Вам контролировать потребление суточную норму потребления калорий.

<img src="assets/github_image/add_food_screen.png?raw=true" height="300" alt="Bloc" /> <img src="assets/github_image/diary_screen.png?raw=true" height="300" alt="Bloc" /> <img src="assets/github_image/statistic_screen.png?raw=true" height="300" alt="Bloc" />

## Архитертура проекта

Пет проект выполнен на архитектуре Bloc. Для небольшого проекта на пару экранов мне это было более чем достаточно. С заделом на будующие обновления и расширения функционала.
<img src="assets/github_image/arch_bloc.png?raw=true" height="200" alt="Bloc" />

Тут видно что у нас выделено три слоя. Слой UI, слой bloc, и слой data.

<img src="assets/github_image/bloc_structura.png?raw=true" height="200" alt="Bloc" />

## DI

В проекте реализован DI. Он позволит нам, в случае необходимости поменять метод хранения данных, сделать это быстро и без переписывания большого колличества кода. Сам DI внедрен в фабрике экранов screen_factory.

<img src="assets/github_image/di_in_bloc.png?raw=true" height="200" alt="Bloc" />

Вместо StatisticaRepoLocal можно подставить другой репозиторий со своим типом хранения данных и не переписывать логику экрана.

<img src="assets/github_image/di_in_screen_factory.png?raw=true" height="200" alt="Bloc" />

## Хранение данных

 Для хранения данных был использован Hive. Он быстрый и позволяет хранить объекты что очень удобно. Из минусов можно выделить то что отсутствуют миграции что усложнит внедрение изменений в хранения данных