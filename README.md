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