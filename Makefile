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