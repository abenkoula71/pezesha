import 'package:flutter/material.dart';
import 'package:pezeshainterview/application/core/services/api-provider.dart';
import 'package:pezeshainterview/presentation/file_upload.dart';

class MavelCharacters extends StatefulWidget {
  MavelCharacters({Key? key}) : super(key: key);

  @override
  _MavelCharactersState createState() => _MavelCharactersState();
}

class _MavelCharactersState extends State<MavelCharacters> {
  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    getMarvelCharacters();
  }

  late String name;
  late String imageUrl;
  var charctersData;
  late bool isLoading = false;

  Future getMarvelCharacters() async {
    final marvelData = charctersData = await apiProvider.getMarvelCharacters();
    setState(() {
      isLoading = true;
      charctersData = marvelData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text('Display Marvel Characters')),
        body: Container(
            child: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: Container(
              child: GridView.extent(
                  shrinkWrap: true,
                  maxCrossAxisExtent: 400,
                  children: [
                    for (int i = 0; i < charctersData.length; i++)
                      ListViewItems(
                        author: charctersData['data']['results'][i]['name'],
                        description: charctersData['data']['results'][i]
                            ['description'],
                        imageUrl: charctersData['data']['results'][i]
                            ['thumbnail']['path'],
                      )
                  ]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FileUploads()));
            },
            child: Text('File upload!'),
          ),
        ]))));
  }
}

class ListViewItems extends StatelessWidget {
  const ListViewItems(
      {required this.description,
      required this.author,
      required this.imageUrl});

  final String description;
  final String author;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Text(
              description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
            Image.network(
              imageUrl + '.jpg',
              height: 500,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 500,
              height: 70,
              child: Container(
                padding: EdgeInsets.all(2.0),
                color: Colors.grey[600],
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        author,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
