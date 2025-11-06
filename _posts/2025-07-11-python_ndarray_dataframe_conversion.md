---
layout: single
title:  DataFrame, ndarray, list の使い分けについて実用的に考える
header:
  overlay_image: images/header_K.png
  overlay_filter: rgba(107, 74, 43, 0.20)
toc: true
toc_label: "目次"
toc_icon: "heart"
toc_sticky: True
excerpt_separator: <!--more-->
classes:
- landing
- dark-theme
#- wide
sidebar:
  nav: "docs"
tag: [DataFrame, ndarray, list]
category: Python
date: 2025-07-11
last_modified_at : 2025-10-29 09:00:00
---

このブログではデータハンドリングの基本である、DataFrame, ndarray, list の形式変換について「DataFrame,  ndarray,  list の使い分けについて実用的に考える」という問いに対してブログにしました。

<!--more-->


データ分析をするデータセットはそのほとんどは、n行 ｘ ｍ列の２次元のデータです。２次元のデータを扱うためのデータ形式には、Pandas のデータフレーム、Numpyのndarray、Python標準の list が一般的です。それぞれの形式をその用途に合わせて変換します。 


このブログでは、２次元のデータに絞って、以下の図をデータ分析の観点から使い方に合わせて変換できることを目標にしています。

<style type="text/css">

table {
  display: block;
  margin-bottom: 1em;
  width: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI", "Helvetica Neue", "Lucida Grande", Arial, sans-serif;
  font-size: 0.75em;
  border-collapse: collapse;
  overflow-x: auto;
}

table + table {
  margin-top: 1em;
}

thead {
  background-color: #e6e6fa;
  border-bottom: 2px solid #9b9b9d;
}

th {
  padding: 0.5em;
  font-weight: bold;
  text-align: start;
}

td {
  padding: 0.5em;
  border-bottom: 1px solid #9b9b9d;
}

tfoot {
  background-color: #afeeee;
  padding: 0.5em;
  border-top: 2px solid #9b9b9d;
  border-bottom: 2px solid #9b9b9d;
}

tr,
td,
th {
  vertical-align: middle;
}
_media screen and (max-width:1280px){
.p_table {width:100%;overflow:scroll;}
.p_table table {width:1153px;}
}
_media screen and (max-width:750px){
.resp_table {width:100% !important;}
.resp_table th ,.resp_table td{padding:10px !important;}
}
.rouge {
color: red;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.noir {
color: 1A818;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.bleu {
color: blue;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.petit {
font-size: 0.80em;
color: black;
font-family: inherit;
line-height: 1.1;
display: inline-block;
letter-spacing: inherit;
}

.custom-list-violet {
color: rgb(67, 31, 158);
font-size: 24px;
}

</style>

### DataFrame <-> ndarray <-> list 間のコンバージョン

![df_ndarray_list_conversion]({{ "/images/img/df_ndarray_list_conversion.png" | relative_url}}){:height="600px" width="600px"}<br>


### Pandas DataFrame がデータセットを用意するツール

Pandasは、Pythonでのデータ分析ライブラリとして最も活⽤されているライブラリです。Pandas
はNumpyを基盤に、シリーズ（Series、１次元データ）とデータフレーム（DataFrame、二次元データ）という二つのデータ型を提供します。
データフレームは使いやすく、豊富な機能(メソッド）でデータ分析のための無くてはならないライブラリです。



<div class="box33">
    <span class="box-title">DataFrameの使い道</span>
  <ol>  
<li>DataFrameはインデックス（index）やカラム（column）名を指定して、Excelのシートのようにデータセットを用意するために利用します</li>
 </ol>
</div>



### 数値計算に特化したNumpy ndarray

Numpyを利⽤すると、Python標準のリスト型に⽐べて、多次元配列のデータを効率よく扱うことができます。また、Numpyは標準偏差や分散といった統計量を出⼒してくれる関数が⽤意されており、科学技術計算の基盤となっており、その延長線上で機械学習、ディープラーニングでも使われています。

Numpyには、ndarrayと呼ばれるデータ型が⽤意されています。 ndarrayは⼀⾒すると、Python標準のリスト型（list）と似ていますが、ベクトル計算のように、内部の要素それぞれを⼀括して計算します。

### ndarray と list の計算の違い

![ndarray_vs_list]({{ "/images/img/ndarray_vs_list.png" | relative_url}}){:height="600px" width="600px"}<br>

<div class="box33">
    <span class="box-title">ndarrayの使い道</span>
  <ol>  
<li>機械学習での学習用と検証用に分割したデータセットなど分析モデルの入出力形式です</li>
 </ol>
</div>



**Pandas, Numpyとも「統計量」を算出するメソッドは多数提供されています。Pandas の方が使いやすく、見やすいという意見も多いです。**
{: .notice--danger}


### Python標準の配列データの形式がlist

⼀つの変数に複数のデータを⼊れて扱う、配列データとして使うのが リスト型（list)です。したがって、Pythonプログラムの入出力の標準データ形式がlist ということになります。


<div class="box33">
    <span class="box-title">listの使い道</span>
  <ol>  
<li>インデックス番号（添字と呼んだりします）で要素を指定することができる、Pyhtonプログラムの入出力データの標準的な配列形式です
</li>
 </ol>
</div>

### まとめ

| | DataFrame | ndarray | list  |
| :----- | :----- | :----- | :-----|
| 利用するライブラリ | Pandas   | Numpy  | Python標準   |
| ラベルインデックス<br>(列、行に任意の名前を付けること) | 可（列名、行名を指定してにデータの操作が可能） | 不可(0から始まるインデックス番号で操作する)  | 不可(0から始まるインデックス番号で操作する) |
| 特徴 | 使いやすい、メソッドが豊富  | 計算に特化した配列形式  | tuple, dictionaryと並ぶ配列形式の一つ   |
| 目的 | 欠損値処理、標準化等の分析データの整形  | 機械学習、ディープラーニングの目的、説明変数等 | Pythonプログラムのデータの入出力等  |
{: class="table"}




