import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos/blocs/FavoriteBloc.dart';
import 'package:favoritos/blocs/FavoriteCardBloc.dart';
import 'package:favoritos/models/Post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final Post post;
  PostCard(this.post);

  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  FavoriteCardBloc _favoriteCardBloc;
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _favoriteCardBloc = FavoriteCardBloc(widget.post);    

    WidgetsBinding.instance.addPostFrameCallback((_){

      _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
      _favoriteBloc.favoritesListFlux.listen(_favoriteCardBloc.favoritesListEvent.add);
    
    });

    super.initState();
  }

  @override
  void dispose() {
    _favoriteCardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.blueGrey,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 200,
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Post Id: ${widget.post.id}",
                  style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Post Title: ${widget.post.title}",
                  style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Post Body: ${widget.post.body}",
                  style: TextStyle(color: Colors.white)),
            ),

            StreamBuilder(
              stream: _favoriteCardBloc.isFavoriteFlux,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                return snapshot.data
                  ? IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: (){
                      _favoriteBloc.favoritesListDeleteEvent.add(widget.post);
                    },
                  )
                  : IconButton(
                    icon: Icon(Icons.favorite_border,color: Colors.grey),
                    onPressed: (){
                      _favoriteBloc.favoritesListAddEvent.add(widget.post);
                    },
                  );
              },
            )

          ],
        ),
      ),
    );
  }
}
