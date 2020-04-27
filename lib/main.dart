import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final webViewKey = GlobalKey<_SoftXWebViewState>();
void main() => runApp(SoftXApp());

class SoftXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
//              backgroundColor: Color.fromRGBO(13, 202, 120, 1),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: IconButton(
                color: Colors.blueGrey,
                onPressed: () {
                  webViewKey.currentState?.goToHome();
                },
                icon: Icon(Icons.home),
              ),
              leading: IconButton(
                  color: Colors.blueGrey,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    webViewKey.currentState?.goOneStepBack();
                  }),
              actions: <Widget>[
                IconButton(
                  color: Colors.blueGrey,
                  icon: Icon(Icons.refresh),
                  onPressed: () {
//                    print('User pressed the button');
                    webViewKey.currentState?.reloadWebView();
                  },
                ),
              ],
            ),
          ),
          body: SoftXWebView(key: webViewKey),
        ),
      ),
    );
  }
}

class SoftXWebView extends StatefulWidget {
  SoftXWebView({Key key}) : super(key: key);
  @override
  _SoftXWebViewState createState() => _SoftXWebViewState();
}

class _SoftXWebViewState extends State<SoftXWebView> {
  @override
// Home Url
  final String selectedUrl = 'https://softx.app';
//  Future<WebViewController> _webViewControllerFuture;
  WebViewController _webViewController;
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

  cannotLoad() {
    setState(() {
      position = 2;
    });
  }

  goToHome() {
    _webViewController?.loadUrl('$selectedUrl');
  }

  reloadWebView() {
    _webViewController?.reload();
  }

  goOneStepBack() {
    _webViewController?.goBack();
  }

  Widget build(BuildContext context) {
    return IndexedStack(
      index: position,
      children: <Widget>[
        WebView(
          initialUrl: '$selectedUrl',
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: startLoading,
          onPageFinished: doneLoading,
          onWebResourceError: cannotLoad(),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
//              backgroundColor: Colors.blueGrey.shade50,
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(13, 202, 120, 1)),
            ),
          ),
        ),
        Container(
          child: Center(
            child: Image.asset('images/404 image.jpg'),
          ),
        ),
      ],
    );
  }
}
