import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Apps'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Membungkus dengan SingleChildScrollView agar bisa digulir
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About this Application',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Aplikasi Dota 2 Heroes adalah aplikasi yang dirancang untuk membantu pemain dan penggemar Dota 2 menemukan informasi mendetail tentang berbagai hero dalam permainan. Dengan menggunakan data dari OpenDota API, aplikasi ini memuat informasi statistik hero dan menampilkan atribut utama, jenis serangan, serta peran yang dimainkan setiap hero. Aplikasi ini berfungsi sebagai panduan komprehensif yang memungkinkan pengguna untuk menjelajahi hero yang ada di Dota 2 dengan lebih mudah dan praktis.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12.0),
              Text(
                'Pada halaman utama, pengguna dapat melihat daftar lengkap hero yang ada dalam Dota 2. Setiap hero dilengkapi dengan detail mendalam, termasuk atribut dasar seperti health, mana, armor, dan berbagai kemampuan dasar lainnya. Pengguna dapat mengetuk setiap hero untuk membuka dialog yang menampilkan statistik tambahan, seperti kecepatan serangan, projectile speed, move speed, dan daya tahan hero tersebut. Ini memungkinkan pengguna untuk mendapatkan gambaran yang jelas mengenai kekuatan dan kelemahan setiap hero.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12.0),
              Text(
                'Aplikasi ini juga menyediakan fitur pencarian dan filter yang memudahkan pengguna dalam menemukan hero yang sesuai dengan kebutuhan mereka. Pengguna dapat menyaring hero berdasarkan atribut utama (strength, agility, intelligence, atau universal), tipe serangan (melee atau ranged), dan peran (carry, support, nuker, dll.). Filter ini dirancang untuk memudahkan pemain dalam menemukan hero yang sesuai dengan strategi atau gaya bermain mereka.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12.0),
              Text(
                'Selain itu, aplikasi Dota 2 Heroes memiliki menu tambahan yang menyediakan akses ke halaman profil pengguna dan informasi tentang aplikasi. Pengguna dapat mengakses halaman profil mereka, sementara di bagian "About Apps", pengguna dapat membaca lebih lanjut mengenai aplikasi, tujuannya, dan manfaatnya bagi komunitas Dota 2. Dengan antarmuka yang sederhana namun efektif, aplikasi ini bertujuan memberikan pengalaman yang menyenangkan dan informatif bagi para penggemar Dota 2 di semua tingkat keterampilan.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12.0),
              Text(
                'Aplikasi ini dibangun menggunakan framework Flutter, yang memungkinkan tampilan antarmuka yang responsif dan mudah diakses. Dengan penggunaan Flutter, aplikasi dapat berjalan di berbagai platform dengan performa yang optimal. Dota 2 Heroes App tidak hanya berguna bagi pemain profesional yang ingin memaksimalkan strategi mereka, tetapi juga bagi para pemula yang ingin mempelajari dasar-dasar hero dalam permainan.',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
