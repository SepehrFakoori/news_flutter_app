class NewsArticle {
  String? id;
  String? name;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsArticle(
    this.id,
    this.name,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );

  factory NewsArticle.fromMapJson(Map<String, dynamic> jsonObject) {
    return NewsArticle(
      jsonObject['source']['id'],
      jsonObject['source']['name'],
      jsonObject['author'],
      jsonObject['title'],
      jsonObject['description'],
      jsonObject['url'],
      jsonObject['urlToImage'],
      jsonObject['publishedAt'],
      jsonObject['content'],
    );
  }
}
