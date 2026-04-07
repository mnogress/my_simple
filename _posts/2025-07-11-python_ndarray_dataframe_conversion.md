---
layout: single
title:  DataFrame, ndarray, list の使い分けについて実用的に考える
header:
  overlay_image: images/header_A2.png
  overlay_filter: rgba(107, 74, 43, 0.35)
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
category: [Python]
date: 2026-03-22
last_modified_at : 2026-03-24 09:00:00
excerpt: >
  データ分析でよく使う DataFrame・ndarray・list の違いと使い分けを、実務目線でわかりやすく整理した How To 記事です。2次元データを扱う際に、それぞれの形式がどんな場面で適しているのかを比較し、用途に応じて変換できるようになることを目的に解説しています。

---

このブログではデータハンドリングの基本である、DataFrame, ndarray, list の形式変換について「DataFrame,  ndarray,  list の使い分けについて実用的に考える」という問いに対してブログにしました。

<!--more-->

### この記事の目的

データ分析をするデータセットはそのほとんどは、n行 ｘ ｍ列の２次元のデータです。２次元のデータを扱うためのデータ形式には、Pandas のデータフレーム、Numpyのndarray、Python標準の list が一般的です。それぞれの形式をその用途に合わせて相互変換します。 

このブログでは、２次元のデータに絞って、データ分析の観点から使い方に合わせて変換できることを目標にしています。

<style type="text/css">

</style>

### DataFrame <-> ndarray <-> list 間の相互変換

Python では次の3つの形式をよく使います：

*   **list（リスト）**
*   **ndarray（NumPy 配列）**
*   **DataFrame（Pandas の表形式データ）**

これらは用途が違うため、必要に応じて相互に変換して使います。



#### 1. list → ndarray（NumPy 配列）

Python の list を NumPy の ndarray に変換します。

{% highlight python linenos %}
import numpy as np

my_list = [1, 2, 3]
my_array = np.array(my_list)
{% endhighlight %}



#### 2. ndarray → list

NumPy 配列を Python の list に戻します。

{% highlight python linenos %}
my_list = my_array.tolist()
{% endhighlight %}

***

#### 3. ndarray → DataFrame（Pandas）

NumPy 配列を Pandas の DataFrame に変換します。

{% highlight python linenos %}
import pandas as pd

my_df = pd.DataFrame(my_array)
{% endhighlight %}

***

#### 4. DataFrame → ndarray

DataFrame から ndarray に変換します。

{% highlight python linenos %}
my_array = my_df.values
{% endhighlight %}

※ `.values` は ndarray を返します  
（Pandas 1.0以降は `.to_numpy()` を使うことも推奨されています）

{% highlight python linenos %}
my_array = my_df.to_numpy()
{% endhighlight %}


### DataFrame <-> ndarray <-> list 相互変換イメージ

![df_ndarray_list_conversion]({{ "/images/img/df_ndarray_list_conversion.png" | relative_url}}){:height="600px" width="600px"}<br>


### 変換一覧　

| 変換                  | コード                           |
| :----- |:-----  |
| **list → ndarray**      | <span class ="bleu2"> np.array(my_list)</span>                   |
| **ndarray → list**      | <span class ="bleu2">my_array.tolist()</span>                  |
| **ndarray → DataFrame** | <span class ="bleu2">pd.DataFrame(my_array)</span>              |
| **DataFrame → ndarray** | <span class ="bleu2">my_df.values</span> または <span class ="bleu2">my_df.to_numpy()</span> |


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




