// class ShortsModel {
//   String? message;
//   Data? data;
//
//   ShortsModel({this.message, this.data});
//
//   ShortsModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<Posts>? posts;
//   String? page;
//   String? offset;
//
//   Data({this.posts, this.page, this.offset});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['posts'] != null) {
//       posts = <Posts>[];
//       json['posts'].forEach((v) {
//         posts!.add(new Posts.fromJson(v));
//       });
//     }
//     page = json['page'];
//     offset = json['offset'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.posts != null) {
//       data['posts'] = this.posts!.map((v) => v.toJson()).toList();
//     }
//     data['page'] = this.page;
//     data['offset'] = this.offset;
//     return data;
//   }
// }
//
// class Posts {
//   String? postId;
//   Creator? creator;
//   Comment? comment;
//   Reaction? reaction;
//   Submission? submission;
//
//   Posts(
//       {this.postId,
//         this.creator,
//         this.comment,
//         this.reaction,
//         this.submission});
//
//   Posts.fromJson(Map<String, dynamic> json) {
//     postId = json['postId'];
//     creator =
//     json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
//     comment =
//     json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
//     reaction = json['reaction'] != null
//         ? new Reaction.fromJson(json['reaction'])
//         : null;
//     submission = json['submission'] != null
//         ? new Submission.fromJson(json['submission'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['postId'] = this.postId;
//     if (this.creator != null) {
//       data['creator'] = this.creator!.toJson();
//     }
//     if (this.comment != null) {
//       data['comment'] = this.comment!.toJson();
//     }
//     if (this.reaction != null) {
//       data['reaction'] = this.reaction!.toJson();
//     }
//     if (this.submission != null) {
//       data['submission'] = this.submission!.toJson();
//     }
//     return data;
//   }
// }
//
// class Creator {
//   String? name;
//   String? id;
//   String? handle;
//   String? pic;
//
//   Creator({this.name, this.id, this.handle, this.pic});
//
//   Creator.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     id = json['id'];
//     handle = json['handle'];
//     pic = json['pic'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['id'] = this.id;
//     data['handle'] = this.handle;
//     data['pic'] = this.pic;
//     return data;
//   }
// }
//
// class Comment {
//   int? count;
//   bool? commentingAllowed;
//
//   Comment({this.count, this.commentingAllowed});
//
//   Comment.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     commentingAllowed = json['commentingAllowed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['commentingAllowed'] = this.commentingAllowed;
//     return data;
//   }
// }
//
// class Reaction {
//   int? count;
//   bool? voted;
//
//   Reaction({this.count, this.voted});
//
//   Reaction.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     voted = json['voted'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['voted'] = this.voted;
//     return data;
//   }
// }
//
// class Submission {
//   String? mediaUrl;
//   String? thumbnail;
//   String? hyperlink;
//   String? placeholderUrl;
//
//   Submission(
//       {this.mediaUrl, this.thumbnail, this.hyperlink, this.placeholderUrl});
//
//   Submission.fromJson(Map<String, dynamic> json) {
//     mediaUrl = json['mediaUrl'];
//     thumbnail = json['thumbnail'];
//     hyperlink = json['hyperlink'];
//     placeholderUrl = json['placeholderUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['mediaUrl'] = this.mediaUrl;
//     data['thumbnail'] = this.thumbnail;
//     data['hyperlink'] = this.hyperlink;
//     data['placeholderUrl'] = this.placeholderUrl;
//     return data;
//   }
// }











// To parse this JSON data, do
//
//     final shortsModel = shortsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShortsModel shortsModelFromJson(String str) => ShortsModel.fromJson(json.decode(str));

String shortsModelToJson(ShortsModel data) => json.encode(data.toJson());

class ShortsModel {
  final String message;
  final Data data;

  ShortsModel({
    required this.message,
    required this.data,
  });

  factory ShortsModel.fromJson(Map<String, dynamic> json) => ShortsModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final List<Post> posts;
  final int page;
  final int offset;

  Data({
    required this.posts,
    required this.page,
    required this.offset,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    page: json["page"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "page": page,
    "offset": offset,
  };
}

class Post {
  final String postId;
  final Creator creator;
  final Comment comment;
  final Reaction reaction;
  final Submission submission;

  Post({
    required this.postId,
    required this.creator,
    required this.comment,
    required this.reaction,
    required this.submission,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: json["postId"],
    creator: Creator.fromJson(json["creator"]),
    comment: Comment.fromJson(json["comment"]),
    reaction: Reaction.fromJson(json["reaction"]),
    submission: Submission.fromJson(json["submission"]),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "creator": creator.toJson(),
    "comment": comment.toJson(),
    "reaction": reaction.toJson(),
    "submission": submission.toJson(),
  };
}

class Comment {
  final int count;
  final bool commentingAllowed;

  Comment({
    required this.count,
    required this.commentingAllowed,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    count: json["count"],
    commentingAllowed: json["commentingAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "commentingAllowed": commentingAllowed,
  };
}

class Creator {
  final String name;
  final String id;
  final String handle;
  final String pic;

  Creator({
    required this.name,
    required this.id,
    required this.handle,
    required this.pic,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    name: json["name"],
    id: json["id"],
    handle: json["handle"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "handle": handle,
    "pic": pic,
  };
}

class Reaction {
  int count;
  final bool voted;

  Reaction({
    required this.count,
    required this.voted,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
    count: json["count"],
    voted: json["voted"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "voted": voted,
  };
}

class Submission {
  final Title title;
  final String description;
  final String mediaUrl;
  final String thumbnail;
  final String hyperlink;
  final String placeholderUrl;

  Submission({
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.thumbnail,
    required this.hyperlink,
    required this.placeholderUrl,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    title: titleValues.map[json["title"]]!,
    description: json["description"],
    mediaUrl: json["mediaUrl"],
    thumbnail: json["thumbnail"],
    hyperlink: json["hyperlink"],
    placeholderUrl: json["placeholderUrl"],
  );

  Map<String, dynamic> toJson() => {
    "title": titleValues.reverse[title],
    "description": description,
    "mediaUrl": mediaUrl,
    "thumbnail": thumbnail,
    "hyperlink": hyperlink,
    "placeholderUrl": placeholderUrl,
  };
}

enum Title { RANDOM_TITLE }

final titleValues = EnumValues({
  "Random Title": Title.RANDOM_TITLE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}