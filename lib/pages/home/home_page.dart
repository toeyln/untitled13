import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:untitled13/models/Food.dart';
import 'package:untitled13/models/api_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Food> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLUTTER FOOD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: _handleClickButton,
                  child: Text('LOAD FOODS DATA'),
                ),
              ),
            ),
            result.isEmpty?
            SizedBox.shrink():
            Expanded(
              child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index){
                  var fooditem = result[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Image.network(
                            fooditem.image,
                            width: 85.0,
                            height: 85.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fooditem.name,
                                  style: TextStyle(
                                      fontSize: 20.0
                                  ),
                                ),
                                Text(
                                  '${fooditem.price} บาท',
                                  style: TextStyle(
                                      fontSize: 16.0
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  _handleClickButton(){
    _fetchFood();
  }
  _fetchFood() async{
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    var response = await http.get(url);

    print(response.body);
    /*result.then((response){
      print(response.body);
    });*/
    var json = jsonDecode(response.body);

    var apiResult = ApiResult.fromJson(json);
    List data = apiResult.data;
    setState(() {
      result = data.map((e) => Food.fromJson(e)).toList();
    });
  }
}