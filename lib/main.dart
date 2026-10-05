import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// MODEL MAHASISWA
// =====================================================

class Mahasiswa {
  final String nama;
  final double tugas;
  final double uts;
  final double uas;

  Mahasiswa({
    required this.nama,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  double get nilaiAkhir {
    return (tugas * 0.30) +
        (uts * 0.30) +
        (uas * 0.40);
  }

  String get grade {
    if (nilaiAkhir >= 85) {
      return 'A';
    } else if (nilaiAkhir >= 75) {
      return 'B';
    } else if (nilaiAkhir >= 65) {
      return 'C';
    } else if (nilaiAkhir >= 50) {
      return 'D';
    } else {
      return 'E';
    }
  }

  String get status {
    return nilaiAkhir >= 60
        ? 'Lulus'
        : 'Tidak Lulus';
  }
}

// =====================================================
// APLIKASI
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Nilai Mahasiswa',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
            const Color(0xFFFFF5F8),

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        inputDecorationTheme:
            InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
            borderSide:
                const BorderSide(
              color: Colors.pink,
              width: 2,
            ),
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ===================================================
  // 10 DATA MAHASISWA
  // ===================================================

  final List<Mahasiswa> daftarMahasiswa = [
    Mahasiswa(
      nama: 'Gandis Asmara',
      tugas: 85,
      uts: 80,
      uas: 90,
    ),
    Mahasiswa(
      nama: 'Naillah intan',
      tugas: 80,
      uts: 85,
      uas: 88,
    ),
    Mahasiswa(
      nama: 'Gevira',
      tugas: 90,
      uts: 88,
      uas: 95,
    ),
    Mahasiswa(
      nama: 'Haya agniya',
      tugas: 75,
      uts: 78,
      uas: 80,
    ),
    Mahasiswa(
      nama: 'Sebriana',
      tugas: 70,
      uts: 75,
      uas: 78,
    ),
    Mahasiswa(
      nama: 'Rosmeri',
      tugas: 65,
      uts: 70,
      uas: 72,
    ),
    Mahasiswa(
      nama: 'Zennisa',
      tugas: 88,
      uts: 90,
      uas: 85,
    ),
    Mahasiswa(
      nama: 'Mella',
      tugas: 82,
      uts: 80,
      uas: 85,
    ),
    Mahasiswa(
      nama: 'Nazwa',
      tugas: 95,
      uts: 92,
      uas: 90,
    ),
    Mahasiswa(
      nama: 'kalilah',
      tugas: 60,
      uts: 65,
      uas: 70,
    ),
  ];

  // ===================================================
  // CONTROLLER
  // ===================================================

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController tugasController =
      TextEditingController();

  final TextEditingController utsController =
      TextEditingController();

  final TextEditingController uasController =
      TextEditingController();

  // ===================================================
  // TAMBAH MAHASISWA
  // ===================================================

  void tambahMahasiswa() {
    final nama =
        namaController.text.trim();

    final tugas = double.tryParse(
      tugasController.text.trim(),
    );

    final uts = double.tryParse(
      utsController.text.trim(),
    );

    final uas = double.tryParse(
      uasController.text.trim(),
    );

    if (nama.isEmpty) {
      pesan(
        'Nama mahasiswa harus diisi!',
        Colors.red,
      );
      return;
    }

    if (tugas == null ||
        uts == null ||
        uas == null) {
      pesan(
        'Nilai harus berupa angka!',
        Colors.red,
      );
      return;
    }

    if (tugas < 0 ||
        tugas > 100 ||
        uts < 0 ||
        uts > 100 ||
        uas < 0 ||
        uas > 100) {
      pesan(
        'Nilai harus antara 0 sampai 100!',
        Colors.red,
      );
      return;
    }

    setState(() {
      daftarMahasiswa.add(
        Mahasiswa(
          nama: nama,
          tugas: tugas,
          uts: uts,
          uas: uas,
        ),
      );
    });

    namaController.clear();
    tugasController.clear();
    utsController.clear();
    uasController.clear();

    pesan(
      'Mahasiswa berhasil ditambahkan!',
      Colors.green,
    );
  }

  // ===================================================
  // PESAN
  // ===================================================

  void pesan(
    String text,
    Color color,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }

  // ===================================================
  // WARNA GRADE
  // ===================================================

  Color warnaGrade(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.deepOrange;
      default:
        return Colors.red;
    }
  }

  // ===================================================
  // WARNA STATUS
  // ===================================================

  Color warnaStatus(String status) {
    return status == 'Lulus'
        ? Colors.green
        : Colors.red;
  }

  // ===================================================
  // DISPOSE
  // ===================================================

  @override
  void dispose() {
    namaController.dispose();
    tugasController.dispose();
    utsController.dispose();
    uasController.dispose();
    super.dispose();
  }

  // ===================================================
  // BUILD
  // ===================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator Nilai Mahasiswa',
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 15,
            ),
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            // =========================================
            // HEADER
            // =========================================

            Container(
              padding:
                  const EdgeInsets.all(22),

              decoration:
                  BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    Colors.pink,
                    Color(0xFFFF80AB),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.pink.withOpacity(
                      0.25,
                    ),
                    blurRadius: 10,
                    offset:
                        const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 55,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'KALKULATOR NILAI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const Text(
                    'MAHASISWA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    '${daftarMahasiswa.length} Mahasiswa',
                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // =========================================
            // FORM
            // =========================================

            const Text(
              'Tambah Data Mahasiswa',
              style: TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.bold,
                color:
                    Color(0xFFC2185B),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
                  namaController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Nama Mahasiswa',
                hintText:
                    'Masukkan nama mahasiswa',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.pink,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            TextField(
              controller:
                  tugasController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText:
                    'Nilai Tugas',
                hintText: '0 - 100',
                prefixIcon: Icon(
                  Icons.assignment,
                  color: Colors.pink,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            TextField(
              controller:
                  utsController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText:
                    'Nilai UTS',
                hintText: '0 - 100',
                prefixIcon: Icon(
                  Icons.edit,
                  color: Colors.pink,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            TextField(
              controller:
                  uasController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText:
                    'Nilai UAS',
                hintText: '0 - 100',
                prefixIcon: Icon(
                  Icons.school,
                  color: Colors.pink,
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            ElevatedButton.icon(
              onPressed:
                  tambahMahasiswa,

              icon:
                  const Icon(Icons.add),

              label: const Text(
                'Tambah Mahasiswa',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // =========================================
            // KETENTUAN
            // =========================================

            Container(
              padding:
                  const EdgeInsets.all(18),

              decoration:
                  BoxDecoration(
                color:
                    const Color(0xFFFFE4EC),

                borderRadius:
                    BorderRadius.circular(15),

                border: Border.all(
                  color:
                      Colors.pink.shade100,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    'Ketentuan Nilai',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFFC2185B),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'Nilai Akhir = '
                    '30% Tugas + '
                    '30% UTS + '
                    '40% UAS',
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    'A = ≥ 85',
                  ),
                  const Text(
                    'B = ≥ 75',
                  ),
                  const Text(
                    'C = ≥ 65',
                  ),
                  const Text(
                    'D = ≥ 50',
                  ),
                  const Text(
                    'E = < 50',
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    'Lulus = ≥ 60',
                  ),
                  const Text(
                    'Tidak Lulus = < 60',
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // =========================================
            // DAFTAR MAHASISWA
            // =========================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Text(
                  'Daftar Mahasiswa',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFFC2185B),
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors.pink,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),

                  child: Text(
                    '${daftarMahasiswa.length} Data',
                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            // =========================================
            // LIST MAHASISWA
            // =========================================

            ListView.builder(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  daftarMahasiswa.length,

              itemBuilder:
                  (context, index) {

                final mahasiswa =
                    daftarMahasiswa[index];

                return Card(
                  margin:
                      const EdgeInsets.only(
                    bottom: 15,
                  ),

                  elevation: 3,

                  color: Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),

                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    child: Column(
                      children: [

                        // NAMA
                        Row(
                          children: [

                            CircleAvatar(
                              backgroundColor:
                                  Colors.pink,

                              child: Text(
                                '${index + 1}',
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: Text(
                                mahasiswa.nama,
                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFF880E4F),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Divider(),

                        barisNilai(
                          'Nilai Tugas',
                          mahasiswa.tugas,
                        ),

                        barisNilai(
                          'Nilai UTS',
                          mahasiswa.uts,
                        ),

                        barisNilai(
                          'Nilai UAS',
                          mahasiswa.uas,
                        ),

                        const Divider(),

                        // NILAI AKHIR
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            const Text(
                              'Nilai Akhir',
                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            Text(
                              mahasiswa.nilaiAkhir
                                  .toStringAsFixed(
                                2,
                              ),

                              style:
                                  const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Colors.pink,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // GRADE
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            const Text(
                              'Grade',
                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 18,
                                vertical: 7,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    warnaGrade(
                                  mahasiswa.grade,
                                ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  20,
                                ),
                              ),

                              child: Text(
                                mahasiswa.grade,

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // STATUS
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            const Text(
                              'Status',
                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            Text(
                              mahasiswa.status,

                              style: TextStyle(
                                color:
                                    warnaStatus(
                                  mahasiswa.status,
                                ),
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),

            // =========================================
            // FOOTER
            // =========================================

            Container(
              padding:
                  const EdgeInsets.all(18),

              decoration:
                  BoxDecoration(
                color:
                    const Color(0xFFFFE4EC),

                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: const Column(
                children: [

                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    'Minimal 10 mahasiswa sudah terpenuhi',
                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFFC2185B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================
  // BARIS NILAI
  // ===================================================

  Widget barisNilai(
    String label,
    double nilai,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 5,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(label),

          Text(
            nilai.toStringAsFixed(2),

            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
