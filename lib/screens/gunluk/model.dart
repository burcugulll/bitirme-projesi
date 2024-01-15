class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;

  RecipeModel({
    this.applabel = "LABEL",
    this.appcalories = 0.000,
    this.appimgUrl = "IMAGE",
    this.appurl = "URL",
  });

  factory RecipeModel.fromMap(Map? recipe) {
    return RecipeModel(
      applabel: recipe?["label"] ?? "LABEL",
      appcalories: recipe?["calories"]?.toDouble() ?? 0.000,
      appimgUrl: recipe?["image"] ?? "IMAGE",
      appurl: recipe?["url"] ?? "URL",
    );
  }
}

class FBRecipeModel {
  late String email;
  late String name;
  late double calories;
  late String imageUrl;
  late String url;

  FBRecipeModel({
    this.email = "EMAIL",
    this.name = "LABEL",
    this.calories = 0.000,
    this.imageUrl = "IMAGE",
    this.url = "URL",
  });

  factory FBRecipeModel.fromMap(Map? data) {
    return FBRecipeModel(
      email: data?["email"] ?? "EMAIL",
      name: data?["name"] ?? "LABEL",
      calories: data?["calories"]?.toDouble() ?? 0.000,
      imageUrl: data?["imageUrl"] ?? "IMAGE",
      url: data?["url"] ?? "URL",
    );
  }
}
