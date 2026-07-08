# Experience Log — Bài học rút ra khi code MoniKid

Các bài học cốt lõi tích lũy trong quá trình đọc/sửa code. Mỗi mục: nguyên tắc + ví dụ thật.

---

## 1. `await X; rồi Y` là một lời cam kết, không chỉ là thứ tự dòng code

`await X; rồi Y` không chỉ là "thứ tự code". Nó là **lời cam kết: Y không bao giờ chạy khi X chưa xong**. Đảo thứ tự = phá cam kết đó = tạo cửa sổ race. **Test tay xanh ≠ code đúng.**

**Ví dụ thật — `finishOnboarding`** ([onboarding_screen.dart](../../../lib/features/auth/onboard/onboarding_screen.dart)):

```dart
await ref.read(onboardingRepositoryProvider).markOnboardingComplete(); // ghi flag TRƯỚC
if (context.mounted) context.go(AppRoutes.login);                      // điều hướng SAU
```

- Đảo thứ tự (`go` trước, `mark` sau) → app crash/bị OS kill đúng khe hẹp giữa hai dòng → flag chưa flush xuống disk → **lần sau user thấy onboarding lần 2**.
- Bug này **flaky**: ghi disk chỉ vài ms nên 99% lần test tay vẫn kịp ghi → trông như chạy đúng. Chỉ lộ khi crash đúng thời điểm → cực khó debug.

**Quy tắc:** Khi một hành động B chỉ được phép chạy *sau khi* hành động A chắc chắn hoàn tất (ghi disk, ghi DB, network), luôn `await A` trước B. Đừng tin "test tay qua được".
