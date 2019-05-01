import 'package:favoritos/models/Favorites.dart';
import 'package:favoritos/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteBloc extends BlocBase {

  final _favorites = Favorites();

  final _favoritesListController = BehaviorSubject<List<Post>>();
  Observable<List<Post>> get favoritesListFlux => _favoritesListController.stream;
  Sink<List<Post>> get favoritesListEvent => _favoritesListController.sink;

  final _favoritesListAddController = BehaviorSubject<Post>();
  Observable<Post> get favoritesListAddFlux => _favoritesListAddController.stream;
  Sink<Post> get favoritesListAddEvent => _favoritesListAddController.sink;

  final _favoritesListDeleteController = BehaviorSubject<Post>();
  Observable<Post> get favoritesListDeleteFlux => _favoritesListDeleteController.stream;
  Sink<Post> get favoritesListDeleteEvent => _favoritesListDeleteController.sink;

  FavoriteBloc(){
    favoritesListAddFlux.listen(_handleAdd);
    favoritesListDeleteFlux.listen(_handeDelete);
  }

  void _handleAdd(Post post){
    _favorites.posts.add(post);
  }

  void updateList(){
    favoritesListEvent.add(_favorites.posts.toList());
  }

  void _handeDelete(Post post){
    _favorites.posts.remove(post);
  }

  @override
  void dispose() {
    _favoritesListController.close();
    _favoritesListAddController.close();
    _favoritesListDeleteController.close();
  }
  
}