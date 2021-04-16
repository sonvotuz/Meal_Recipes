import 'package:flutter/material.dart';
import 'package:meal_recipes/dummy_data.dart';
import 'package:meal_recipes/models/meal.dart';
import 'package:meal_recipes/screens/categories_screen.dart';
import 'package:meal_recipes/screens/category_meals_screen.dart';
import 'package:meal_recipes/screens/filter_screen.dart';
import 'package:meal_recipes/screens/meal_detail_screen.dart';
import 'package:meal_recipes/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Recipes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
