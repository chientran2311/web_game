import 'package:flutter/material.dart';

class HelpOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const HelpOverlay({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned.fill(
      child: Container(
        color: const Color(0xFF050712).withValues(alpha: 0.9),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: 450,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFF161A2F),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF00F2FE)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00F2FE).withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Chào mừng đến với Syntax Quest!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00F2FE),
                    shadows: [
                      Shadow(
                        color: Color(0xFF00F2FE),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Nhiệm vụ của bạn là lắp ghép các khối từ khóa lập trình vào đúng trật tự để hoàn thành dòng code hợp lệ theo yêu cầu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    height: 1.6,
                    color: Color(0xFF90A4AE),
                  ),
                ),
                const SizedBox(height: 25),
                // Step items
                _buildHelpStep(
                  stepNum: '1',
                  description: 'Đọc kỹ yêu cầu ở bảng Nhiệm Vụ phía trên.',
                ),
                const SizedBox(height: 12),
                _buildHelpStep(
                  stepNum: '2',
                  description: 'Nhấp chuột vào khối lệnh ở kho hoặc kéo thả vào ô lắp ghép.',
                ),
                const SizedBox(height: 12),
                _buildHelpStep(
                  stepNum: '3',
                  description: 'Đặt khối "Tên biến" màu vàng vào khay và gõ tên biến mong muốn.',
                ),
                const SizedBox(height: 12),
                _buildHelpStep(
                  stepNum: '4',
                  description: 'Nhấn Kiểm tra cú pháp để hệ thống kiểm tra và chấm điểm!',
                ),
                const SizedBox(height: 30),
                // Play Button
                ElevatedButton(
                  onPressed: onClose,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF00F2FE),
                    shadowColor: const Color(0xFF00F2FE).withValues(alpha: 0.5),
                    elevation: 12,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'BẮT ĐẦU CHƠI',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHelpStep({required String stepNum, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFF00F2FE).withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF00F2FE).withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Text(
            stepNum,
            style: const TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00F2FE),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 13,
              height: 1.4,
              color: Color(0xFFECEFF1),
            ),
          ),
        ),
      ],
    );
  }
}
