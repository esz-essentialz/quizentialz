import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizentialz/core/api/client.appwrite.dart';
import 'package:quizentialz/core/presentation/playlist/models/playlist.model.dart';
import 'package:quizentialz/core/theme/theme.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({super.key});

  @override
  State<PlaylistsPage> createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> {
  bool isloading = false;

  List<PlaylistModel> data = List.empty(growable: true);

  Future<void> loadData() async {
    isloading = true;
    final res = await AppwriteClient.databases.listDocuments(databaseId: "6799466d000f9af14149", collectionId: "6799467b000fc94d943c");
    for (final item in res.documents) {
      data.add(PlaylistModel.fromMap(item.data));
    }
    isloading = false;
    setState(() {});
  }

  Future<void> addNew(String title) async {
    await AppwriteClient.databases.createDocument(
      databaseId: "6799466d000f9af14149",
      collectionId: "6799467b000fc94d943c",
      documentId: ID.unique(),
      data: {
        "titles": title,
        "hours": 0,
      },
    );
  }

  void showDia() {
    final TextEditingController titleController = TextEditingController();
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: Dialog(
            backgroundColor: Themes.backgroundLightColor,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFC4C25),
                      ),
                      onPressed: showDia,
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<String> suggestions = List.of([""]);

  String searchText = "";

  Future<List<String>> getSearchSuggestions(String query) async {
    try {
      final Uri url = Uri.parse("https://suggestqueries.google.com/complete/search?client=firefox&q=$query");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List sugg = json.decode(response.body)[1];
        suggestions = sugg.cast<String>(); // Convert to List<String>
        setState(() {});
        print(suggestions);
        return suggestions;
      } else {
        print(suggestions);
        return List.empty();
      }
    } on Exception catch (e) {
      print(e);
      return List.empty();
    }
  }

  final Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 500));

  void onSearchChanged(String query) {
    _debouncer.call(() => getSearchSuggestions(query));
  }

  List<dynamic> videos = List.empty(growable: true);

  Future<void> searchVideos(String query) async {
    const String apiKey = "AIzaSyBhsgCsg_Mnfph4yCPRY4MOBdU4mpGZO1Q";
    const String baseUrl = "https://www.googleapis.com/youtube/v3";
    final Uri url = Uri.parse("$baseUrl/search?part=snippet&q=$query&type=video&maxResults=10&key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      videos = data["items"];
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: isloading ? 0 : 1,
            duration: Duration(milliseconds: 500),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    height: 65,
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        searchVideos(value);
                      },
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                      decoration: InputDecoration(
                        hintText: "Search here...",
                        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: videos.isNotEmpty ? 300 : 0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.only(right: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 300,
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Image.network(
                                  videos[index]['snippet']['thumbnails']['default']['url'].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                videos[index]['snippet']['title'],
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 280,
                    ),
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Themes.backgroundLightColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                height: 150,
                                data[index].thumbnail.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    data[index].title,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Icon(
                                    Icons.more,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${data[index].videosCount} videos",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    "${data[index].hrs} hrs",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Themes.primaryClr,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Open",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            child: SizedBox(
              width: isloading ? MediaQuery.of(context).size.width : 0,
              height: isloading ? MediaQuery.of(context).size.height : 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/anims/loading.json",
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Loading...",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Themes.backgroundColor),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Curated Playlists",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFC4C25),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: showDia,
                  child: Text(
                    "Add",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
