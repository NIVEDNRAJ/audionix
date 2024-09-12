import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/song/get_play_list.dart';
import '../../../service_locator.dart';
import 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    try {
      var returnedSongs = await sl<GetPlayListUseCase>().call();
      if (isClosed) return;

      returnedSongs.fold(
            (l) {
          if (!isClosed) {
            emit(PlayListLoadFailure());
          }
        },
            (data) {
          if (!isClosed) {
            emit(PlayListLoaded(songs: data));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(PlayListLoadFailure()); // In case of exception
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
