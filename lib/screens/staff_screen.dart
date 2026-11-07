import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No incident reports found.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;
              final currentStatus = data['status'] ?? 'Submitted';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(data['description'] ?? 'Incident Report', maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text('Location: ${data['location'] ?? 'N/A'}'),
                  trailing: DropdownButton<String>(
                    value: ['Submitted', 'In Progress', 'Resolved'].contains(currentStatus) 
                        ? currentStatus 
                        : 'Submitted',
                    items: ['Submitted', 'In Progress', 'Resolved']
                        .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                        .toList(),
                    onChanged: (newStatus) {
                      if (newStatus != null) {
                        FirebaseFirestore.instance
                            .collection('reports')
                            .doc(docId)
                            .update({'status': newStatus});
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}