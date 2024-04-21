
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';

class UpdateAnnouncementUseCase {
  final AnnouncementRepository repository;

  UpdateAnnouncementUseCase({required this.repository});

  Future<void> call(AnnouncementsEntity announcements) {
    return repository.updateAnnouncements(announcements);
  }
}