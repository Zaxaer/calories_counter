# Пет проект -  Калькулятор калорий

Это приложение позволяет Вам контролировать потребление суточную норму потребления калорий.
<img src="assets/github_image/add_food_screen.png?raw=true" height="100" alt="Bloc" />
![alt text](https://github.com/Zaxaer/calories_counter/tree/main/assets/github_image/diary_screen.png)
![alt text](https://github.com/Zaxaer/calories_counter/tree/main/assets/github_image/statistic_screen.png)

## Архитертура проекта

Пет проект выполнен на архитектуре Bloc. Для небольшого проекта на пару экранов мне это было более чем достаточно. С заделом на будующие обновления и расширения функционала.

![alt text](https://github.com/Zaxaer/calories_counter/tree/main/assets/github_image/bloc_structura.png)
![alt text](https://github.com/Zaxaer/calories_counter/tree/main/assets/github_image/arch_bloc.png)

## DI

В проекте реализован DI. Он позволит нам, в случае необходимости поменять метод хранения данных, сделать это быстро и без переписывания большого колличества кода. Сам DI внедрен в фабрике экранов screen_factory.

![alt text](https://github.com/Zaxaer/calories_counter/tree/main/assets/github_image/di_in_bloc.png)
![alt text](https://github.com/Zaxaer/calories_counter/tree/main/assets/github_image/di_in_screen_factory.png)

## Хранение данных

 Для хранения данных был использован Hive. Он быстрый и позволяет хранить объекты что очень удобно. Из минусов можно выделить то что отсутствуют миграции что усложнит внедрение изменений в хранения данных