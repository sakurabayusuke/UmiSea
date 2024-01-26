# git
## 削除済みブランチの追跡解除とマージ済みのローカルブランチの削除
git-branch-clean:
	@git fetch --prune
	@git branch --merged | egrep -v "(^\*|master|main|develop)" | xargs git branch -d

# flutter
## コード自動生成
flutter-generate:
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

## アプリアイコンの生成
flutter-icon-generate:
	@fvm flutter pub run flutter_launcher_icons:main

## スプラッシュ画面の生成
flutter-splash-generate:
	@fvm flutter pub run flutter_native_splash:create

## ExportOptions.plist を作るためのコマンド
flutter-build-ipa:
	@fvm flutter build ipa

## release build で App Store 提出用の ipa を出力
flutter-release-build-ipa:
	@fvm flutter build ipa --release --obfuscate --split-debug-info --dart-define-from-file=dart_defines/release.json --export-options-plist="ios/configs/ExportOptions.plist"

flutter-release-build-appbundle:
	@fvm flutter build appbundle --release --obfuscate --split-debug-info --dart-define-from-file=dart_defines/release.json