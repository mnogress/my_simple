---
layout: post
title: サンプルデータ(df)
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

データ自体は、当サイトから共有はできません。データセット2,3 に関しては[kaggle](https://www.kaggle.com/)からダウンロード可能です。　

### 概要

1. 本サイトの記事でその中身を確認及び操作ログを載せるために使用しています。
2. 私が今まで経験してきた解析のデータの構成に似せて作成しました (データセット1)
3. 記事のテーマに即したデータセットをKaggle よりダウンロードしています（データセット2,3)


実践的なスキルを習得するには、5x5 のデータフレームで練習してもビジネスの場ではあまり役に立ちません。　生のデータセットに近い、ある程度のサイズ、欠損値、外れ値、種々のデータ型が混在したデータセットを操作するスキルがとても重要です。

データセットを自作で用意できないと思われる方には、 [kaggle](https://www.kaggle.com/)からダウンロードしてみるいいと思います。

### データセット1　

項目 | 内容
---------- | -------------
オリジナル | 練習用自作データ
データフレーム名 | df
サイズ | 読み込んだ最初は、7507行　x 14列
中身  | 仮想ビジネスデータ（社員ID， 担当企業名、所属都道府県番号等)
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列、欠損値、外れ値


### データセット2

項目 | 内容
---------- | -------------
オリジナル | [kaggle](https://www.kaggle.com/)
データフレーム名 | df
サイズ | 244行　x 7列
中身  | レストラン　料金とチップ
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列

### データセット3

項目 | 内容
---------- | -------------
オリジナル | [kaggle](https://www.kaggle.com/)
データフレーム名 | df
サイズ | 1470行　x 35列
中身  | HR データ　退職(attrition flag)、部門、年齢等
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列
