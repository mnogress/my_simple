---
layout: post
title: サンプルデータセットについて
hide_title: false                                 # Hide the title when displaying the post, but shown in lists of posts
feature-img: "assets/img/2019_06_30/appearance_square-100.png"              # Add a feature-image to the post
# Sthumbnail: "assets/img/2019_06_30/code-1839406_1920.jpg"   # Add a thumbnail image on blog view
color: rgb(80,140,22)                             # Add the specified color as feature image, and change link colors in post
bootstrap: true                                   # Add bootstrap to the page
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

本サイトで使用する３つのデータセットについて説明します。　　
<!--more-->
記事を作成するにあたり、今後も追加することがあります。

---

データ自体は、当サイトから共有はできません。tipデータ等の出典がKaggleのデータ関しては[kaggle](https://www.kaggle.com/)からダウンロード可能です。　

### 概要

1. 本サイトの記事でその中身を確認及び操作ログを載せるために使用しています。
2. 私が今まで経験してきた解析のデータの構成に似せて作成したり、[kaggle](https://www.kaggle.com/)eから見つけてきました
3. 各ブログテーマに即したデータセットを[kaggle](https://www.kaggle.com/)よりダウンロードしています


実践的なスキルを習得するには、5x5 のデータフレームで練習してもビジネスの場ではあまり役に立ちません。　生のデータセットに近い、ある程度のサイズ、欠損値、外れ値、種々のデータ型が混在したデータセットを操作するスキルがとても重要です。

解析したいデータに似せたデータセットを自前で用意できない、もしくは時間が無い方には、 [kaggle](https://www.kaggle.com/)から適当なデータを見つけてダウンロードして使うといいと思います。


##### `データセット1`{:style="background: #cbe8f5"} 　`オリジナルデータ｀

項目 | 内容
---------- | -------------
出典 | 練習用に自作
データセット名 | オリジナルデータ
サイズ | 読み込んだ最初は、7507行　x 14列
中身  | 仮想ビジネスデータ（社員ID， 担当企業名、所属都道府県番号等)
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列、欠損値、外れ値



##### `データセット2`{:style="background: #cbe8f5"} 　`tipデータ`

項目 | 内容
---------- | -------------
出典 | [kaggle](https://www.kaggle.com/)で restaurant, tip で検索
データセット名 | tipデータ
サイズ | 244行　x 7列
中身  | レストラン　料金とチップ
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列


##### `データセット3`{:style="background: #cbe8f5"} `HRデータ`

項目 | 内容
---------- | -------------
出典 | [kaggle](https://www.kaggle.com/)で HR, attrition で検索
データセット名 | HRデータ
サイズ | 1470行　x 35列
中身  | HR データ　退職(attrition flag)、部門、年齢等
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列

##### `データセット4`{:style="background: #cbe8f5"} `リオデータ`

項目 | 内容
---------- | -------------
出典 | [kaggle](https://www.kaggle.com/)で Rio, Olympic で検索
データセット名 | リオデータ
サイズ | 11538行　x 11列
中身  | 各国別メダル数、選手リスト、生年月日
データの種類　| 数値(int64）、カテゴリカル・データ、文字列

