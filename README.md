# アプリケーション名	
## Hibirog
# アプリケーション概要	このアプリケーションでできることを記載。
このアプリケーションでは日々の学んだことを記録することができます。また、学んだことをアウトプットする場としてチャットの機能も搭載しています。チャットではアウトプットのみならずコミュニケーションを取る場としても使えるようになっています。
# URL	
https://hibirog-41961.onrender.com
# テスト用アカウント	
Basic認証  
id  :admin  
pass:2222   
# 利用方法	
- 新規登録をする
- 記録の新規投稿をする
- 記録はタイトル、説明、定着率の選択が必須
- 一覧機能と詳細機能から削除と編集が可能
- 定着率が上から4,5番目の場合チャットに共有できる
- チャットはメッセージのみの入力もできる
# アプリケーションを作成した背景
このアプリケーションは普段の学びを一元管理したい人に向けて作成されています。  
学生や社会人の方には資格勉強や覚えたい仕事の内容など  
主婦にはレシピなど、覚えたいことを記録により蓄積していくことができます。  
似たようなアプリに「notion」というアプリがありますが、機能を一部に限定し、シンプルな構造にすることで一元管理がしやすくなっています。
# 実装した機能についての画像やGIFおよびその説明※	実装した機能について、それぞれどのような特徴があるのかを列挙する形で記載。画像はGyazoで、GIFはGyazoGIFで撮影すること。
# 実装予定の機能	洗い出した要件の中から、今後実装予定の機能がある場合は、その機能を記載。
# データベース設計	ER図を添付。
# 画面遷移図	画面遷移図を添付。
# 開発環境	使用した言語・サービスを記載。
# ローカルでの動作方法	git cloneしてから、ローカルで動作をさせるまでに必要なコマンドを記載。
# 工夫したポイント	制作背景・使用技術・開発方法・タスク管理など、企業へＰＲしたい事柄を記載。
# 改善点	より改善するとしたらどこか、それはどのようにしてやるのか。
# 制作時間	アプリケーションを制作するのにかけた時間。

## Usersテーブル

|Column             |Type         |Options                  |
|-------------------|-------------|-------------------------|
|name               |string       |null: false              |
|email              |string       |null: false, unique: true|
|encrypted_password |string       |null: false              |
|birth_date         |date         |null: false              |
|occupation_id      |integer      |null: false              | 


### Association
- has_many :records
- has_many :chats
- has_many :comments

## recordsテーブル

|Column             |Type         |Options                  |
|-------------------|-------------|-------------------------|
|title              |string       |null: false              |
|description        |text         |null: false              |
|emotion            |string       |null: false              |
|location           |string       |null: false              |
|file_data          |string       |カラムは不要               | 
|retention-level_id |integer      |null: false              | 
|user               |references   |null: false, foreign_key: true| 


### Association
- has_one :chat
- belongs_to :user
- has_many :comments

## chatsテーブル

|Column             |Type         |Options                  |
|-------------------|-------------|-------------------------|
|user               |references   |null: false, foreign_key: true|
|record             |references   |null: false, foreign_key: true|
|message_content    |text         |null: false              |
|image              |string       |                         |


### Association
- belongs_to :user
- belongs_to :record

## commentsテーブル

|Column             |Type         |Options                  |
|-------------------|-------------|-------------------------|
|user               |references   |null: false, foreign_key: true|
|record             |references   |null: false, foreign_key: true|
|comment            |text         |null: false              |


### Association
- belongs_to :user
- belongs_to :record