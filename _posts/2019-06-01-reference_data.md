---
layout: post
title: サンプルデータ(df)
hide_title: false                                 # Hide the title when displaying the post, but shown in lists of posts
feature-img: "assets/img/2019_06_30/code-1839406_1920.jpg"              # Add a feature-image to the post
# Sthumbnail: "assets/img/2019_06_30/code-1839406_1920.jpg"   # Add a thumbnail image on blog view
color: rgb(80,140,22)                             # Add the specified color as feature image, and change link colors in post
bootstrap: true                                   # Add bootstrap to the page
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

本サイトで使用するデータフレームについて説明する
<!--more-->


**まとめ**　

本サイトの記事でその中身をみて行くが、解析に使われる実際のデータの構成に似せて作成した。
練習用のデータセットは、 [kaggle](https://www.kaggle.com/)からダウンロードしてみるといい。

項目 | 内容
---------- | -------------
データフレーム名 | `df`
サイズ | 読み込んだ最初は、7507行　x 14列
中身  | 仮想ビジネスデータ（社員ID， 担当企業名、所属都道府県番号等
データの型　| 数値(int64、float64）、カテゴリカル・データ、文字列、欠損値、外れ値


