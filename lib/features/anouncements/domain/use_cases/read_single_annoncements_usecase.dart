


import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';

class ReadSingleAnnouncementsUseCase {
  final AnnouncementRepository repository;

  ReadSingleAnnouncementsUseCase({required this.repository});

  Stream<List<AnnouncementsEntity>> call(String announcementsId) {
    return repository.readSingleAnnouncements(announcementsId);
  }
}