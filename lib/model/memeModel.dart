class MemeModel {
  String? postLink;
  String? subreddit;
  String? title;
  String? url;
  bool? nsfw;
  bool? spoiler;
  String? author;
  int? ups;
  //List<String>? preview;

  MemeModel({
        this.postLink,
        this.subreddit,
        this.title,
        this.url,
        this.nsfw,
        this.spoiler,
        this.author,
        this.ups,
       // this.preview
  });

  MemeModel.fromJson(Map<String, dynamic> json) {
    postLink = json['postLink'];
    subreddit = json['subreddit'];
    title = json['title'];
    url = json['url'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    author = json['author'];
    ups = json['ups'];
    //preview = json['preview'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postLink'] = this.postLink;
    data['subreddit'] = this.subreddit;
    data['title'] = this.title;
    data['url'] = this.url;
    data['nsfw'] = this.nsfw;
    data['spoiler'] = this.spoiler;
    data['author'] = this.author;
    data['ups'] = this.ups;
    //data['preview'] = this.preview;
    return data;
  }
}