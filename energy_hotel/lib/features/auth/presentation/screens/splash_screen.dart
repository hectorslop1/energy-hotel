import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/splashVideo.mp4');

    try {
      await _videoController.initialize();
      _videoController.setLooping(false);
      _videoController.setVolume(0);

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController.play();

        _videoController.addListener(_videoListener);
      }
    } catch (e) {
      _checkSession();
    }
  }

  void _videoListener() {
    if (_videoController.value.position >= _videoController.value.duration &&
        _videoController.value.duration > Duration.zero) {
      _videoController.removeListener(_videoListener);
      _checkSession();
    }
  }

  Future<void> _checkSession() async {
    if (mounted) {
      await ref.read(authProvider.notifier).checkSession();
    }
  }

  @override
  void dispose() {
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isVideoInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
