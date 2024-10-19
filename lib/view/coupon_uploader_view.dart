import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponUploaderView extends StatelessWidget {
  const CouponUploaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('쿠폰 업로드'),
      ),
      body: const CouponUploaderBody(),
    );
  }
}

class CouponUploaderBody extends StatefulWidget {
  const CouponUploaderBody({super.key});

  @override
  State<CouponUploaderBody> createState() => _CouponUploaderBodyState();
}

class _CouponUploaderBodyState extends State<CouponUploaderBody> {
  DateTime _selectedDate = DateTime.now();
  late TextEditingController _couponNameController;
  String? _selectedFileName;

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
      lastDate: DateTime(2030)
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectFile() {
    // TODO: Implement file selection logic
    setState(() {
      _selectedFileName = 'example.pdf'; // Replace with actual selected file name
    });
  }

  void _uploadCoupon() {
    // TODO: Implement upload logic
    final String couponName = _couponNameController.text;
    print('Uploading coupon: $couponName, Expiry: $_selectedDate, File: $_selectedFileName');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: _selectFile,
            child: const Text('파일 선택'),
          ),
          const SizedBox(height: 8),
          Text(_selectedFileName ?? '선택된 파일 없음', style: const TextStyle(fontSize: 14)),
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
            onPressed: () {
              print(context);
              _selectDate(context);
            },
            child: Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDate)),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _uploadCoupon,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('업로드'),
          ),
        ],
      ),
    );
  }
}
