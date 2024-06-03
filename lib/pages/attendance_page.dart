import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  final String selectedClass;
  final String selectedSection;
  final String selectedSubject;

  const AttendancePage({
    super.key,
    required this.selectedClass,
    required this.selectedSection,
    required this.selectedSubject,
  });

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Map<String, dynamic>> students = List.generate(
    10,
    (index) => {
      "name": "Meklit Tefera",
      "present": false,
      "absent": false,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATTENDANCE'),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Class: ${widget.selectedClass} ${widget.selectedSection}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  'Date: 12/12/21',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: DataTable(
              columnSpacing: 20,
              columns: const [
                DataColumn(label: Text('Student Name')),
                DataColumn(label: Text('Present')),
                DataColumn(label: Text('Absent')),
              ],
              rows: students.map((student) {
                return DataRow(cells: [
                  DataCell(Text(student['name'])),
                  DataCell(
                    Checkbox(
                      value: student['present'],
                      onChanged: (value) {
                        setState(() {
                          student['present'] = value!;
                          if (value) {
                            student['absent'] = false;
                          }
                        });
                      },
                    ),
                  ),
                  DataCell(
                    Checkbox(
                      value: student['absent'],
                      onChanged: (value) {
                        setState(() {
                          student['absent'] = value!;
                          if (value) {
                            student['present'] = false;
                          }
                        });
                      },
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
