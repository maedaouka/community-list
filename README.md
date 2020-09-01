# Community list

twitterのリストをみんなで作成できるサービスです。
twitter apiを利用して、このウェブアプリ上で作成したリストをtwitter上のリストに自動で反映します。

使用技術
  
  twitterAPI, firebaseAuth, Rails

参考リンク

  twitter gem  https://github.com/sferik/twitter <br>
  firebaseAuth+Rails  https://qiita.com/johnslith/items/6f8742b786b50f8dc0ac
  

![ezgif-1-47643f768ba6](https://user-images.githubusercontent.com/29334692/91519562-f0bdeb80-e92d-11ea-88e2-b9be66c88e24.gif)

# 構成
![IMG_20200727_135928](https://user-images.githubusercontent.com/29334692/88580428-8b54b180-d086-11ea-817d-375a1d284322.jpg)
![IMG_20200727_140059](https://user-images.githubusercontent.com/29334692/88580447-90b1fc00-d086-11ea-9681-cfa59490d323.jpg)

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
docker exec -it community-list_web_1 /bin/bash
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
※すでにfirebaseに登録されているtwitterアカウントを使用した際に、rails側のdbにアカウントのデータが保存されていなかった場合エラーが発生します。 そうなってしまった場合、firebase側で登録情報を破棄するか、新しいfirebaseのプロジェクトを用意して、config等を書き換える必要があります。

# DB内確認方法

docker-composeでdbとwebのサービスを起動
```
docker-compose up
```

新しいターミナルを開いて、dockerで起動している web に接続し、そこからdbコンソールを開く。
```
docker exec -it community-list_web_1 /bin/bash
rails dbconsole
```

passwordを聞かれたら、「password」と入力

