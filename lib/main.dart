import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: FirstPage(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  /* Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://www.google.com.hk/',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }*/

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: ElevatedButton(
            child: Text('Go to the Second page'),
            onPressed: () {
              Navigator.push(context2,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SecondPage();
              }));
            }),
      ),
    );
  }

  /*Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }*/

}

var lati = 0.0;
var longi = 0.0;

// Future _initLocationService() async {
//   var location = Location();
//   //location.enableBackgroundMode(enable: true);

//   if (!await location.serviceEnabled()) {
//     if (!await location.requestService()) {
//       return;
//     }
//   }

//   var permission = await location.hasPermission();
//   if (permission == PermissionStatus.denied) {
//     permission = await location.requestPermission();
//     if (permission != PermissionStatus.granted) {
//       return;
//     }
//   }

//   var loc = await location.getLocation();
//   location.onLocationChanged.listen((LocationData loc) async {
//     print("${loc.latitude} ${loc.longitude}");
//     lati = loc.latitude!;
//     longi = loc.longitude!;
//     //await server.postgiveloc();
//     //print(loc.accuracy);
//     //이거는 계속 위도 경도 출력해주는 코드
//     //서버에 위도 경도 값 전송
//   }
//   );

//   // lati = loc.latitude!;
//   // longi = loc.longitude!;
//   // print(lati);
//   // print(longi);
// }

// void getLocation() async {
//   LocationPermission permission = await Geolocator.requestPermission();
//   Position position = await Geolocator.getCurrentPosition(
//   desiredAccuracy: LocationAccuracy.high);
//   print(position);
//   }

class FirstPage extends StatelessWidget {
  //임시로 적은 코드
  //실시간 위치를 찍는 용도
  //이것을 실제로 다른 클래스에 넣어야함. 위치는 동일

  @override
  Widget build(BuildContext context2) {
    double screenHeight = MediaQuery.of(context2).size.height;
    return Scaffold(
      //appBar: AppBar(
      // title: Text('환영합니다 등산의 신입니다.'),
      // centerTitle: true,
      // ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * .12),
              const Text(
                "환영합니다,",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .01),
              Text(
                "등산을 시작하기전 로그인 버튼을 누르세요",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(.6),
                ),
              ),
              SizedBox(height: screenHeight * .100),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('images/free-icon-mountain-1401449.png')),
              SizedBox(height: screenHeight * .100),
              ElevatedButton(
                  child: Text('카카오톡 로그인'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(5.0),
                    textStyle: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.push(context2,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SecondPage();
                    }));
                  }),
              ElevatedButton(
                  child: Text('등산 시작하기'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(5.0),
                    textStyle: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.push(context2,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return RootSearchPage();
                    }));
                  }),
              // ElevatedButton(
              //     child: Text('테스트용 버튼'),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.yellow,
              //       onPrimary: Colors.black,
              //       padding: EdgeInsets.all(5.0),
              //       textStyle: TextStyle(color: Colors.red),
              //     ),
              //     onPressed: () {
              //       _initLocationService();

              //       //getLocation();
              //       //showDialog(
              //       //context: context2,
              //       //builder: (context) {
              //       //return AlertDialog(content: Text("${a} ${b}"));
              //       //});
              //     }),
            ],
          )),
    );
  }
}

//카카오 로그인 구현하기
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl:
          'https://kauth.kakao.com/oauth/authorize?client_id=da1d5adf1ff2f6c434f49a0664498bbd&libraries=services&redirect_uri=http://110.12.181.206:8081/kakao&response_type=code',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

//서버에서 받아온 맵을 웹뷰로
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'http://110.12.181.206:8081/map',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

var mntn_nm = ""; // 전송한 산이름
var res_mntn_nm = ""; // 받아온 산이름
var startnum = 0;
var endnum = 0;
var loadlist = ""; //받아온 경로 리스트

Server server = Server();

class RootSearchPage extends StatefulWidget {
  SearchPage createState() => SearchPage();
}

//산 검색기능
class SearchPage extends State<RootSearchPage> {
  final List<String> _valueList = [
    '개좌산',
    '거문산',
    '공덕산',
    '구덕산',
    '금련산',
    '금정산',
    '달음산',
    '만남의광장구포도서관',
    '몰운대',
    //추가해줌
    '승학산',
    '시악산',
    '엄광산',
    '구봉산',
    '계명산',
    '상학산',
    '천마산',
    '함박산',
    '월음산',
    '갈미산',
    '범방산'
  ];
  String _selectedValue = '개좌산';
  @override
  //final myController = TextEditingController();
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * .100),
              SizedBox(
                  height: 200,
                  width: 400,
                  child: Image.asset('images/free-icon-document-4426154.png')),
              Text(
                "산을 선택하여 검색 버튼을 눌러주세요.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .100),
              DropdownButton(
                value: _selectedValue,
                items: _valueList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value.toString();
                  });
                },
              ),
              //TextField(
              //controller: myController,
              //decoration: InputDecoration(
              //  labelText: '산을 검색하세요',
              // ),
              // ),
              //SizedBox(height: screenHeight * .100),
              ElevatedButton(
                  child: Text('검색'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(5.0),
                    textStyle: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    /* 
                      동규한테 text값 보낸 다음 
                      if 넣고 
                      존재하면 다음 페이지로 
                      존재안하면 showDialog로 다시 입력하라고 알림창 뜨게
                    */
                    mntn_nm = _selectedValue;
                    await server.postReq(); //비동기 형식 실행이 먼저 안된다.
                    //아래의 if문 부터 실행

                    if (res_mntn_nm.compareTo("ERROR") == 0) {
                      print(1);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(content: Text("잘못된 입력입니다."));
                          });
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return CheckPage();
                      }));
                      //showDialog(
                      //context: context,
                      // builder: (context) {
                      // return AlertDialog(content: Text(res_mntn_nm));
                      //});
                      // 버튼 클릭창 만들기.
                    }
                    /*showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(content: Text(myController.text));
                        });*/
                  }),
            ],
          )),
    );
  }
}

//서버한테 다시 확인하기 위해 버튼하나 만들고 그 버튼을 누르면 전송
class CheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * .100),
              Text(
                "${mntn_nm}(이)라는 산이 맞습니까?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .100),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await server.postReq();
                      await server.poststartnum();
                      await server.postendnum();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return StartWebviewPage();
                      }));
                    },
                    child: Text("예"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return RootSearchPage();
                      }));
                    },
                    child: Text("아니오"),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

const DOMAIN = "http://110.12.181.206:8081";
const MOUNTAIN = "/mountain";
const STARTCOUNTDOMAIN = "/startcount";
const ENDCOUNTDOMAIN = "/endcount";
const SearchDOMAIN = "/search";

class Server {
  Future<void> getReq() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$MOUNTAIN");
    print(response.data.toString());
  }

  Future<void> postReq() async {
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(DOMAIN + MOUNTAIN, data: {"MNTN_NM": mntn_nm}); //동규한테 던지기
    print(response.data['MNTN_NM']); //동규가 답변 해준 값
    res_mntn_nm = response.data['MNTN_NM']; //res_mntn_nm이 {MNTN_NM: 몰운대}로 찍힌다.

    //res_mntn-nm은 제이슨 형식의 스트링으로 해줘야하므로 []이것을 지운다.
  }

  Future<void> poststartnum() async {
    //시작점 개수 받는거
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(DOMAIN + STARTCOUNTDOMAIN, data: {"MNTN_NM": mntn_nm}); //동규한테 던지기
    //print(response.data['MNTN_NM']); //동규가 답변 해준 값
    startnum = response.data['count'];
    print(startnum);
  }

  Future<void> postendnum() async {
    //도착점 개수 받는거
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(DOMAIN + ENDCOUNTDOMAIN, data: {"MNTN_NM": mntn_nm}); //동규한테 던지기
    //print(response.data['MNTN_NM']); //동규가 답변 해준 값
    endnum = response.data['count'];
    print(endnum);
  }

  Future<void> postgiveloc() async {
    //위도 경도 보내는것
    Response response;
    Dio dio = new Dio();
    response = await dio.post(DOMAIN + STARTCOUNTDOMAIN, data: [
      {"MNTN_NM": mntn_nm},
      {"LATITUDE": lati},
      {"LONGITUDE": longi}
    ]); //동규한테 던지기
    //print(response.data['MNTN_NM']); //동규가 답변 해준 값
  }
}

// 이제 해야할 것
// else 부분에서 동규가 보내준 경로들을 받고
// JSON 형식으로 받는다. 파싱 작업을 하여 각각 예쁘게 출력 해주기
// 이 경로 리스트를 다른 화면에 출력
// 경로 리스트 마다 버튼을 생성하여
// 해당 경로를 클릭 시
// 동규에게 다시 전송하고
// 웹뷰로 결과 화면 전송 || 타이머 버튼 만들기

//주의사항 onpressed할때 async랑 await부분 추가해줘야 순서대로 진행된다!!!

/*
웹뷰 실행 코드

 Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://www.google.com.hk/',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  
*/

//파싱작업
//{"test" : ["A경로","B경로","C경로"]}
var test1 = '{"test" : ["A경로","B경로","C경로"]}';

//List<String> arr=[];
var arr = jsonDecode(test1)['test'];
//여기에 동규가 준 경로 리스트들을 저장해준다.
int counting = arr.length;
//배열의 길이를 정해야 값 출력 가능

class ListviewPage extends StatefulWidget {
  const ListviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _ListviewPageState createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('경로 선택하기'),
        backgroundColor: Colors.green,
      ),
      body: ListView.separated(
          scrollDirection:
              Axis.vertical, //vertical : 수직으로 나열 / horizontal : 수평으로 나열
          separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.black,
              ), //separatorBuilder : item과 item 사이에 그려질 위젯 (개수는 itemCount -1 이 된다)
          itemCount: counting, //리스트의 개수
          itemBuilder: (BuildContext context, int index) {
            //리스트의 반목문 항목 형성
            index = index + 1;
            return Container(
              height: 140,
              color: Colors.white,
              alignment: Alignment.center,
              child: ListView(children: [
                Text('경로 : $index'),
                Text(''),
                Text(arr[index - 1]),
                Text('거리 : $counting'),
                Text('난이도 : 상'),
                TextButton(
                    child: Text('Choose'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                    //primary: Colors.yellow,
                    //onPrimary: Colors.black,
                    //padding: EdgeInsets.all(1.0),
                    //textStyle: TextStyle(color: Colors.red),
                    //),
                    onPressed: () {
                      //이거 누르면 동규한데 그 값을 다시 보내기
                    }),
              ]),
            );
          }),
    );
  }
}

//웹뷰 쪼개기 클래스 3개

class StartWebviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 1, child: StartingMapPage()),
            Expanded(flex: 1, child: SelectstartnumPage()),
          ],
        ),
      ),
    );
  }
}

var flag = 0; //시작점인지 도착점인지 확인하는 변수

class StartingMapPage extends StatelessWidget {
  const StartingMapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://110.12.181.206:8081/startmap?MNTN_NM=' + mntn_nm,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>{
        _webToAppChange(context),
      },
    );
  }
}

JavascriptChannel _webToAppChange(BuildContext context) {
  return JavascriptChannel(
      name: 'webToAppChange',
      onMessageReceived: (JavascriptMessage message) {
        print("webToAppChange 메시지 :  ${message.message}");
        tmpstartnum = message.message;
        if (flag == 0) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text("${tmpstartnum}번 시작점이 선택되었습니다."));
              });
        }
        if (flag > 0) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text("${tmpstartnum}번 도착점이 선택되었습니다."));
              });
        }
      });
}

//수정해서 이 클래스 사용 안함
//산 경로 개수 받아오기
class GetstartnumPage extends StatelessWidget {
  const GetstartnumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * .100),
              Text(
                "위 지도는 등산 경로 시작지점을 나타낸것입니다. 원하시는 시작점의 번호를 정하였으면 다음 아이콘을 클릭해주세요.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .100),
              IconButton(
                onPressed: () async {
                  await server.poststartnum();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SelectstartnumPage();
                  }));
                },
                icon: Icon(Icons.search),
                iconSize: 40,
              )
            ],
          )),
    );
  }
}

//산 시작지점을 선택하는 클래스
//여기서 시작점의 개수를 받아온다 정수값으로
//startnum

var tmpstartnum = " "; //textfield로 숫자를 스트링으로 받아오는 변수
var userstartnum = 0; //그 스트링을 숫자로 변환할때 사용하는 변수

class SelectstartnumPage extends StatelessWidget {
  @override
  final myController = TextEditingController();
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              //SizedBox(height: screenHeight * .100),
              // Text(
              //   "                현재 시작점의 개수 : ${startnum}",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Text(
                "   (지도에 표시된 마커을 눌러 시작점을 선택해주세요)",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                  height: 120,
                  width: 200,
                  child:
                      Image.asset('images/free-icon-start-line-2078840.png')),
              // TextField(
              //  controller: myController,
              //  decoration: InputDecoration(
              //   labelText: '원하시는 시작점을 눌러주세요',
              //  ),
              // ),
              SizedBox(height: 50.0),
              TextButton(
                  child: Text('다음 페이지로'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    userstartnum = int.parse(tmpstartnum);
                    if (userstartnum == 0 || userstartnum > startnum) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(content: Text("잘못된 입력입니다."));
                          });
                    } else {
                      //종료지점 선택하는 웹뷰 창으로 이동
                      flag++;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EndWebviewPage();
                      }));
                    }

                    //이거 누르면 동규한데 그 값을 다시 보내기
                  }),
            ],
          )),
    );
  }
}

//userstartnum은 정수형으로 시작 지점의 번호의 값이 저장

class EndWebviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 1, child: EndingMapPage()),
            Expanded(flex: 1, child: SelectendnumPage()),
          ],
        ),
      ),
    );
  }
}

class EndingMapPage extends StatelessWidget {
  const EndingMapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://110.12.181.206:8081/endmap?MNTN_NM=' + mntn_nm,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>{
        _webToAppChange(context),
      },
    );
  }
}

//수정해서 이 클래스 사용 안함
//산 경로 개수 받아오기
class GetendnumPage extends StatelessWidget {
  const GetendnumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: screenHeight * .100),
              Text(
                "위 지도는 등산 경로 도착지점을 나타낸것입니다. 원하시는 도착점의 번호를 정하였으면 다음 아이콘을 클릭해주세요.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .100),
              IconButton(
                onPressed: () async {
                  await server.postendnum();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SelectendnumPage();
                  }));
                },
                icon: Icon(Icons.search),
                iconSize: 40,
              )
            ],
          )),
    );
  }
}

var tmpendnum = " "; //textfield로 숫자를 스트링으로 받아오는 변수
var userendnum = 0; //그 스트링을 숫자로 변환할때 사용하는 변수

class SelectendnumPage extends StatelessWidget {
  @override
  final myController = TextEditingController();
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //SizedBox(height: screenHeight * .100),
              SizedBox(height: 30.0),
              // Text(
              //   "                현재 도착점의 개수 : ${endnum}",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Text(
                "   (지도에 표시된 마커을 눌러 도착점을 선택해주세요)",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                  height: 120,
                  width: 200,
                  child: Image.asset('images/finish.png')),
              // TextField(
              //controller: myController,
              // decoration: InputDecoration(
              //   labelText: '원하시는 도착점의 번호를 적어주세요',
              //  ),
              //  ),
              SizedBox(height: 50.0),
              TextButton(
                  child: Text('완료'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    userendnum = int.parse(tmpstartnum);
                    if (userendnum == 0 || userendnum > endnum) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(content: Text("잘못된 입력입니다."));
                          });
                    } else {
                      //이때 서버한테 시작지점과 끝지점 동시에 보내기
                      //결국 userstartnum과 userendnum을 보내야함.
                      flag = 0;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return WebViewResult();
                      }));
                    }

                    //이거 누르면 동규한데 그 값을 다시 보내기
                  }),
            ],
          )),
    );
  }
}

class WebViewResult extends StatefulWidget {
  @override
  ResultMapPage createState() => ResultMapPage();
}

//시작점과 도착점을 웹뷰로 전송했을 때
class ResultMapPage extends State<WebViewResult> {
  Future _initLocationService() async {
    var location = Location();
    //location.enableBackgroundMode(enable: true);

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    var loc = await location.getLocation();
    location.onLocationChanged.listen((LocationData loc) async {
      print("${loc.latitude} ${loc.longitude}");
      lati = loc.latitude!;
      longi = loc.longitude!;
      _myController.evaluateJavascript("appToWeb(${lati},${longi})");
      //await server.postgiveloc();
      //print(loc.accuracy);
      //이거는 계속 위도 경도 출력해주는 코드
      //서버에 위도 경도 값 전송
    });

    // lati = loc.latitude!;
    // longi = loc.longitude!;
    // print(lati);
    // print(longi);
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _myController;
  //const ResultMapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var resultstart = userstartnum.toString();
    var resultend = userendnum.toString();
    var resulturl = 'http://110.12.181.206:8081/search?MNTN_NM=' +
        mntn_nm +
        '&STARTNUM=' +
        resultstart +
        '&ENDNUM=' +
        resultend;
    return WebView(
      initialUrl: 'http://110.12.181.206:8081/search?MNTN_NM=' +
          mntn_nm +
          '&STARTNUM=' +
          resultstart +
          '&ENDNUM=' +
          resultend,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _myController = webViewController;
        _controller.complete(webViewController);
      },
      onPageStarted: (resulturl) {
        //print('웹뷰1');
        _initLocationService();
        //print('웹뷰2');
        //_myController.evaluateJavascript("appToWeb(${35.14487},${129.02144})");
      },
    );
  }
}

/////////////////////////////////////////////////////////

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
