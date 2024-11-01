import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise/src/core/utils/local_storage.dart';


void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });


  group('Storage Operations', () {
    late LocalStorage localStorage;

    setUp(() async {
      localStorage = await LocalStorage.getInstance();
    });

    test('access token operations', () async {
      expect(localStorage.getAccessToken(), null);
      
      await localStorage.setAccessToken('test_token');
      expect(localStorage.getAccessToken(), 'test_token');
      
      await localStorage.deleteAccessToken();
      expect(localStorage.getAccessToken(), null);
    });


  });

  group('Error Handling', () {
    test('handles uninitialized preferences gracefully', () async {
      final localStorage = LocalStorage.instance;
      
      expect(localStorage.getAccessToken(), null);
      expect(localStorage.getIsDoneOnboarding(), false);
      expect(localStorage.getIsDarkMode(), false);
    });
  });
}
