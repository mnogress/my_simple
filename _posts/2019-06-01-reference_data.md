---
layout: post
title: サンプルデータ
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


手順は、以下のとおりで、ここでは、3の **「NAN（欠損値）を適切に処置する」**について説明する。
1. そもそもデータタイプがカテゴリカル・データかどうか
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. **NAN（欠損値）を適切に処置する**

---
**チートシート**：

やりたいこと | コーディング
---------- | -------------
各列の欠損値の有無とその総数を調べる | df.isnull().sum()
特定の列のNaNのある行を外す | df = df[df['列名'].isnull() == False]
データフレームのサイズ（行数、列数）を確認する  | df.shape
