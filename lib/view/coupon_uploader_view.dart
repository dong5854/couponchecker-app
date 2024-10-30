import 'package:couponchecker/data/coupon_repository.dart';
import 'package:couponchecker/data/firebase_uploader.dart';
import 'package:couponchecker/model/coupon.dart';
import 'package:couponchecker/model/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CouponUploaderView extends StatelessWidget {
  final FirebaseUploader firebaseUploader;
  final CouponRepository couponRepository;
  const CouponUploaderView({required this.firebaseUploader, required this.couponRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('쿠폰 업로드'),
      ),
      body: CouponUploader(firebaseUploader: firebaseUploader, couponRepository: couponRepository),
    );
  }
}

class CouponUploader extends StatefulWidget {
  final FirebaseUploader firebaseUploader;
  final CouponRepository couponRepository;

  const CouponUploader({required this.firebaseUploader, required this.couponRepository, super.key});

  @override
  State<CouponUploader> createState() => _CouponUploaderState();
}

class _CouponUploaderState extends State<CouponUploader> {
  DateTime _selectedDate = DateTime.now();
  late TextEditingController _couponNameController;
  File? _selectedImage;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _couponNameController = TextEditingController();
  }

  @override
  void dispose() {
    _couponNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    } else {
      setState(() {
        _selectedImage = null;
      });
    }
  }

  void _uploadCoupon() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미지를 선택하세요.'),
          duration: Duration(milliseconds: 300)
        ));
      return; 
    }
    
    setState(() {
      _isLoading = true;
    });

    final String couponName = _couponNameController.text;
    final uploadFile = UploadFile(file: _selectedImage!, name: couponName, expireDate: _selectedDate);
    final imageUrl = await widget.firebaseUploader.uploadFile(uploadFile);
    await widget.couponRepository.writeCoupon(
      Coupon(
        name: uploadFile.name, 
        imageUrl: imageUrl, 
        expireAt: uploadFile.expireDate.toIso8601String(), 
        used: false
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$couponName 쿠폰이 성공적으로 업로드되었습니다.'),
          duration: Duration(milliseconds: 500)
          ),
      );
    }

    setState(() {
      _isLoading = false;
    });

    print('Uploading coupon: $couponName, Expiry: ${_selectedDate.toIso8601String()}, Image: ${_selectedImage?.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: _selectImage,
            child: const Text('이미지 선택'),
          ),
          const SizedBox(height: 8),
          _selectedImage != null
              ? Image.file(_selectedImage!, height: 100)
              : Text('선택된 이미지 없음', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 24),
          TextField(
            controller: _couponNameController,
            decoration: const InputDecoration(
              labelText: '쿠폰명',
              hintText: '쿠폰명을 입력하세요.',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '쿠폰 만료일',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDate)),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _isLoading ? null : _uploadCoupon,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: _isLoading 
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('업로드'),
          ),
        ],
      ),
    );
  }
}
