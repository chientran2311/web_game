import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/slot_rule.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_level.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';

final List<SyntaxLevel> gameLevels = [
  const SyntaxLevel(
    level: 1,
    quest: 'Khai báo một hằng số nguyên (integer constant) có tên là <code>tuoi</code> và gán giá trị bằng <code>18</code>.',
    expected: ['const', 'int', 'tuoi', '=', '18', ';'],
    rules: {
      'slot0': SlotRule(type: BlockType.keyword, val: 'const', errMsg: 'Cần sử dụng từ khóa "const" để khai báo hằng số cố định.'),
      'slot1': SlotRule(type: BlockType.type, val: 'int', errMsg: 'Dữ liệu số nguyên "18" phải dùng kiểu dữ liệu "int".'),
      'slot2': SlotRule(type: BlockType.name, val: 'tuoi', errMsg: 'Đặt tên biến là "tuoi" ở ô thứ 3.'),
      'slot3': SlotRule(type: BlockType.operator, val: '=', errMsg: 'Thiếu toán tử gán "=" để truyền giá trị.'),
      'slot4': SlotRule(type: BlockType.value, val: '18', errMsg: 'Gán giá trị số nguyên 18 như đề bài yêu cầu.'),
      'slot5': SlotRule(type: BlockType.operator, val: ';', errMsg: 'Dòng code cần kết thúc bằng dấu chấm phẩy ";".'),
    },
  ),
  const SyntaxLevel(
    level: 2,
    quest: 'Khai báo một biến chuỗi (string variable) có tên là <code>ten</code> và gán giá trị bằng chuỗi <code>"Cyber"</code>.',
    expected: ['var', 'String', 'ten', '=', '"Cyber"', ';'],
    rules: {
      'slot0': SlotRule(type: BlockType.keyword, val: 'var', errMsg: 'Sử dụng từ khóa khai báo biến linh hoạt "var".'),
      'slot1': SlotRule(type: BlockType.type, val: 'String', errMsg: 'Kiểu dữ liệu chuỗi chữ phải viết hoa chữ cái đầu: "String".'),
      'slot2': SlotRule(type: BlockType.name, val: 'ten', errMsg: 'Đặt tên biến là "ten".'),
      'slot3': SlotRule(type: BlockType.operator, val: '=', errMsg: 'Thiếu toán tử gán "=" .'),
      'slot4': SlotRule(type: BlockType.value, val: '"Cyber"', errMsg: 'Giá trị chuỗi ký tự phải được bọc trong nháy kép: "Cyber".'),
      'slot5': SlotRule(type: BlockType.operator, val: ';', errMsg: 'Thiếu dấu kết thúc câu lệnh ";".'),
    },
  ),
  const SyntaxLevel(
    level: 3,
    quest: 'Khai báo một biến số thực không thể thay đổi (final double) có tên là <code>diem</code> và gán giá trị bằng <code>9.5</code>.',
    expected: ['final', 'double', 'diem', '=', '9.5', ';'],
    rules: {
      'slot0': SlotRule(type: BlockType.keyword, val: 'final', errMsg: 'Sử dụng từ khóa "final" để đặt biến bất biến thời gian chạy.'),
      'slot1': SlotRule(type: BlockType.type, val: 'double', errMsg: 'Giá trị số thực thập phân "9.5" cần kiểu dữ liệu "double".'),
      'slot2': SlotRule(type: BlockType.name, val: 'diem', errMsg: 'Đặt tên biến là "diem".'),
      'slot3': SlotRule(type: BlockType.operator, val: '=', errMsg: 'Cần toán tử gán "=" .'),
      'slot4': SlotRule(type: BlockType.value, val: '9.5', errMsg: 'Gán giá trị số thực 9.5.'),
      'slot5': SlotRule(type: BlockType.operator, val: ';', errMsg: 'Kết thúc dòng lệnh bằng dấu ";".'),
    },
  ),
];

final List<SyntaxBlock> defaultBlocks = [
  const SyntaxBlock(id: 'const', text: 'const', type: BlockType.keyword, color: BlockColor.orange),
  const SyntaxBlock(id: 'final', text: 'final', type: BlockType.keyword, color: BlockColor.orange),
  const SyntaxBlock(id: 'var', text: 'var', type: BlockType.keyword, color: BlockColor.orange),
  const SyntaxBlock(id: 'late', text: 'late', type: BlockType.keyword, color: BlockColor.orange),
  
  const SyntaxBlock(id: 'int', text: 'int', type: BlockType.type, color: BlockColor.cyan),
  const SyntaxBlock(id: 'String', text: 'String', type: BlockType.type, color: BlockColor.cyan),
  const SyntaxBlock(id: 'double', text: 'double', type: BlockType.type, color: BlockColor.cyan),
  const SyntaxBlock(id: 'bool', text: 'bool', type: BlockType.type, color: BlockColor.cyan),
  
  const SyntaxBlock(id: 'var-name', text: 'Tên Biến', type: BlockType.name, color: BlockColor.yellow, isCustom: true),
  
  const SyntaxBlock(id: 'assign', text: '=', type: BlockType.operator, color: BlockColor.purple),
  const SyntaxBlock(id: 'semi', text: ';', type: BlockType.operator, color: BlockColor.purple),
  const SyntaxBlock(id: 'plus', text: '+', type: BlockType.operator, color: BlockColor.purple),
  
  const SyntaxBlock(id: 'val-18', text: '18', type: BlockType.value, color: BlockColor.green),
  const SyntaxBlock(id: 'val-cyber', text: '"Cyber"', type: BlockType.value, color: BlockColor.green),
  const SyntaxBlock(id: 'val-95', text: '9.5', type: BlockType.value, color: BlockColor.green),
  const SyntaxBlock(id: 'val-true', text: 'true', type: BlockType.value, color: BlockColor.green),
];
