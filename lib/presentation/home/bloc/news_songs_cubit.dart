import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/song/get_news_songs.dart';
import '../../../service_locator.dart';
import 'news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {

  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    if (isClosed) return; // Early exit if the cubit is closed

    var returnedSongs = await sl<GetNewsSongsUseCase>().call();
    returnedSongs.fold(
          (l) {
        if (!isClosed) emit(NewsSongsLoadFailure());
      },
          (data) {
        if (!isClosed) emit(NewsSongsLoaded(songs: data));
      },
    );
  }



}