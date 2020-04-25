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

本サイトで使用するデータフレームについて説明します。　
<!--more-->
データ自体の共有はできません。ご了承ください。　

本サイトの記事でその中身を確認したり、操作したり、解析します。
記事を作成するにあたり、対象となるデータセットが必要です。私が今まで経験してきた解析のデータの構成に似せて作成しました。
実践的なスキルを習得するには、5x5 のデータフレームで練習してもビジネスの場ではあまり役に立ちません。　生のデータセットに近い、ある程度のサイズ、欠損値、外れ値、種々のデータ型が混在したデータセットを操作するスキルがとても重要です。
そんな環境を想定したデータセットで本サイトでは解説をしたいと思います。

また、そんなデータセットなど用意できないと思われる方には、 [kaggle](https://www.kaggle.com/)からダウンロードしてみるいいと思います。

### まとめ

項目 | 内容
---------- | -------------
データフレーム名 | df
サイズ | 読み込んだ最初は、7507行　x 14列
中身  | 仮想ビジネスデータ（社員ID， 担当企業名、所属都道府県番号等)
データの種類　| 数値(int64、float64）、カテゴリカル・データ、文字列、欠損値、外れ値


