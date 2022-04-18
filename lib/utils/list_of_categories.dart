enum Categories {
  all,
  business,
  entertainment,
  environment,
}

// extension CategoriesExtension on Categories {
//   List<News> get category {
//     switch (this) {
//       case Categories.all:
//         return context.watch<ActiveCategoryBloc>();
//       case Categories.business:
//         return 'Business';
//       case Categories.entertainment:
//         return 'Entertainment';
//       case Categories.environment:
//         return 'Environment';
//       case Categories.food:
//         return 'Food';
//       case Categories.health:
//         return 'Health';
//       case Categories.politics:
//         return 'Politics';
//       case Categories.science:
//         return 'Science';
//     }
//   }
// }
