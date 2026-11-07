import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[50],
     body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, Igihozo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('Help make our campus safer', style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('Report issues and track their resolution', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Badge(label: Text('1'), child: Icon(Icons.notifications)),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
                    ),
                  ],
                    
                ),
              ],
            ),
            const SizedBox(height: 20),
          // Banner Container
              Container(
                height: 205,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF9333EA)]),
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('asset/campus.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('See an issue\non campus?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    const Text('Report it and help improve our learning environment.', style: TextStyle(fontSize: 12, color: Colors.white70)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(backgroundColor: Color(0xFF7C3AED), radius: 10, child: Icon(Icons.add, color: Colors.white, size: 16)),
                              SizedBox(width: 10),
                              Text('Report an Issue', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7C3AED))),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF7C3AED)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Report Summary Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Report Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: Color(0xFF7C3AED)))),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SummaryCard(count: '12', label: 'My Reports', icon: Icons.description, color: Colors.purple),
                  _SummaryCard(count: '5', label: 'In Progress', icon: Icons.access_time, color: Colors.blue),
                  _SummaryCard(count: '4', label: 'Resolved', icon: Icons.check_circle, color: Colors.green),
                  _SummaryCard(count: '3', label: 'Submitted', icon: Icons.error, color: Colors.red),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Reports Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Reports', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: Color(0xFF7C3AED)))),
                ],
              ),
              const SizedBox(height: 8),
              const _ReportTile(title: 'Water shortage', location: 'Student Residence', time: '2 hours ago', status: 'Submitted', statusColor: Colors.amber),
              const _ReportTile(title: 'Broken classroom projector', location: 'Block B', time: '1 day ago', status: 'In Progress', statusColor: Colors.blue),
              const _ReportTile(title: 'Overflowing bin', location: 'Cafeteria', time: '3 days ago', status: 'Resolved', statusColor: Colors.green),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 36, color: Color(0xFF7C3AED)), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// Reusable Summary Card Widget
class _SummaryCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final Color color;

  const _SummaryCard({required this.count, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// Reusable Recent Report Tile Widget
class _ReportTile extends StatelessWidget {
  final String title;
  final String location;
  final String time;
  final String status;
  final Color statusColor;

  const _ReportTile({required this.title, required this.location, required this.time, required this.status, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.image, color: Colors.grey)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 10, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
