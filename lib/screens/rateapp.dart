import 'package:flutter/material.dart';

class RateAppPage extends StatefulWidget {
  const RateAppPage({super.key});

  @override
  State<RateAppPage> createState() => _RateAppPageState();
}

class _RateAppPageState extends State<RateAppPage> {
  double _rating = 0.0; // Stores the selected rating
  final TextEditingController _feedbackController = TextEditingController();

void _submitReview() {
  // Retrieve feedback text from the controller
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Thank you!"),
      content: const Text("Your review has been submitted."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );

  // Clear inputs
  setState(() {
    _rating = 0.0;
    _feedbackController.clear();
  });
}


  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rate this Application',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please rate your experience and leave feedback to help us improve.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              
              // Star Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < _rating ? Colors.amber : Colors.grey,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              
              // Feedback Input
              TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Leave your feedback here',
                  border: OutlineInputBorder(),
                  hintText: 'Tell us what you think...',
                ),
              ),
              const SizedBox(height: 20),
              
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitReview,
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
