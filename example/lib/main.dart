import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_nb_net/io.dart';
import 'package:game_shield/game_shield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _gameShieldPlugin = GameShield();
  var PROXY = "PROXY localhost:8888";
  @override
  void initState() {
    super.initState();
    initPlatformState();
    // NetOptions.instance
    NetOptions.instance
        .setConnectTimeout(Duration(seconds: 3))
        .setBaseUrl("http://httpbin.org")
        .setHttpClientAdapter(IOHttpClientAdapter()
          ..createHttpClient = () {
            var httpClient = HttpClient();
            httpClient.findProxy = (uri) {
              // 将请求代理至 localhost:8888。
              // 请注意，代理会在你正在运行应用的设备上生效，而不是在宿主平台生效。
              print("代理请求 $PROXY");
              return PROXY;
            };
            return httpClient;
          })
        // .addInterceptor(
        //     InterceptorsWrapper(onRequest: (options, handler) async {
        //   print("请求之前");
        //   return handler.next(options);
        // }))
        .enableLogger(true)
        .create();

    Future.delayed(Duration(seconds: 1), () async {
      var data = await GameShield.getServerIPAndPort("httpbin.org", 80);
      print("获取到的 ip: ${data?.ip}  port: ${data?.port}");
      PROXY = 'PROXY ${data?.ip}:${data?.port}';

      for (var i = 0; i < 100; i++) {
        print("第$i 次请求");
        try {
          print(await NetOptions.instance.dio.get("/get"));
        } catch (e) {
          print(e);
        }
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var dd = await GameShield.initSDK("324e6f756d512e62c203c4ee3dc77895",
          "TJgeH+TCfohcQ/3eNRovAjPTh0vbXaSjT4J2srFg1aUITbokw5g/87e4h+vTjP9qEQYDHLcYRb9LysFAFLgsGSw6V5m2ajJ9TxDC2NqnI8G2ebCLOwEpQ8yw3UqomfdXOdZs5cktu/qdqeEvYMzqh1V/Eqp7YNHT4LNu+VSo7AdCi0vt1K35FeHra8pN9sGTfg3bZrOPeFDNYzP1tII=");
      print(dd);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
