import 'package:audionix/common/helpers/is_dark_mode.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../profile/bloc/favorite_songs_cubit.dart';
import '../../profile/bloc/favorite_songs_state.dart';
import '../../profile/bloc/profile_info_cubit.dart';
import '../../profile/bloc/profile_info_state.dart';
import '../../profile/pages/profile.dart';
import '../../song_player/pages/song_player.dart';
import '../widgets/news_songs.dart';
import '../widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const NewsSongs(),
    PlayList(),
    Center(child: Text('')),
    Center(child: Text('')),
  ];

  final List<Map<String, String>> artists = [
    {
      'name': 'Ariana Grande',
      'image': 'assets/images/ariana.png',
    },
    {
      'name': 'Arijit Singh',
      'image': 'assets/images/arijit.png',
    },
    {
      'name': 'Billie Eilish',
      'image': 'assets/images/billie.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Scaffold(
        appBar: BasicAppbar(
          hideBack: true,
          backgroundColor: context.isDarkMode
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                context.isDarkMode
                    ? AppVectors.logo_darktheme
                    : AppVectors.logo_lighttheme,
                height: 70,
                width: 70,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ProfilePage()));
                },
                icon: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/10542/10542486.png") // Add profile image
                    ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ArtistCarousel(artists: artists),
              if (_currentIndex == 2) _favoriteSongs(),
              if (_currentIndex == 3)
                _profileInfo(context)
              else
                _pages[_currentIndex],
              // For other indexes, show the usual pages
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: context.isDarkMode
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          selectedItemColor: AppColors.primary,
          unselectedItemColor:
              context.isDarkMode ? Colors.white54 : Colors.black54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note_outlined),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class ArtistCarousel extends StatelessWidget {
  final List<Map<String, String>> artists;

  ArtistCarousel({required this.artists});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          initialPage: 1,
          autoPlay: true,
        ),
        items: artists.map((artist) {
          return _homeTopCard(artist['name']!, artist['image']!);
        }).toList(),
      ),
    );
  }

  Widget _homeTopCard(String artistName, String artistImage) {
    return Center(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffA5033D), Color(0xffFF6F61)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Trending Artist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      artistName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Image.asset(
                  artistImage,
                  height: 130,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _favoriteSongs() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FAVORITE SONGS',
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
          builder: (context, state) {
            if (state is FavoriteSongsLoading) {
              return const CircularProgressIndicator();
            }
            if (state is FavoriteSongsLoaded) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SongPlayerPage(
                              songEntity: state.favoriteSongs[index]),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${AppURLs.coverFirestorage}${state.favoriteSongs[index].title}.jpg?${AppURLs.mediaAlt}'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.favoriteSongs[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.favoriteSongs[index].artist,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(state.favoriteSongs[index].duration
                                .toString()
                                .replaceAll('.', ':')),
                            const SizedBox(
                              width: 20,
                            ),
                            FavoriteButton(
                              songEntity: state.favoriteSongs[index],
                              key: UniqueKey(),
                              function: () {
                                context
                                    .read<FavoriteSongsCubit>()
                                    .removeSong(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: state.favoriteSongs.length,
              );
            }
            if (state is FavoriteSongsFailure) {
              return const Text('Please try again.');
            }
            return Container();
          },
        ),
      ],
    ),
  );
}

Widget _profileInfo(BuildContext context) {
  return BlocProvider(
    create: (context) => ProfileInfoCubit()..getUser(),
    child: Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProfileInfoLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text(
                      'Username: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      state.userEntity.email!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Full Name: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        state.userEntity.fullName!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Logout button with Icon
              ],
            );
          }

          if (state is ProfileInfoFailure) {
            return const Center(
                child: Text('Failed to load profile. Please try again.'));
          }

          return const SizedBox.shrink();
        },
      ),
    ),
  );
}
