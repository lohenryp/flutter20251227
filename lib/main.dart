import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'services/device_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final storageService = StorageService();
    await storageService.initialize();

    final deviceService = DeviceService(storageService);
    await deviceService.initialize();

    runApp(MyApp(deviceService: deviceService));
  } catch (e, st) {
    // 若初始化失敗，顯示錯誤頁面以便在瀏覽器看到錯誤訊息
    // 並將錯誤訊息輸出到 terminal
    print('Initialization error: $e');
    print(st);
    runApp(ErrorApp(error: e.toString()));
  }
}

class ErrorApp extends StatelessWidget {
  final String error;
  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initialization Error',
      home: Scaffold(
        appBar: AppBar(title: const Text('初始化失敗')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '初始化時發生錯誤：\n\n$error',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final DeviceService deviceService;
  
  const MyApp({super.key, required this.deviceService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAC 設備管理系統',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(deviceService: deviceService),
      debugShowCheckedModeBanner: false,
    );
  }
}
