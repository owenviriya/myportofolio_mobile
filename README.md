# MyPortofolio Mobile

**Nama:** Owen Viriya Chandra  
**NPM:** 2506539196  
**Kelas:** PBP B  

## Deskripsi

MyPortofolio Mobile adalah aplikasi portofolio pribadi yang dibuat menggunakan Flutter.
Aplikasi ini menampilkan identitas pemilik dan kartu menu untuk Proyek, Skills, Experience,
Education, serta Logout. Saat kartu ditekan, aplikasi menampilkan SnackBar sesuai nama aksi.

## Menjalankan Secara Lokal

~~~bash
git clone https://github.com/owenviriya/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
flutter run -d chrome
~~~

Jalankan `flutter analyze` dari root proyek untuk memeriksa kode. Hasil pemeriksaan terakhir
menunjukkan No issues found!.

### Tugas 7

1. Widget tree dan hubungan parent-child

Widget tree adalah susunan widget bertingkat yang membentuk antarmuka Flutter. Widget induk
mengatur tata letak atau perilaku anaknya; misalnya, Row menyusun anak secara horizontal,
sedangkan Column menyusunnya secara vertikal.

Pada aplikasi ini, MyApp membangun MaterialApp dan menampilkan MyHomePage. Scaffold menjadi
induk bagi AppBar dan body. Row menata tiga InfoCard, sedangkan GridView.count menampilkan
ItemCard dari daftar ItemHomepage. Susunan tersebut membuat bagian antarmuka dapat dibagi
menjadi komponen yang lebih kecil.

2. Widget yang digunakan dalam proyek

MaterialApp, Scaffold, dan AppBar membentuk konfigurasi serta kerangka halaman. Padding,
SingleChildScrollView, Column, Row, Center, SizedBox, dan GridView.count mengatur posisi,
jarak, dan scroll konten. Text dan Icon menampilkan teks serta ikon; Card, Container,
Material, dan InkWell membentuk kartu dan menangani interaksi.

MyApp, MyHomePage, InfoCard, dan ItemCard adalah widget khusus. SnackBar menampilkan pesan
setelah kartu ditekan. ItemHomepage adalah model data yang menyimpan nama, ikon, dan warna,
bukan widget. MediaQuery, Theme, dan ScaffoldMessenger merupakan API pendukung untuk
membaca ukuran layar, mengambil tema, dan menampilkan SnackBar.

3. Fungsi widget MaterialApp

MaterialApp menjadi root aplikasi bergaya Material dan menyediakan konfigurasi seperti tema,
navigasi, serta halaman awal. Pada proyek ini, MaterialApp menerapkan ThemeData Material 3
dan menetapkan MyHomePage sebagai halaman yang pertama ditampilkan. Tema tersebut dapat
digunakan oleh widget turunannya, seperti AppBar.

4. Perbedaan StatelessWidget dan StatefulWidget

StatelessWidget digunakan untuk tampilan yang tidak menyimpan state yang berubah dari dalam
widget. StatefulWidget digunakan ketika UI perlu menyimpan perubahan, seperti input,
pilihan pengguna, atau status pemuatan data.

MyHomePage dan kartu-kartunya memakai StatelessWidget karena identitas serta daftar aksi
ditampilkan dari data yang sudah tersedia. Ketukan kartu hanya meminta ScaffoldMessenger
menampilkan SnackBar, sehingga tidak memerlukan state lokal. Jika nanti halaman mengelola
input atau data yang berubah, StatefulWidget dapat digunakan.

5. Fungsi BuildContext

BuildContext menunjukkan posisi widget di dalam widget tree dan membantu widget menemukan
konfigurasi atau layanan dari leluhurnya. Contohnya, Theme.of(context) mengambil tema,
MediaQuery.of(context) membaca ukuran layar, dan ScaffoldMessenger.of(context) menemukan
layanan untuk menampilkan SnackBar.

BuildContext diterima oleh method build dan bukan tempat menyimpan data aplikasi. Konteks
yang benar juga penting agar widget berada di bawah layanan yang ingin diakses, seperti
ScaffoldMessenger.

6. Hot reload dan hot restart

Hot reload menerapkan perubahan kode dan membangun ulang UI tanpa menghapus state aplikasi
yang sedang berjalan. Hot restart memulai ulang aplikasi dari awal sehingga state sementara
direset. Hot reload cocok untuk perubahan tampilan; hot restart diperlukan ketika inisialisasi
seperti main() perlu dijalankan ulang.

Perubahan kode native atau konfigurasi platform dapat memerlukan full restart/build.

## AI Disclosure

Saya menggunakan OpenAI Codex (GPT-6) sebagai tutor dan reviewer. Saya meminta penjelasan
secara bertahap, memberikan konteks kode atau pesan error, lalu menerapkan dan memeriksa
perubahan sendiri. AI membantu menjelaskan struktur widget, memberi saran untuk menyesuaikan
menu dengan website Django, dan menganalisis screenshot overflow. Atas permintaan saya,
Codex juga merapikan format `main.dart` dan `menu.dart`. Saya menjalankan `flutter analyze`
sendiri dan memperoleh hasil No issues found!.

Log chat AI:
- Tugas 7: https://chatgpt.com/s/cx_6af53a1201c88191bfe1f5f4fccdf548

