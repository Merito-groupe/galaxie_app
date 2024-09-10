import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:galaxie_app/models/advertisement_model.dart';
 import 'package:just_audio/just_audio.dart';
 
class AdvertisementPlayerPage extends StatefulWidget {
  @override
  _AdvertisementPlayerPageState createState() => _AdvertisementPlayerPageState();
}

class _AdvertisementPlayerPageState extends State<AdvertisementPlayerPage> {
  final AudioPlayer _player = AudioPlayer();
  String? _playingUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advertisement Player'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('advertisements').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No advertisements available'));
                }

                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: snapshot.data!.docs.map((doc) {
                    final advertisement = Advertisement.fromDocument(doc);

                    String title = advertisement.title ?? 'No Title';
                    String advertiserName = advertisement.advertiserName ?? 'Unknown Advertiser';
                    String? audioUrl = advertisement.url;

                    return Card(
                      elevation: 4.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        leading: Icon(Icons.play_circle_fill, color: Colors.blueAccent),
                        title: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(advertiserName),
                        trailing: _playingUrl == audioUrl
                            ? StreamBuilder<PlayerState>(
                                stream: _player.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final processingState = playerState?.processingState;
                                  final playing = playerState?.playing;

                                  if (!(playing ?? false)) {
                                    return Icon(Icons.play_arrow, color: Colors.blueAccent);
                                  } else if (processingState != ProcessingState.ready) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return Icon(Icons.pause, color: Colors.blueAccent);
                                  }
                                },
                              )
                            : Icon(Icons.play_arrow, color: Colors.blueAccent),
                        onTap: () => _playMusic(audioUrl),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _playMusic(String? url) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('URL is invalid')),
      );
      return;
    }

    try {
      if (_playingUrl == url) {
        if (_player.playing) {
          await _player.pause();
        } else {
          await _player.play();
        }
      } else {
        // Stop any currently playing audio before starting new one
        await _player.stop();
        setState(() {
          _playingUrl = url;
        });

        // Charger et jouer l'URL distante
        await _player.setUrl(url);
        await _player.play();
      }
    } catch (e) {
      print('Error playing music: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing music: $e')),
      );
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
