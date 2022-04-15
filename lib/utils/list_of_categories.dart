enum Categories {
  all,
  business,
  entertainment,
  environment,
  food,
  health,
  politics,
  science,
}

extension CategoriesExtension on Categories {
  String get category {
    switch (this) {
      case Categories.all:
        return 'All';
      case Categories.business:
        return 'Business';
      case Categories.entertainment:
        return 'Entertainment';
      case Categories.environment:
        return 'Environment';
      case Categories.food:
        return 'Food';
      case Categories.health:
        return 'Health';
      case Categories.politics:
        return 'Politics';
      case Categories.science:
        return 'Science';
    }
  }
}
