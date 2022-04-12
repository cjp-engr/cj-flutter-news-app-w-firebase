enum ListOfCategories {
  business,
  entertainment,
  environment,
  food,
  health,
  politics,
  science,
}

extension ListOfCategoriesExtension on ListOfCategories {
  String get category {
    switch (this) {
      case ListOfCategories.business:
        return 'Business';
      case ListOfCategories.entertainment:
        return 'Entertainment';
      case ListOfCategories.environment:
        return 'Environment';
      case ListOfCategories.food:
        return 'Food';
      case ListOfCategories.health:
        return 'Health';
      case ListOfCategories.politics:
        return 'Politics';
      case ListOfCategories.science:
        return 'Science';
    }
  }
}
