import 'package:evika/models/user/post_model.dart';

abstract class CommonRepo {
  Future<List>? userLikedPost();
  Future<List<Comment>> getAndAddComments(String postId, String? text);
}
