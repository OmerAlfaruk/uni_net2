


import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';

class LikeAnnouncementsUseCase {
  final AnnouncementRepository repository;

  LikeAnnouncementsUseCase({required this.repository});

  Future<void> call(AnnouncementsEntity announcements) {
    return repository.likeAnnouncements(announcements);
  }
}