import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> articles = [
      {
        'title': 'Cara Merawat Kura-kura Air',
        'category': 'Reptil & Amfibi',
        'desc': 'Pastikan akuarium memiliki lampu UVB dan area darat untuk berjemur agar cangkang tetap sehat.',
        'readTime': '3 min read',
      },
      {
        'title': 'Menjaga Kebersihan Bulu Kucing',
        'category': 'Kucing',
        'desc': 'Sisir bulu kucing secara rutin minimal seminggu sekali untuk menghindari rambut mati yang kusut.',
        'readTime': '5 min read',
      },
      {
        'title': 'Tips Melatih Anjing Peliharaan Dasar',
        'category': 'Anjing',
        'desc': 'Gunakan metode positive reinforcement dengan treat makanan agar anjing lebih cepat tanggap.',
        'readTime': '4 min read',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Tips & Artikel Pet', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final art = articles[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              art['category']!,
                              style: const TextStyle(color: Colors.blueAccent, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(art['readTime']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        art['title']!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        art['desc']!,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}