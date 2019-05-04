import 'package:favoritos/blocs/PostBloc.dart';
import 'package:favoritos/components/PostCard.dart';
import 'package:favoritos/models/Post.dart';
import 'package:favoritos/views/FavoritesPage.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostBloc();
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Página de posts"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _postBloc.postListFlux,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = snapshot.data[index];
                  return PostCard(post);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => FavoritesPage()
        )),
        child: Icon(Icons.favorite),
      ),
    );
  }
}
