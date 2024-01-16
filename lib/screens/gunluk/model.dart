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
  List<Choice> choices;
  Usage usage;

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
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      systemFingerprint: json['system_fingerprint'],
      choices:
          List<Choice>.from(json['choices'].map((x) => Choice.fromJson(x))),
      usage: Usage.fromJson(json['usage']),
    );
  }
}

class Choice {
  int index;
  Message message;
  dynamic logprobs;
  String finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      index: json['index'],
      message: Message.fromJson(json['message']),
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'],
    );
  }
}

class Message {
  String role;
  String content;

  Message({
    required this.role,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
    );
  }
}

class Usage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}
