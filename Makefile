# git
## 削除済みブランチの追跡解除とマージ済みのローカルブランチの削除
git-branch-clean:
	@git fetch --prune
	@git branch --merged | egrep -v "(^\*|master|main|develop)" | xargs git branch -d

# flutter
## コード自動生成
flutter-generate:
	@fvm flutter pub run build_runner build --delete-conflicting-outputs