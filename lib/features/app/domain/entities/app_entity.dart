
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';


class AppEntity {

  final UserEntity? currentUser;
  final PostEntity? postEntity;


  final String? uid;
  final String? postId;
  final String? newsId;
  final String? announcementsId;


  AppEntity(  { this.currentUser, this.postEntity, this.uid, this.postId,this.newsId,this.announcementsId, });
}