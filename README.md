# 🍜 Recipe Finder 🍜
This app is built with Flutter that allows users to suggest dishes based on ingredients. Users can discover various recipes, view ingredients, and their favorite dishes.

## Screenshots
|                                            Ingredient                                         |                                            Search                                             |                                           Dishes                                             |                                         Recipe Details                                        |
| :-------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: |
| <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/1.png" width="185"/> | <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/2.png" width="185"/> | <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/3.png" width="185"/> | <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/4.png" width="185"/> |

## Features
- **Search by Ingredients**: Enter the ingredients you have, and the app will find matching dishes/recipes.
- **View Recipes/Dishes**: Browse through a wide variety of recipes with details like title, image, and ingredients.

## The API

This application uses third party API(sponncular API) inorder to suggest the possible recipes and ingredients. To use the sponncular API you need an account on their website: ``https://spoonacular.com`` use the free one. Find your Application Key and change the already existing ones in the project with your new ones.

## Installation
To run Recipe Finder app:
```shell
git clone https://github.com/nixtomalon/recipe-finder.git
flutter clean
flutter pub get
dart run build_runner build
flutter run
```

## Usage
- Upon launching the app, enter ingredients name in the search bar.<br>
- Tap the search button to find ingredients.
- Select a recipe to view its details.

## Project Structure

### Architecture

This app follows the principles of ``Clean Architecture`` ([Example repository from mahdinazmi](https://github.com/mahdinazmi/Flutter-News-App-Clean-Architecture/tree/main)). The codebase is organized into distinct layers, promoting separation of concerns and maintainability.

### State Management

This app uses the ``BloC (Business Logic Component)`` pattern for state management. BloC helps to organize and manage the flow of data in a reactive and scalable way.

### Unit Testing

The codebase is thoroughly tested using ``mockito``. To ensure the reliability and correctness of the application's functionalities. To run the tests, follow the instructions in the [Testing Section](https://docs.flutter.dev/cookbook/testing/unit/mocking) below
