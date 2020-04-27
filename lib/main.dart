import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(SoftXApp());

class SoftXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SoftXWebView(),
        ),
      ),
    );
  }
}

class SoftXWebView extends StatefulWidget {
  @override
  _SoftXWebViewState createState() => _SoftXWebViewState();
}

class _SoftXWebViewState extends State<SoftXWebView> {
  @override
  // variables to make stacked indexes for widgets
  num position = 1;
// keys will make sure each time we use loads it will generate a new screen
  final key = UniqueKey();
  // this function will make the loader disappear by pushing it behind the webview
  void doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  void startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  Widget build(BuildContext context) {
    return IndexedStack(
      index: position,
      children: <Widget>[
        WebView(
          initialUrl: 'https://softx.app',
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: startLoading,
          onPageFinished: doneLoading,
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
