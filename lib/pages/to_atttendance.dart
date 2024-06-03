import 'package:flutter/material.dart';
import 'attendance_page.dart';

class AttendanceFormPage extends StatefulWidget {
  const AttendanceFormPage({super.key});

  @override
  State<AttendanceFormPage> createState() => _AttendanceFormPageState();
}

class _AttendanceFormPageState extends State<AttendanceFormPage> {
  String? selectedClass;
  String? selectedSection;
  String? selectedSubject;

  final List<String> classes = ['Class 1', 'Class 2', 'Class 3'];
  final List<String> sections = ['A', 'B', 'C'];
  final List<String> subjects = ['Math', 'Science', 'English'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Form'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDropdown('Class', classes, selectedClass, (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    }),
                    const SizedBox(height: 10),
                    _buildDropdown('Section', sections, selectedSection,
                        (value) {
                      setState(() {
                        selectedSection = value;
                      });
                    }),
                    const SizedBox(height: 10),
                    _buildDropdown('Subject', subjects, selectedSubject,
                        (value) {
                      setState(() {
                        selectedSubject = value;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedClass == null ||
                      selectedSection == null ||
                      selectedSubject == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields'),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(
                        selectedClass: selectedClass!,
                        selectedSection: selectedSection!,
                        selectedSubject: selectedSubject!,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0), // Padding
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ), // Text style
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedItem,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButton<String>(
            value: selectedItem,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
