class Occupation < ActiveHash::Base
  self.data = [
    { id: 1,  name: '---' }, # デフォルトの選択肢
    { id: 2,  name: '会社員' }, # 一般的な会社員
    { id: 3,  name: '学生' }, # 学生
    { id: 4,  name: '公務員' },             # 公務員
    { id: 5,  name: '自営業' },             # 自営業
    { id: 6,  name: 'パート・アルバイト' }, # パートタイムやアルバイト
    { id: 7,  name: '主婦（主夫）' },        # 主婦または主夫
    { id: 8,  name: 'フリーランス' },        # フリーランス
    { id: 9,  name: '無職' }, # 現在無職
    { id: 10, name: 'その他' } # その他、カスタム選択肢
  ]
end
