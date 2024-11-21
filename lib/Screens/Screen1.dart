import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Screen1 extends StatefulWidget {
  final int idx;
  const Screen1({super.key, required this.idx});

  @override
  State<Screen1> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Screen1> {
  PDFDoc? _pdfDoc;
  String _text = "Document Text Will Appear Here";
  bool _isLoading = false;
  bool _isSpeaking = false;
  List<String> _chunks = [];
  int _currentChunkIndex = 0;

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    // Configure TTS settings
    flutterTts.setCompletionHandler(_onTtsComplete);
    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
           appBar: AppBar(title: Text("PDF & Doc",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Theme.of(context).colorScheme.onPrimary),),backgroundColor: Theme.of(context).colorScheme.primary,elevation: 5.0,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Hero(
          tag: widget.idx,
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height*0.7,
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                  child:_isSpeaking? SingleChildScrollView(
                    child: _buildHighlightedText(),
                  ):
                  Container(child: Center(child: Text(_text)),),
                ),
              ),
              GestureDetector(
                onTap: pickPDFText,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration:  BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: const Text("Select Document",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightedText() {
    return RichText(
      text: TextSpan(
        children: _chunks.asMap().entries.map((entry) {
          int index = entry.key;
          String chunk = entry.value;
          return TextSpan(
            text: '$chunk ',
            style: TextStyle(
              backgroundColor: index == _currentChunkIndex
                  ? Colors.yellow
                  : Colors.transparent,
              color: Colors.black,
            ),
          );
        }).toList(),
      ),
    );
  }

  void showLoading(bool showloading) {
    if (showloading) {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      }
    } else {
      if (_isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> pickPDFText() async {
    showLoading(true);
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf','txt']);
      if (result != null && result.files.single.path != null) {
        String? path = result.files.single.path;
        String? extension = result.files.single.extension;
        String mytext ="";
        if (extension == 'pdf') {
          _pdfDoc = await PDFDoc.fromPath(path!);
          mytext = await _pdfDoc!.text;
        } else if (extension == 'txt') {
          mytext = await File(path!).readAsString();
        }else {
          print(
              "Invalid File Uploaded, Please Choose Either PDF Or Text Files ${result.paths.first}");
          Fluttertoast.showToast(
            msg: "Please Choose Either PDF Or Text Files",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        setState(() {
          _text = mytext;
          _createChunks(mytext);
        });
        _startSpeaking();

      }
    } catch (e) {
      print("Exception While Reading File $e");
      Fluttertoast.showToast(
        msg: "Please Choose Either PDF Or Text Files",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      showLoading(false);
    }
  }

  void _createChunks(String text) {
    const int chunkSize = 50; // Number of words per chunk
    List<String> words = text.split(RegExp(r'\s+'));
    _chunks = [];

    for (int i = 0; i < words.length; i += chunkSize) {
      _chunks.add(
        words.sublist(
          i,
          (i + chunkSize < words.length) ? i + chunkSize : words.length,
        ).join(' '),
      );
    }

    _currentChunkIndex = 0;
  }

  void _startSpeaking() async {
    if (_chunks.isNotEmpty) {
      setState(() {
        _isSpeaking = true;
      });
      await _speakCurrentChunk();
    }
  }

  Future<void> _speakCurrentChunk() async {
    if (_currentChunkIndex < _chunks.length) {
      String chunk = _chunks[_currentChunkIndex];
      await flutterTts.speak(chunk);
    } else {
      setState(() {
        _isSpeaking = false;
      });
    }
  }

  void _onTtsComplete() {
    if (_isSpeaking) {
      setState(() {
        _currentChunkIndex++;
      });
      if (_currentChunkIndex < _chunks.length) {
        _speakCurrentChunk();
      } else {
        setState(() {
          _isSpeaking = false;
        });
      }
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
