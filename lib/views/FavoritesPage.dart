import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos/blocs/FavoriteBloc.dart';
import 'package:favoritos/models/Post.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {

    FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Página de favoritos"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: favoriteBloc.favoritesListFlux ,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
            if (snapshot.hasData && snapshot.data.isNotEmpty){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  Post post = snapshot.data[index];
                return Dismissible(
                  key: Key("${post.id}"),
                  onDismissed: (direction){
                    favoriteBloc.favoritesListDeleteEvent.add(post);
                  },
                  child: Card(
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.blueGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("postId: ${post.id}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("postTitle: ${post.title}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("postBody: ${post.body}"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            }else{
              return Center(
                child: Text("Você ainda não possui favoritos!"),
              );
            }
          },
        ),
      ),
    );
  }
}