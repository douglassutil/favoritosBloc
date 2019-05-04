import 'package:favoritos/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteCardBloc extends BlocBase {

  final _favoritesListController = BehaviorSubject<List<Post>>();
  Observable<List<Post>> get favoritesListFlux => _favoritesListController.stream;
  Sink<List<Post>> get favoritesListEvent => _favoritesListController.sink;

  final _isFavoriteController = BehaviorSubject<bool>();
  Observable<bool> get isFavoriteFlux => _isFavoriteController.stream;
  Sink<bool> get isFavoriteEvent => _isFavoriteController.sink;

  FavoriteCardBloc(Post post){
    favoritesListFlux
    .map((dados) => dados.contains(post))
    .listen(isFavoriteEvent.add);
  }
  
  @override
  void dispose() {
    _isFavoriteController.close();
    _favoritesListController.close();
  }
  
}