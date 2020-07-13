class Upload {
  String alt;
  String url;
  String fullPath;
  String markdown;

  Upload({this.alt, this.url, this.fullPath, this.markdown});

  Upload.fromJson(Map<String, dynamic> json) {
    alt = json['alt'];
    url = json['url'];
    fullPath = json['full_path'];
    markdown = json['markdown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alt'] = this.alt;
    data['url'] = this.url;
    data['full_path'] = this.fullPath;
    data['markdown'] = this.markdown;
    return data;
  }
}