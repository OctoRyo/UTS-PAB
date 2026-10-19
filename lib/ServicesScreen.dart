import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layanan Pet Care')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.cut, color: Colors.blue),
              title: const Text('Pet Grooming'),
              subtitle: const Text('Mandii bersih dan potong bulu rapi.'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingFormScreen(serviceName: 'Pet Grooming'),
                    ),
                  );
                },
                child: const Text('Booking'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.hotel, color: Colors.blue),
              title: const Text('Pet Hotel'),
              subtitle: const Text('Penitipan hewan aman dan nyaman.'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingFormScreen(serviceName: 'Pet Hotel'),
                    ),
                  );
                },
                child: const Text('Booking'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Form dengan Validasi (Wajib)
class BookingFormScreen extends StatefulWidget {
  final String serviceName;
  const BookingFormScreen({super.key, required this.serviceName});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Booking: ${widget.serviceName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pemilik',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pemilik tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form Berhasil Divalidasi & Disubmit!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Kirim Pemesanan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}