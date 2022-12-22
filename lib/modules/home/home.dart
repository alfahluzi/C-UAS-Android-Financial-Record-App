import 'package:flutter/material.dart';
import 'package:uas_mobile_catatan_keuangan/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static page(BuildContext context) => const HomePage();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                color: ColorTheme.HIJAU,
                width: double.infinity,
                height: double.infinity,
                child: Text(
                  'Halo Aldi',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.only(top: 65),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pengeluaran bulan ini"),
                      const SizedBox(height: 10),
                      Text(
                        "Rp20.000",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorTheme.ABU_SEMU,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pemasukan",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    "Rp12.000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: ColorTheme.BIRU),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Transaksi",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    "-Rp12.000",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text("Transaksi terbaru bulan ini"),
                      const SizedBox(height: 5),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return ListCatatan();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

enum JenisCatatan { pengeluaran, pemasukan }

class _BottomNavigationState extends State<BottomNavigation> {
  DateTime nowDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: nowDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != nowDate) {
      setState(
        () {
          nowDate = picked;
        },
      );
    }
  }

  JenisCatatan? jenisCatatan = JenisCatatan.pemasukan;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[300]),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home),
                    Text('Beranda'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  CatatanModal(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text('Tambah Catatan'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.domain_verification),
                    Text('Laporan'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> CatatanModal(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: ColorTheme.ABU_SEMU,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 600,
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.cancel_outlined),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Tambah Catatan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixText: 'Rp',
                  hintText: '0',
                ),
                autofocus: true,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Tulis keterangan Singkat',
                ),
                autofocus: true,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Tulis deskripsi',
                ),
                autofocus: true,
              ),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black),
                  )),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      SizedBox(width: 10),
                      Text(
                        nowDate.toString().substring(0, 10),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          jenisCatatan = JenisCatatan.pemasukan;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            jenisCatatan == JenisCatatan.pemasukan
                                ? Icon(Icons.check)
                                : Container(),
                            const Text('Pemasukan'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          jenisCatatan = JenisCatatan.pengeluaran;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            jenisCatatan == JenisCatatan.pengeluaran
                                ? Icon(Icons.check)
                                : Container(),
                            const Text('Pengeluaran'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    color: ColorTheme.HIJAU,
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ListCatatan extends StatelessWidget {
  const ListCatatan({
    super.key,
    Future<dynamic>? CatatanModal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ColorTheme.ABU_SEMU, borderRadius: BorderRadius.circular(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: const Text(
                      "Beli Makan di gopud asdas dasdasd asd as dasd ",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Rp10.000.000",
                    style: TextStyle(color: ColorTheme.HIJAU),
                  ),
                )
              ],
            ),
            const Text(
              "Beli Makan di gopud bareng arip ian make uang ian belinya ayam",
              style: TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "13 Desember",
              style: TextStyle(color: Colors.grey[500]),
            )
          ],
        ),
      ),
    );
  }
}
