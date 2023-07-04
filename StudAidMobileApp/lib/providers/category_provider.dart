import '../models/category.dart';
import 'base_provider.dart';

class CategoryProvider extends BaseProvider<Category> {
  CategoryProvider() : super("Category");

  @override
  Category fromJson(data) {
    // TODO: implement fromJson

    return Category.fromJson(data);
  }
}
