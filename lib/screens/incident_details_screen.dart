import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentDetailsScreen extends StatelessWidget {
  final DocumentSnapshot report;

  const IncidentDetailsScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final data = report.data() as Map<String, dynamic>;
    final title = data['title'] ?? 'No Title';
    final location = data['location'] ?? 'Unknown location';
    final description = data['description'] ?? 'No description provided.';
    final status = data['status'] ?? 'Submitted';
    final userEmail = data['userEmail'] ?? 'Student';
    final base64Image = data['imageBase64'] ?? '';
    
    // Format timestamp if available
    Timestamp? timestamp = data['createdAt'];
    String timeFormatted = timestamp != null 
        ? timestamp.toDate().toString().substring(0, 16) 
        : 'Just now';

    Color statusColor = status == 'Resolved' 
        ? Colors.green 
        : status == 'In Progress' ? Colors.blue : Colors.amber;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Incident Details', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: base64Image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(base64Decode(base64Image), fit: BoxFit.cover),
                              )
                            : const Icon(Icons.image, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 2),
                            Text(location, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text('Submitted on $timeFormatted', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text('Reported by $userEmail', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(description, style: const TextStyle(color: Colors.black87, height: 1.4)),
            ),
            const SizedBox(height: 20),

            // Attached Photo Section (if any)
            if (base64Image.isNotEmpty) ...[
              const Text('Attached Photo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(base64Decode(base64Image), height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
            ],
          ],
        ),
      ),
    );
  }
}