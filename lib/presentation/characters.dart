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
  List<dynamic> charactersList = [];
  var charctersData;
  late bool isLoading = false;

  Future getMarvelCharacters() async {
    charctersData = await apiProvider.getMarvelCharacters();
    setState(() {
      charactersList = charctersData['data']['results']['items'];
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
                    for (int i = 0; i < charactersList.length; i++)
                      ListViewItems(
                        author: charctersData['data']['results']['items'][i]
                            ['name'],
                        imageUrl: charctersData['data']['results']['items'][i]
                            ['resourceURI'],
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
  const ListViewItems({required this.imageUrl, required this.author});

  final String imageUrl;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              imageUrl,
              height: 200,
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
                    Text(
                      author,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
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
