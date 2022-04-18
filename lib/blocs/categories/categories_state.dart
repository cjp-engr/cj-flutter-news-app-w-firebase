part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final List<News> allCategories;
  final List<News> businessCategories;
  final List<News> entertainmentCategories;
  final List<News> environmentCategories;
  final List<News> foodCategories;
  final List<News> healthCategories;
  final List<News> politicsCategories;
  final List<News> scienceCategories;
  const CategoriesState({
    required this.allCategories,
    required this.businessCategories,
    required this.entertainmentCategories,
    required this.environmentCategories,
    required this.foodCategories,
    required this.healthCategories,
    required this.politicsCategories,
    required this.scienceCategories,
  });

  factory CategoriesState.initial() {
    return const CategoriesState(
      allCategories: [],
      businessCategories: [],
      entertainmentCategories: [],
      environmentCategories: [],
      foodCategories: [],
      healthCategories: [],
      politicsCategories: [],
      scienceCategories: [],
    );
  }

  @override
  List<Object?> get props => [
        allCategories,
        businessCategories,
        entertainmentCategories,
        environmentCategories,
        foodCategories,
        healthCategories,
        politicsCategories,
        scienceCategories,
      ];

  @override
  String toString() {
    return 'Categories(allCategories: $allCategories, businessCategories: $businessCategories, entertainmentCategories: $entertainmentCategories, environmentCategories: $environmentCategories, foodCategories: $foodCategories, healthCategories: $healthCategories, politicsCategories: $politicsCategories, scienceCategories: $scienceCategories)';
  }

  CategoriesState copyWith({
    List<News>? allCategories,
    List<News>? businessCategories,
    List<News>? entertainmentCategories,
    List<News>? environmentCategories,
    List<News>? foodCategories,
    List<News>? healthCategories,
    List<News>? politicsCategories,
    List<News>? scienceCategories,
  }) {
    return CategoriesState(
      allCategories: allCategories ?? this.allCategories,
      businessCategories: businessCategories ?? this.businessCategories,
      entertainmentCategories:
          entertainmentCategories ?? this.entertainmentCategories,
      environmentCategories:
          environmentCategories ?? this.environmentCategories,
      foodCategories: foodCategories ?? this.foodCategories,
      healthCategories: healthCategories ?? this.healthCategories,
      politicsCategories: politicsCategories ?? this.politicsCategories,
      scienceCategories: scienceCategories ?? this.scienceCategories,
    );
  }
}
