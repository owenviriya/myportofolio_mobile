# MyPortofolio Mobile

[![CI](https://github.com/owenviriya/myportofolio_mobile/actions/workflows/main.yaml/badge.svg?branch=main)](https://github.com/owenviriya/myportofolio_mobile/actions/workflows/main.yaml)

**Nama:** Owen Viriya Chandra  
**NPM:** 2506539196  
**Kelas:** PBP B  

## Deskripsi

MyPortofolio Mobile adalah aplikasi portofolio pribadi yang dibuat menggunakan Flutter.
Aplikasi ini menampilkan identitas pemilik serta daftar dan detail proyek dan pengalaman.
Pengunjung dapat membaca data tersebut secara publik. Untuk menambahkan proyek atau pengalaman,
pengguna harus login; aplikasi mengirim data ke Django REST Framework menggunakan token.

## Menjalankan Secara Lokal

Jalankan backend Django di terminal pertama:

~~~powershell
git clone https://github.com/owenviriya/myportofolio.git
cd myportofolio
python -m venv env
.\env\Scripts\Activate.ps1
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
~~~

Jalankan aplikasi Flutter di terminal kedua:

~~~powershell
git clone https://github.com/owenviriya/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
~~~

Untuk Android emulator, jalankan `flutter run` tanpa `--dart-define`; URL default aplikasi
adalah `http://10.0.2.2:8000`, alamat backend komputer host dari dalam emulator. Untuk memakai
backend yang sudah di-deploy dari Chrome, gunakan:

~~~powershell
flutter run -d chrome --dart-define=API_BASE_URL=https://owen-viriya-myportofolio.pws.cs.ui.ac.id
~~~

### Backend Django dan API

- Repositori backend: [owenviriya/myportofolio](https://github.com/owenviriya/myportofolio)
- Endpoint Experience (GET publik):
  [https://owen-viriya-myportofolio.pws.cs.ui.ac.id/api/v1/experiences/](https://owen-viriya-myportofolio.pws.cs.ui.ac.id/api/v1/experiences/)
- Endpoint Projects (GET publik):
  [https://owen-viriya-myportofolio.pws.cs.ui.ac.id/api/v1/projects/](https://owen-viriya-myportofolio.pws.cs.ui.ac.id/api/v1/projects/)

Untuk menambahkan proyek atau pengalaman, login dengan akun superuser Django karena permission
backend membatasi pembuatan entri kepada pemilik portofolio. Flutter mengirim token akun tersebut
melalui header API.

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

### Tugas 8

1. Perbedaan Navigator.push(), pushReplacement(), dan pop()

`Navigator.push()` menambahkan halaman baru di atas halaman saat ini. Pada aplikasi ini,
kartu Tambah Proyek dan Tambah Experience memakai `push()` untuk membuka formulir. Tombol
kembali perangkat atau browser menjalankan pop pada halaman formulir sehingga pengguna
kembali ke halaman sebelumnya. `Navigator.pushReplacement()` mengganti halaman teratas
dengan halaman baru, sehingga halaman lama tidak lagi menjadi tujuan tombol kembali. Opsi
Home pada drawer menggunakan `pushReplacement()` untuk membuka halaman utama. `Navigator.pop()`
menghapus halaman atau dialog teratas; tombol OK pada dialog ringkasan memakainya untuk
menutup dialog.

2. Peran Scaffold, AppBar, dan Drawer

`Scaffold` menyediakan kerangka halaman yang berisi `AppBar`, konten, dan drawer. Struktur
ini digunakan di halaman utama maupun halaman formulir agar navigasi tetap konsisten. Drawer
yang sama dipakai pada kedua halaman dan menyediakan pilihan Home, Add Project, dan Add
Experience. Warna indigo digunakan pada tema aplikasi dan AppBar formulir agar tampilannya
selaras dengan halaman utama.

3. Alasan pemilihan tata letak formulir

Form disusun dalam `Column` di dalam `SingleChildScrollView`, sehingga field ditampilkan
berurutan dan konten dapat digulir saat tinggi layar terbatas atau papan ketik terbuka.
Setiap field dibungkus `Padding` untuk memberi jarak dan memudahkan tiap input dibaca.
Tombol Simpan berada setelah field dalam area yang sama sehingga dapat dijangkau dengan
menggulir formulir.

4. Peran GlobalKey<FormState>, validator, dan validate()

`GlobalKey<FormState>` memberi akses ke state Form. Setiap `validator` memeriksa nilai pada
field terkait, lalu `validate()` menjalankan seluruh validator ketika tombol Simpan ditekan.
Dialog ringkasan hanya ditampilkan jika semua input wajib lolos validasi. Contohnya, judul
atau deskripsi yang kosong maupun hanya berisi spasi ditolak; judul juga dibatasi maksimal
255 karakter. URL logo boleh kosong, tetapi jika diisi harus berupa URL HTTP atau HTTPS yang
memiliki host. Keyboard URL hanya mengubah jenis papan ketik yang ditampilkan dan tidak
memastikan teks yang dimasukkan benar-benar URL, sehingga validasi tetap diperlukan.

### Assignment 9

1. Mengapa menggunakan `@JsonSerializable(fieldRename: FieldRename.snake)` dan
`@JsonKey(includeToJson: false)`?

`@JsonSerializable` membuat kode untuk mengubah JSON dari Django menjadi objek Dart dan
mengubah objek Dart kembali menjadi JSON. Opsi `fieldRename: FieldRename.snake`
mencocokkan nama field Django seperti `star_count` dengan nama properti Dart seperti
`starCount`. `@JsonKey(includeToJson: false)` membuat field yang hanya ditetapkan server,
seperti `id` dan informasi star, tidak ikut dikirim ketika Flutter membuat data baru.
Pada model Experience, pendekatan ini membantu mencegah kekeliruan format nama field dan
memastikan `highlights` serta `tags` dikirim sebagai daftar string sesuai serializer DRF.

2. Mengapa Future untuk `FutureBuilder` dibuat di `initState()`, dan mengapa ApiClient
melempar `ApiException`?

Future dibuat di `initState()` agar request GET dibuat satu kali saat layar daftar dibuka.
Jika Future baru dibuat langsung di dalam `build()`, setiap rebuild dapat membuat request
baru dan memulai ulang status loading. ApiClient melempar `ApiException` pada respons HTTP
non-2xx agar kegagalan tidak terlihat seperti daftar kosong. Kode pemanggil dapat membaca
`statusCode`, misalnya menghapus sesi dan meminta login lagi ketika statusnya 401, atau
menampilkan pesan error untuk status lainnya.

3. Apa perbedaan `SessionAuthentication` dan `TokenAuthentication`, dan mengapa aplikasi
mobile menggunakan token?

`SessionAuthentication` mengenali pengguna melalui sesi Django yang umumnya disimpan
sebagai cookie browser. `TokenAuthentication` mengenali pengguna melalui token yang
dikirim pada header `Authorization: Token <key>`. Aplikasi Flutter mobile memakai token
agar dapat mengautentikasi request API tanpa bergantung pada sesi browser. Backend tetap
mengaktifkan session authentication supaya halaman web Django yang menggunakan login
berbasis sesi tetap dapat bekerja.

4. Apa peran job `build` dan `build_apk`, dan mengapa berkas `*.g.dart` diabaikan Git?

Job `build` memakai `very_good_workflows` untuk mengambil dependensi dan menjalankan
`build_runner` melalui langkah setup. Workflow tersebut lalu memeriksa format kode dengan
`dart format`, menjalankan `flutter analyze`, dan menjalankan tes dengan laporan coverage.
Pada konfigurasi proyek ini, berkas `*.g.dart` dikecualikan dari penghitungan coverage dan
batas coverage minimum ditetapkan ke 0; tes tetap dijalankan. Job `build_apk` berjalan
setelah `build` berhasil. Job ini mengambil kode, memasang dependensi, menjalankan
`build_runner`, membuat APK release, lalu mengunggahnya sebagai artefak `app-release-apk`.
Berkas `*.g.dart` diabaikan Git karena dapat dibuat ulang dari model dan anotasinya. CI
membuat berkas tersebut sebelum analisis dan build, jadi berkas hasil generasi tidak perlu
disimpan sebagai perubahan manual di repositori.

## AI Disclosure

Pada Tugas 7, saya menggunakan OpenAI Codex (GPT-6) sebagai tutor dan reviewer untuk
memahami struktur widget Flutter, menyesuaikan menu mobile dengan website Django, serta
menganalisis screenshot overflow. Saya meminta penjelasan secara bertahap dan memberikan
konteks kode atau pesan error. Codex juga membantu merapikan format `main.dart` dan
`menu.dart`. Saya meninjau saran dan menjalankan pemeriksaan sendiri.

Pada Tugas 8, saya menggunakan OpenAI Codex (GPT-6) untuk memahami instruksi tugas dan
mencocokkan field form dengan model Experience Django. Atas permintaan saya, Codex membantu
membuat halaman formulir Experience, validasi input, navigasi dari kartu dan drawer, serta
draf jawaban reflektif README. Saya meninjau perubahan, menjalankan aplikasi di Chrome,
mencoba alur form, dan menjalankan `flutter analyze`; hasilnya No issues found!. Form ini
hanya menampilkan ringkasan di dialog dan belum menyimpan data ke database.

Pada Assignment 9, saya menggunakan OpenAI Codex (GPT-6) untuk memahami tugas secara
bertahap dan mengintegrasikan bagian Experience Flutter dengan backend Django. Codex membantu
membuat model JSON dan layar daftar/detail, menghubungkan ApiClient dan formulir ke endpoint
DRF dengan token, menyesuaikan autentikasi token pada endpoint Experience.
Saya mempelajari perubahan satu per satu dan memeriksa kode dengan
`flutter analyze`, `flutter test`, `python manage.py check`, dan 16 tes API Experience;
semuanya lulus.

Log chat AI:
- Tugas 7: https://chatgpt.com/s/cx_6af53a1201c88191bfe1f5f4fccdf548
- Tugas 8: https://chatgpt.com/s/cx_6b02833e64588191a1e2c63240af1852
- Tugas 9: https://chatgpt.com/s/cx_6b06b0a3592881918d20030295ce4d75