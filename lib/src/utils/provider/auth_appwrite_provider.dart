// ignore_for_file: avoid_print, unused_local_variable

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/utils/constant/constant.dart';

final appwriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppwriteConstant.endPoint)
      .setProject(AppwriteConstant.projectId);
});
