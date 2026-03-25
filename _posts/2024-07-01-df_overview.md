---
layout: single
title: df_overview スクリプト
header:
  overlay_image: images/header_X1_1280by336.png
  overlay_filter: rgba(107, 74, 43, 0.40)
toc: True
toc_label: "目次"
toc_icon: "heart" 
toc_sticky: True
excerpt_separator: <!--more-->
classes:
  - landing
  - dark-theme
  - wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
date: 2026-01-31
last_modified_at : 2026-03-22 15:23:00
---

データフレームの概要理解する "df_overview" スクリプトを紹介します。<!--more-->

#### 🧩 データを俯瞰する作業は分析の最初の重要なステップ

データ分析を始めたばかりのとき、最もつまずきやすいのが 「データの全体像がつかめない」 という問題です。
列が多かったり、欠損があったり、文字列と数値が混ざっていたりすると、どこから手をつければよいのか迷ってしまいます。

そこで役立つのが、このページで紹介する  <span class="bleu">df_overview</span> スクリプトです。
**列名・データ型・ユニーク数・欠損数**などを一覧で確認できるため、データセットの特徴を短時間で把握し、次に行うべき前処理や分析の方向性を決める助けになります。

初心者にとって、こうした **「データを俯瞰する作業」**は、分析の最初の重要なステップです。

#### 🧩 スクリプトの内容

{% highlight python linenos  %}

# 必要なモジュールをインポート
import numpy as np
import pandas as pd

# DataFrame 要約　列番号、列名、ユニーク変数数、データタイプ、NaN の個数
pd.options.display.max_rows = 220
## Check for unique values of categorical variables
df_overview = pd.DataFrame([[i, len(df[i].unique()), df[i].dtypes, df[i].isnull().sum()] for i in df.columns], 
                          columns=['Feature', 'Unique Values', 'dtypes', 'NaN'])
df_overview

{% endhighlight %}


#### 🧩 結果

![image]({{ "/images/2024-07150340.png" | relative_url}}){:height="500px" width="500px"}<br>


#### 🧩「ユニーク数を見ると何がわかるのか」

ユニーク数（その列に含まれる異なる値の数）を見ることで、**列の性質**がつかめます。
例えば、ユニーク数が少なければカテゴリ変数の可能性が高く、逆に非常に多ければIDのような識別子かもしれません。<br>
<span class="bleu">この情報は、どの列を分析に使えるか、どの列を前処理すべきかを判断する助けになります。</span>


#### 🧩「欠損値が多い列はどう扱うのか」

欠損値（NaN）が多い列は、分析の精度に影響するため注意が必要です。
欠損が多い列は、

(1) 削除する  
(2) 平均値・中央値・最頻値で補完する  
(3) モデルを使って補完する  
(4) そもそも使わない列として除外する  

などの判断が必要になります。まずは **「どの列にどれくらい欠損があるのか」 を把握することが、前処理の第一歩です。**


#### 🧩「データ型を確認する理由」

データ型（int, float, object など）を確認することで、その列がどのように扱われるべきかがわかります。
例えば、数字に見えるのに object 型になっている場合、文字列として扱われてしまい、計算や集計が正しくできません。
**データ型の確認は、後の分析でエラーを防ぐための重要なチェックポイントです。**


#### 🧩「このスクリプトを使うと、どんな分析準備が楽になるのか」

df_overview を使うと、列名・ユニーク数・データ型・欠損数を一覧で確認できるため、次のような作業がスムーズになります。

(1) どの列を前処理すべきか判断しやすくなる  
(2) カテゴリ変数・数値変数の分類がすぐにできる  
(3) 欠損値の扱い方針を立てやすくなる  
(4) 不要な列（ID列など）を早い段階で除外できる  

つまり、データセットの全体像を短時間でつかみ、分析の準備を効率化できるのが最大のメリットです。


#### データフレームのインデックス番号、インデックス名を指定してその行を削除する

おまけとして、インデックス名を指定してその行を削除するとてもよく使うコマンドを併記します。

{% highlight python linenos  %}

# データフレームの2行目にもタイトルの残骸があり、その行は無効なの
# 行を指定して削除する
# index[0] はデータフレームとしては最初の行だが、無効なため削除する

df = df.drop(df.index[[0]])

{% endhighlight %}


<style>
.violet {
color: #cb23d1;
font-size: 1.0em;
font-weight: 500;
font-style: italic;
font-family: inherit;
letter-spacing: 0.02em;
}
.rouge {
color: #d9180eff;
font-size: 1.14em;
font-weight: 500;
font-style: italic;
font-family: inherit;
letter-spacing: 0.02em;
}
.noir {
color: #090c0cff;
font-size: 0.850em;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.bleu {
color: #0053a6;
font-size: 1.20em;
font-weight: 500;
font-style: italic;
font-family: inherit;
letter-spacing: 0.02em;
}
.gris_p {
color: rgb(45, 43, 42);
font-size: 0.7em;
font-weight: 500;
font-style: normal;
font-family: inherit;
letter-spacing: 0.02em;
}
.petit {
font-size: 0.80em;
color: black;
font-family: inherit;
line-height: 1.1;
display: inline-block;
letter-spacing: inherit;
}
  /* このページだけのULを調整（スコープ＝.page-ul-fix） */
  .page-ul-fix ul {
    font-size: 1rem;       /* 任意のサイズに */
    line-height: 1.3;      /* 読みやすさ調整（任意） */
  }

  /* このページだけのOLを調整（スコープ＝.page-ul-fix） */
  .page-ul-fix ol {
    font-size: 1rem;       /* 任意のサイズに */
    line-height: 1.6;      /* 読みやすさ調整（任意） */
  }
</style>