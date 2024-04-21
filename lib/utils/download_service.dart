import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadService {
  Future<void> downloadMessage(String message) async {
    // Extract download URL from message (replace with your logic)
    final downloadUrl = Uri.parse("https://example.com/message_file.jpg"); // Replace with actual URL

    final taskId = await FlutterDownloader.enqueue(
      url: downloadUrl.toString(),

      fileName: "downloaded_message.${getExtension(downloadUrl.toString())}", // Generate a filename
      showNotification: true,
      savedDir: '', // Optionally display a download notification
      // Optionally open the downloaded file automatically
    );

    if (taskId != null) {
      print("Download task ID: $taskId");
    } else {
      print("Download failed!"); // Handle download errors (optional)
    }
  }

  // Helper function to get file extension
  String getExtension(String url) {
    final parts = url.split('.');
    return parts.last;
  }
}
