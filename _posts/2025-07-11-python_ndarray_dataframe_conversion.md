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
- wide
sidebar:
  nav: "docs"
tag: [DataFrame, ndarray, list]
category: Python
date: 2025-07-11
last_modified_at : 2025-10-29 09:00:00
---

このブログではデータハンドリングの基本である、DataFrame, ndarray, list の形式変換について「DataFrame,  ndarray,  list の使い分けについて実用的に考える」という問いに対してブログにしました。

<!--more-->

### この記事の目的

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

.custom-list-violet {
color: rgb(67, 31, 158);
font-size: 24px;
}

</style>

### DataFrame <-> ndarray <-> list 間のコンバージョンイメージ

![df_ndarray_list_conversion]({{ "/images/img/df_ndarray_list_conversion.png" | relative_url}}){:height="600px" width="600px"}<br>


### Pandas が用意する二次元データセット｜DataFrame：データフレーム

Pandasは、Pythonでのデータ分析ライブラリとして最も活⽤されているライブラリです。

PandasはNumpyを、Numpyを基盤に、シリーズ（Series、１次元データ）とデータフレーム（DataFrame、二次元データ）という二つのデータ型を提供します。

特に、データフレームは使いやすく、豊富な機能(メソッド)が用意され、データ分析のための必須のデータセットを扱う二次元データです。



<div class="box33">
    <span class="box-title">DataFrameの使い道</span>
  <ol>  
<li>DataFrameはインデックス（index）やカラム（column）名を指定して、Excelのシートのようにデータセットを用意するために利用します</li>
 </ol>
</div>



### 数値計算に特化したNumPy ndarray

NumPy（ナンパイ）は、**数値計算を効率よく行うためのPythonのライブラリ**です。
Pythonには標準で「リスト型」がありますが(後述します)、大量の数値データを扱うときは処理が遅くなったり、複雑になったりします。そこで役に立つのが **NumPy** です。

### **NumPy を使うとできること**

(1)  **多次元配列（行列など）を高速に扱える**<br> 
(2)  **標準偏差・分散などの統計量を簡単に計算できる**<br> 
(3)  科学技術計算や、機械学習・ディープラーニングでもよく使われる 

### **NumPy の ndarray（エヌディーアレイ）とは？**

NumPyには **ndarray（エヌディーアレイ）** という、数値データのための特別な配列型があります。

(1) 見た目はPythonのリストに似ている<br>
(2) しかし、**ベクトル計算のように、要素をまとめて高速に計算できる**<br>  
    （例：配列に <span class="rouge">+1</span> すると、全ての要素に一気に1が足される）


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


### **Python にもともと用意されている配列：list（リスト）**

Python には **list（リスト）** という、複数の値をひとまとめにして扱える便利なデータ形式があります。

(1) 1つの変数の中に、いくつものデータを入れられる  
         例：<span class="rouge">[1, 2, 3]</span> や <span class="rouge">["apple", "banana"]</span><br>
(2) Python では、**入力や出力でよく使われる基本的なデータ形式**

そのため「とりあえず配列を使いたい」というときは、まず list を使うことが多いです。


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




