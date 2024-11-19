import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'navigation.dart'; // Make sure this file exists in the project

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize VideoPlayerController to play video from assets
    _controller = VideoPlayerController.asset('assets/juggernaut.1920x1080.mp4')
      ..initialize().then((_) {
        setState(() {}); // Update the UI once the video is ready
        _controller.play(); // Start the video automatically

        // Add listener to detect when the video finishes
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            // Navigate to NavigationPage when the video finishes
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const NavigationPage()),
            );
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the page is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover, // Ensure the video covers the screen
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(), // Show loading indicator while video is loading
          ),
          // Overlay "Loading" text at the center of the screen with opacity
          const Center(
            child: Opacity(
              opacity: 0.8, // Adjust the opacity (0.0 to 1.0)
              child: Text(
                'Loading',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black54, // Semi-transparent background
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
