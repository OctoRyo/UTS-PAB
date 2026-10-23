import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allServices = [
    {
      'title': 'Grooming',
      'icon': Icons.content_cut,
      'color': Colors.orange,
      'desc': 'Mandi, potong kuku, & bulu',
    },
    {
      'title': 'Vaksinasi',
      'icon': Icons.local_hospital,
      'color': Colors.redAccent,
      'desc': 'Vaksinasi rutin & vitamin',
    },
    {
      'title': 'Pet Hotel',
      'icon': Icons.hotel,
      'color': Colors.purple,
      'desc': 'Penitipan hewan nyaman',
    },
    {
      'title': 'Konsultasi Dokter',
      'icon': Icons.medical_services,
      'color': Colors.green,
      'desc': 'Pemeriksaan dokter hewan',
    },
  ];

  List<Map<String, dynamic>> _filteredServices = [];

  @override
  void initState() {
    super.initState();
    _filteredServices = _allServices;
    _searchController.addListener(_filterServices);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterServices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredServices = _allServices;
      } else {
        _filteredServices = _allServices.where((service) {
          final title = service['title'].toString().toLowerCase();
          final desc = service['desc'].toString().toLowerCase();
          return title.contains(query) || desc.contains(query);
        }).toList();
      }
    });
  }

  void _showBookingDialog(String serviceName) {
    final nameController = TextEditingController();
    final petController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.pets, color: Colors.blueAccent),
              const SizedBox(width: 8),
              Text('Booking $serviceName'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Pemilik',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: petController,
                decoration: InputDecoration(
                  labelText: 'Nama & Jenis Hewan',
                  prefixIcon: const Icon(Icons.pets_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty && petController.text.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Berhasil Booking $serviceName untuk ${petController.text}!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap isi semua kolom!'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Pemberitahuan'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.local_offer, color: Colors.amber),
                title: Text('Promo Member'),
                subtitle: Text('Gunakan kode PAWFIRST diskon 20%'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Sistem Siap'),
                subtitle: Text('Selamat datang di PawPal Care Center!'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'PawPal Care Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: _showNotificationDialog,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              accountName: Text(
                'PawPal Owner',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text('user@pawpalcare.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.pets, size: 40, color: Colors.blueAccent),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Jadwal Reservasi'),
              onTap: () {
                Navigator.pop(context);
                _showBookingDialog('Reservasi Umum');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text('Riwayat Perawatan'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text('Riwayat Perawatan'),
                    content: const Text('Belum ada riwayat transaksi.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Keluar', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Anda berhasil keluar.')),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari "grooming", "dokter", "vaksin"...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Halo, PawParents! 👋',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Berikan perawatan terbaik untuk hewan kesayangan Anda hari ini.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _showBookingDialog('Layanan Umum'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('Booking Sekarang'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: Lottie.asset(
                            'assets/lottie/Cute Tiger.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Layanan Utama',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (_searchController.text.isNotEmpty)
                      Text(
                        '${_filteredServices.length} ditemukan',
                        style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _filteredServices.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text(
                            'Layanan tidak ditemukan.',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: _filteredServices.length,
                        itemBuilder: (context, index) {
                          final service = _filteredServices[index];
                          return InkWell(
                            onTap: () => _showBookingDialog(service['title']),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: (service['color'] as Color).withOpacity(0.15),
                                    child: Icon(service['icon'] as IconData, color: service['color'] as Color, size: 24),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    service['title'],
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    service['desc'],
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.stars_rounded, color: Colors.amber, size: 36),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Diskon Member 20%',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Gunakan kode "PAWFIRST" untuk promo grooming pertama.',
                              style: TextStyle(fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}