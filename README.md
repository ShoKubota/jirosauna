# ジロサウナー
![ロゴ – 9](https://user-images.githubusercontent.com/63547176/159874882-357ee159-befe-4d19-8e5e-1d45da9b2cb5.png)
【サービスURL】 https://www.jirosauna.com/
___
* UU数 1100
* 累計PV数 6000

# サービス概要：
「ジロサウナ〜」はマップからポイントを指定してボタンを押すと周囲の二郎系とサウナを一瞬で検索することができるアプリです。

# 機能について：
### 1. マップ検索機能
![IMB_LOfzDk](https://user-images.githubusercontent.com/63547176/159874910-dfce9827-c161-4360-b936-dcea35a80dbd.gif)
マップにピンを指してボタンを押すだけで周囲1.5km以内の二郎系とサウナを表示します。

### 2. 二郎系&サウナから探す機能
![IMB_n2uVAE](https://user-images.githubusercontent.com/63547176/159874947-1a6d2c8e-82db-4791-aaee-eecb024de2b7.gif)

#### 店舗詳細情報
![shops#show](https://user-images.githubusercontent.com/63547176/159878145-141ccb15-67ea-4f47-9553-2e0dfe044b30.png)

### 3. ユーザー機能・投稿機能（開発中）
ユーザーがおすすめのムーブを共有できるよう、投稿機能を現在開発中です。

# 使用技術：
### バックエンド
* Ruby 3.0.3
* Ruby on Rails 6.1.4

### フロントエンド
* JavaScript
* Tailwind CSS

### インフラ
* Heroku

### 使用API
* Google Maps JavaScript API（マップ検索に使用）
* Google Places API（店舗情報の取得に使用）
* Google Photos API（店舗外観画像の取得に使用）
* Geolocation API（現在地の取得に使用）
* Heart Rails GEO API（Twitter共有時、検索エリアの取得に使用）

# ER図
![ER](https://user-images.githubusercontent.com/63547176/159876231-3eaa3cb9-7780-45df-8a03-c8126aa474dd.png)

# 関連記事・その他
* [【個人開発】近くの二郎とサウナを一瞬で検索し、黄金ムーブがすぐできるアプリを作った（Qiita記事）](https://qiita.com/botcher_matsu/items/b87672215855730a3947)
* [大学生が近くの二郎とサウナを一瞬で検索し、黄金ムーブがすぐできるアプリを作るまで（note記事）](https://note.com/taiju365/n/naba8d1d016e5)
