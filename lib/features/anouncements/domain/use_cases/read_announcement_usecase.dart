


import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';

class ReadAnnouncementsUseCase {
  final AnnouncementRepository repository;

  ReadAnnouncementsUseCase({required this.repository});

  Stream<List<AnnouncementsEntity>> call(AnnouncementsEntity announcements) {
    return repository.readAnnouncements(announcements);
  }
}