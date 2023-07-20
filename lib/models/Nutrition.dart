class Nutrition {
  late double calories,
      carbs,
      fat,
      protein,
      bmr,
      caloriesEaten,
      carbsEaten,
      fatEaten,
      proteinEaten;

  Nutrition(
    String gender,
    int height,
    int weight,
    int age,
    int activity,
    int goal,
  ) {
    if (gender == 'male')
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    else {
      bmr = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
    }
    switch (activity) {
      case 0:
        {
          calories = bmr * 1.725;
        }
        break;
      case 1:
        {
          calories = bmr * 1.55;
        }
        break;
      case 2:
        {
          calories = bmr * 1.375;
        }
        break;
      case 3:
        {
          calories = bmr * 1.2;
        }
        break;
    }
    switch (goal) {
      case 0:
        {
          calories += 500;
        }
        break;
      case 1:
        {
          calories = bmr;
        }
        break;
      case 2:
        {
          calories -= 500;
        }
        break;
    }
    carbs = (0.5 * calories) / 4;
    protein = (0.25 * calories) / 4;
    fat = (0.25 * calories) / 9;
    caloriesEaten = 0;
    carbsEaten = 0;
    fatEaten = 0;
    proteinEaten = 0;
  }

  // ate(Meal meal) {
  //   caloriesEaten += meal.recipe.calories;
  //   carbsEaten += meal.recipe.carbs;
  //   proteinEaten += meal.recipe.protein;
  //   fatEaten += meal.recipe.fat;
  // }
}
