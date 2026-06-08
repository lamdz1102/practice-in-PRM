import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // Giá trị của Slider
  double rating = 50;

  // Giá trị của Switch
  bool isActive = false;

  // Giá trị được chọn trong RadioListTile
  String? selectedGenre;

  // Ngày được chọn từ DatePicker
  DateTime? selectedDate;

  // Hàm mở DatePicker
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    // Nếu người dùng chọn ngày thì cập nhật lại UI
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh tiêu đề
      appBar: AppBar(
        title: const Text('Exercise 2 - Input Controls'),
      ),

      // Nội dung chính
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slider
              const Text(
                'Rating (Slider)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Slider(
                value: rating,
                min: 0,
                max: 100,
                divisions: 100,
                label: rating.round().toString(),
                onChanged: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),

              Text('Current value: ${rating.round()}'),

              const SizedBox(height: 24),

              // Switch
              const Text(
                'Active (Switch)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SwitchListTile(
                title: const Text('Is movie active?'),
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),

              Text('Current status: ${isActive ? 'Active' : 'Inactive'}'),

              const SizedBox(height: 24),

              // RadioListTile
              const Text(
                'Genre (RadioListTile)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                title: const Text('Action'),
                value: 'Action',
                groupValue: selectedGenre,
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Comedy'),
                value: 'Comedy',
                groupValue: selectedGenre,
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Drama'),
                value: 'Drama',
                groupValue: selectedGenre,
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
              ),

              Text('Selected genre: ${selectedGenre ?? 'None'}'),

              const SizedBox(height: 24),

              // DatePicker
              Center(
                child: ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text('Open Date Picker'),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  selectedDate == null
                      ? 'No date selected'
                      : 'Selected date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}