# オンライン議事録アプリ

オンラインMTGの議事録を自動で生成できるアプリ

参加者全員のブラウザから音声を取得し、議事録を生成します。

![online giziroku](./画面.jpg)
（開発前に書いた画面一覧です。現在部屋作成完了後のモーダルは表示していません。文章の内容等、詳細部分で実際の実装と異なる部分があります。）


# 構築方法

docker-composeのインストール方法

docker-composeでdbとwebのサービスをビルド
```
docker-compose build
```

db作成
```
docker-compose run web rake db:create
```

docker-composeでdbとwebのサービスを起動
```
docker-compose up
```

このままだと、画面を表示した際にエラーが出てしまう。
新しいターミナルを開いて、dockerで起動している web に接続し、webpackerをインストールする。
```
docker exec -it online-giziroku_web_1 /bin/bash
rails webpacker:install 
```



以下のように上書きするか聞かれたらEnterを押して上書き。
```
Overwrite /myapp/config/webpacker.yml? (enter "h" for help) [Ynaqdhm] 
```

dbマイグレート
```
rails db:migrate
```

※すでにfirebaseに登録されているgoogleアカウントを使用した際に、rails側のdbにアカウントのデータが保存されていなかった場合エラーが発生します。
そうなってしまった場合、firebase側で登録情報を破棄するか、新しいfirebaseのプロジェクトを用意して、config等を書き換える必要があります。

# DB内確認方法

docker-composeでdbとwebのサービスを起動
```
docker-compose up
```

新しいターミナルを開いて、dockerで起動している web に接続し、そこからdbコンソールを開く。
```
docker exec -it online-giziroku_web_1 /bin/bash
rails dbconsole
```

passwordを聞かれたら、「password」と入力

