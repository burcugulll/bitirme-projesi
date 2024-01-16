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

class ChatCompletion {
  String id;
  String object;
  int created;
  String model;
  String systemFingerprint;
  List<MyChoice> choices;
  MyUsage usage;

  ChatCompletion({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.systemFingerprint,
    required this.choices,
    required this.usage,
  });

  factory ChatCompletion.fromJson(Map<String, dynamic> json) {
    return ChatCompletion(
      id: json['id'] ?? "",
      object: json['object'] ?? "",
      created: json['created'] ?? 0,
      model: json['model'] ?? "",
      systemFingerprint: json['system_fingerprint'] ?? "",
      choices: List<MyChoice>.from(
          (json['choices'] ?? []).map((x) => MyChoice.fromJson(x))),
      usage: MyUsage.fromJson(json['usage'] ?? Map<String, dynamic>()),
    );
  }
}

class MyChoice {
  int index;
  MyMessage message;
  dynamic logprobs;
  String finishReason;

  MyChoice({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  factory MyChoice.fromJson(Map<String, dynamic> json) {
    return MyChoice(
      index: json['index'] ?? 0,
      message: MyMessage.fromJson(json['message'] ?? Map<String, dynamic>()),
      logprobs: json['logprobs'] ?? null,
      finishReason: json['finish_reason'] ?? "",
    );
  }
}

class MyMessage {
  String role;
  String content;

  MyMessage({
    required this.role,
    required this.content,
  });

  factory MyMessage.fromJson(Map<String, dynamic> json) {
    return MyMessage(
      role: json['role'] ?? "",
      content: json['content'] ?? "",
    );
  }
}

class MyUsage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  MyUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory MyUsage.fromJson(Map<String, dynamic> json) {
    return MyUsage(
      promptTokens: json['prompt_tokens'] ?? 0,
      completionTokens: json['completion_tokens'] ?? 0,
      totalTokens: json['total_tokens'] ?? 0,
    );
  }
}
