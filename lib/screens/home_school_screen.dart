import 'package:flutter/material.dart';

class HomeschoolScreen extends StatefulWidget {
  const HomeschoolScreen({super.key});

  @override
  _HomeschoolScreenState createState() => _HomeschoolScreenState();
}

class _HomeschoolScreenState extends State<HomeschoolScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homeschooling',
          style: TextStyle(
            fontSize: isTablet ? 24 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.lightBlue[300],
                borderRadius: BorderRadius.circular(25),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              tabs: const [
                Tab(text: 'Teacher View'),
                Tab(text: 'Student View'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_teacherView(size, isTablet), _studentView()],
      ),
    );
  }

  Widget _teacherView(Size size, bool isTablet) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Progress',
            style: TextStyle(
              fontSize: isTablet ? 22 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Expanded(
            child: ListView(
              children: [
                _studentCard(
                  context,
                  name: "Sarah Adams",
                  grade: "Grade: 9",
                  math: 78,
                  science: 92,
                  time: "12h",
                  size: size,
                  isTablet: isTablet,
                ),
                _studentCard(
                  context,
                  name: "James Wilson",
                  grade: "Grade: 9",
                  math: 65,
                  science: 70,
                  time: "8h",
                  size: size,
                  isTablet: isTablet,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _studentView() {
    return const Center(
      child: Text(
        "Student View - Coming Soon!",
        style: TextStyle(fontSize: 16),
      ),
    );
  }


  Widget _studentCard(
    BuildContext context, {
    required String name,
    required String grade,
    required int math,
    required int science,
    required String time,
    required Size size,
    required bool isTablet,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => StudentDetailScreen(
                  name: name,
                  grade: grade,
                  todayHours: 1.5,
                  weekHours: 8.5,
                  totalHours: 48,
                  subjects: [
                    SubjectProgress(
                      name: "Mathematics",
                      progress: math,
                      hours: 3.2,
                    ),
                    SubjectProgress(
                      name: "Science",
                      progress: science,
                      hours: 2.5,
                    ),
                  ],
                ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: isTablet ? 35 : 25,
                child: Text(
                  name[0],
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      grade,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    _progressBar("Math", math, size, isTablet),
                    _progressBar("Science", science, size, isTablet),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                time,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressBar(String subject, int progress, Size size, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$subject: $progress%",
          style: TextStyle(fontSize: isTablet ? 18 : 14),
        ),
        SizedBox(height: size.height * 0.005),
        SizedBox(
          width: size.width * (isTablet ? 0.6 : 0.5),
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: progress / 100,
            backgroundColor: Colors.grey[300],
            color: Colors.lightBlue[300],
            minHeight: isTablet ? 8 : 5,
          ),
        ),
      ],
    );
  }
}

class StudentDetailScreen extends StatelessWidget {
  final String name;
  final String grade;
  final double todayHours;
  final double weekHours;
  final double totalHours;
  final List<SubjectProgress> subjects;

  const StudentDetailScreen({
    super.key,
    required this.name,
    required this.grade,
    required this.todayHours,
    required this.weekHours,
    required this.totalHours,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back button
        title: const Text("Homeschooling"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _studentHeader(),
            const SizedBox(height: 16),
            _learningStats(),
            const SizedBox(height: 16),
            const Text(
              "My Subjects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return _subjectCard(subjects[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _studentHeader() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 30,
              child: Text(
                name[0],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  grade,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _learningStats() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Learning Stats",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today:  ${todayHours.toStringAsFixed(1)} hours",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "This Week:  ${weekHours.toStringAsFixed(1)} hours",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Total Learning:  ${totalHours.toStringAsFixed(1)} hours",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subjectCard(SubjectProgress subject) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 20,
              child: Text(
                subject.name[0],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Progress: ${subject.progress}%",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: subject.progress / 100,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blueAccent,
                    minHeight: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "${subject.hours}h",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectProgress {
  final String name;
  final int progress;
  final double hours;

  SubjectProgress({
    required this.name,
    required this.progress,
    required this.hours,
  });
}
