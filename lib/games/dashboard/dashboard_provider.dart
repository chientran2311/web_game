import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_game/models/normal_status_enum.dart';
import 'package:web_game/models/dashboard/entity/game_entity.dart';
import 'package:web_game/models/dashboard/entity/user_profile_entity.dart';
import 'package:web_game/models/dashboard/enums/dashboard_enums.dart';
import 'dashboard_state.dart';

part 'dashboard_provider.g.dart';

@riverpod
class Dashboard extends _$Dashboard {
  @override
  DashboardState build() {
    // Return initial state with mock data matching the HTML template
    final mockGames = [
      GameEntity(
        id: 'scope-detective',
        title: 'Scope Detective',
        description: 'Xác định phạm vi hiển thị và giá trị thực tế của biến số trong JavaScript.',
        category: GameCategory.variables,
        difficulty: GameDifficulty.easy,
        xpReward: 100,
        isNew: false,
        progress: 80.0,
        lastPlayedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      GameEntity(
        id: 'boolean-bridge',
        title: 'Boolean Bridge',
        description: 'Xây cầu logic bằng cách giải quyết các bài toán đại số Boolean để giúp robot băng qua vực sâu.',
        category: GameCategory.dataTypes,
        difficulty: GameDifficulty.easy,
        xpReward: 100,
        isNew: false,
        progress: 45.0,
        lastPlayedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      GameEntity(
        id: 'callback-castle',
        title: 'Callback Castle',
        description: 'Nắm vững cách cấu hình và triển khai callbacks để quản lý vòng đời hệ thống.',
        category: GameCategory.functions,
        difficulty: GameDifficulty.hard,
        xpReward: 200,
        isNew: true,
        progress: 0.0,
      ),
      GameEntity(
        id: 'array-architect',
        title: 'Array Architect',
        description: 'Vận dụng các phương thức xử lý mảng map, filter, reduce để xây dựng kiến trúc dữ liệu.',
        category: GameCategory.dataTypes,
        difficulty: GameDifficulty.medium,
        xpReward: 150,
        isNew: true,
        progress: 0.0,
      ),
      GameEntity(
        id: 'refactor-rush',
        title: 'Refactor Rush',
        description: 'Phân tích cấu trúc logic lỗi thời, rút gọn mã lệnh tối đa và loại bỏ code trùng lặp.',
        category: GameCategory.realPractice,
        difficulty: GameDifficulty.hard,
        xpReward: 250,
        isNew: true,
        progress: 0.0,
      ),
      GameEntity(
        id: 'recursion-tower',
        title: 'Recursion Tower',
        description: 'Thiết kế cấu trúc hàm đệ quy để giải quyết bài toán tháp Hà Nội kinh điển.',
        category: GameCategory.functions,
        difficulty: GameDifficulty.hard,
        xpReward: 300,
        isNew: false,
        progress: 0.0,
      ),
      GameEntity(
        id: 'constant-quest',
        title: 'Constant Quest',
        description: 'Hiểu rõ sự khác biệt sâu sắc giữa khai báo var, let và const để tránh rò rỉ bộ nhớ.',
        category: GameCategory.variables,
        difficulty: GameDifficulty.easy,
        xpReward: 100,
        isNew: false,
        progress: 0.0,
      ),
      GameEntity(
        id: 'algorithm-escape',
        title: 'Algorithm Escape',
        description: 'Giải mã các mê cung thuật toán tìm đường phổ biến như BFS, DFS, Dijkstra để trốn thoát.',
        category: GameCategory.realPractice,
        difficulty: GameDifficulty.hard,
        xpReward: 350,
        isNew: false,
        progress: 10.0,
        lastPlayedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    const mockProfile = UserProfileEntity(
      id: '1',
      name: 'Antigravity',
      avatarInitials: 'AG',
      totalXp: 1250,
    );

    return DashboardState(
      status: NormalStatus.success,
      userProfile: mockProfile,
      allGames: mockGames,
    );
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}
