# 🍜 Recipe Finder App 🍜
This app is built with Flutter that allows users to suggest dishes based on ingredients. Users can discover various recipes, view ingredients, and their favorite dishes.
<p float="left">
  <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/1.png" width="200" />
  <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/2.png" width="200" />
  <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/3.png" width="200" />
  <img src="https://github.com/nixtomalon/Recipe-Finder/blob/master/assets/screenshots/4.png" width="200" />
</p>

## Features
- Search by Ingredients: Enter the ingredients you have, and the app will find matching dishes/recipes.
- View Recipes/Dishes: Browse through a wide variety of recipes with details like title, image, and ingredients.

## The API

This application uses third party API(sponncular API) inorder to suggest the possible recipes and ingredients. To use the sponncular API you need an account on their website: https://spoonacular.com use the free one. Find your Application Key and change the already existing ones in the project with your new ones.

## Installation
To run Recipe Finder app:
```shell
git clone https://github.com/nixtomalon/Recipe-Finder.git
flutter clean
flutter pub get
dart run build_runner build
flutter run
```

## Usage
- Upon launching the app, enter ingredients name in the search bar.<br>
- Tap the search button to find ingredients.
- Select a recipe to view its details.


- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
