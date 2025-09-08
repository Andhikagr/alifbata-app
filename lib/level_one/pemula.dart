import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:takhmin_sura/homepage.dart';
import 'package:takhmin_sura/level_one/data.dart';

class Pemula extends StatefulWidget {
  const Pemula({super.key});

  @override
  State<Pemula> createState() => _PemulaState();
}

class _PemulaState extends State<Pemula> {
  bool isPlay = true;
  int? selectedIndex;
  int currentPage = 0;
  bool isFinish = false;
  List shuffled = [];
  bool isAnswer = false;
  String? audioPath;

  Icon currentIcon = Icon(Icons.headphones, size: 30, color: Colors.blue);
  final AudioPlayer _audioPlayer = AudioPlayer();

  void toggleThumb() async {
    final audio = dataPemula[currentPage]["audio"];

    await _audioPlayer.stop();

    await _audioPlayer.play(AssetSource(audio), volume: 1.0);
  }

  void nextPage() {
    setState(() {
      if (currentPage < dataPemula.length - 1) {
        currentPage++;
        isAnswer = false;
        selectedIndex = null;
        loadPage();
        isFinish = currentPage == dataPemula.length - 1;
      } else {
        Get.offAll(() => Homepage());
      }
    });
  }

  void loadPage() {
    setState(() {
      shuffled = List.generate(dataPemula.length, (index) => index);
      shuffled.shuffle();
      selectedIndex = null;
    });
  }

  String cekAnswer() {
    final selectedLabel = dataPemula[shuffled[selectedIndex!]]["label"];
    final correctLabel = dataPemula[currentPage]["label"];
    return selectedLabel == correctLabel ? "صحيح" : "خطأ";
  }

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 530,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Image.asset('assets/bg-7.jpg', fit: BoxFit.cover),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () => Get.back(),
                              child: Icon(Icons.arrow_back_ios_new_outlined),
                            ),
                          ),
                          SizedBox(width: 9),
                          Expanded(
                            flex: 5,
                            child: LinearPercentIndicator(
                              barRadius: Radius.circular(20),
                              lineHeight: 25,
                              percent: (currentPage + 1) / dataPemula.length,
                              progressColor: Colors.amber,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Apa yang ada di gambar ini?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Colors.white,
                        ),
                        child: Image.asset(dataPemula[currentPage]["image"]),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 73,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: const Color.fromARGB(255, 255, 235, 218),
                        ),
                        child: Center(
                          child: ClipOval(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: toggleThumb,
                                child: Ink(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                  child: currentIcon,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataPemula.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 3.5,
                ),
                itemBuilder: (context, index) {
                  final realIndex = shuffled[index];
                  final label = dataPemula[realIndex]["label"];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!isAnswer) {
                          selectedIndex = index;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        color: isSelected ? Colors.blue : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (selectedIndex != null) {
                        setState(() {
                          isAnswer = true;
                        });
                      }
                      final result = cekAnswer();
                      String audioPath = result == "صحيح"
                          ? "sound/benar.mp3"
                          : "sound/salah.mp3";
                      _audioPlayer.stop();
                      _audioPlayer.play(AssetSource(audioPath), volume: 1.0);

                      String iconPath = result == "صحيح"
                          ? "assets/like.png"
                          : "assets/no.png";
                      if (!mounted) return;
                      showDialog(
                        context: context,

                        builder: (context) {
                          return AlertDialog(
                            icon: Image.asset(
                              iconPath,
                              width: 100,
                              height: 100,
                            ),
                            title: Text(
                              result,
                              style: TextStyle(
                                color: result == "صحيح"
                                    ? Colors.blue
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          );
                        },
                      ).then((_) {
                        setState(() {
                          isAnswer = false;
                        });
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Cek",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: InkWell(
                    onTap: nextPage,
                    child: Ink(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          isFinish ? "Selesai" : "Selanjutnya",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
