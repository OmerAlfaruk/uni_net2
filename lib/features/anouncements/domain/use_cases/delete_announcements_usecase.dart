


import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';

class DeleteAnnouncementsUseCase {
  final AnnouncementRepository repository;

  DeleteAnnouncementsUseCase({required this.repository});

  Future<void> call(AnnouncementsEntity announcements) {
    return repository.deleteAnnouncements(announcements);
  }
}