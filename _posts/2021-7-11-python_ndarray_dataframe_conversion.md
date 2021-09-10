---
layout: post
title: DataFrame, ndarray, list の使い分けについて実用的に考える
feature-img: "assets/img/2019_07_01/road-4348087_1280.jpg"   
tags: [DataFrame, ndarray, list]
excerpt_separator: <!--more-->
---

データ分析をするデータセットはそのほとんどは、n行 ｘ ｍ列の２次元のデータです。２次元のデータを扱うためのデータ形式には、Pandas のデータフレーム、Numpyのndarray、Python標準の list が一般的です。それぞれの形式をその用途に合わせて変換します。 

このブログではデータハンドリングの基本である、DataFrame, ndarray, list の形式変換について「DataFrame,  ndarray,  list の使い分けについて実用的に考える」という問いに対して私なりの考えをブログにしました。  参考にしてくださいませ。

<!--more-->

このブログでは、２次元のデータに絞って、以下の図をデータ分析の観点から使い方に合わせて変換できることを目標にしています。

#### DataFrame <-> ndarray <-> list 間のコンバージョン

![df_ndarray_list_conversion]({{ "assets/img/2019_07_01/df_ndarray_list_conversion.png" | relative_url}})<br>


### Pandas DataFrame がデータセットを用意するツール

Pandasは、Pythonでのデータ分析ライブラリとして最も活⽤されているライブラリです。Pandas
はNumpyを基盤に、シリーズ（Series、１次元データ）とデータフレーム（DataFrame、二次元データ）という二つのデータ型を提供します。
データフレームは使いやすく、豊富な機能(メソッド）でデータ分析のための無くてはならないライブラリです。

>
`[DataFrameの使い道]`{:style="color: blue; font-size: 1.3em"} <br>
DataFrameはインデックス（index）やカラム（column）名を指定して、Excelのシートのようにデータセットを用意するために利用します
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}



### 数値計算に特化したNumpy ndarray

Numpyを利⽤すると、Python標準のリスト型に⽐べて、多次元配列のデータを効率よく扱うことができます。また、Numpyは標準偏差や分散といった統計量を出⼒してくれる関数が⽤意されており、科学技術計算の基盤となっており、その延長線上で機械学習、ディープラーニングでも使われています。

Numpyには、ndarrayと呼ばれるデータ型が⽤意されています。 ndarrayは⼀⾒すると、Python標準のリスト型（list）と似ていますが、ベクトル計算のように、内部の要素それぞれを⼀括して計算します。

#### ndarray と list の計算の違い

![ndarray_vs_list]({{ "assets/img/2019_07_01/ndarray_vs_list.png" | relative_url}})<br>

>
`[ndarrayの使い道]`{:style="color: blue; font-size: 1.3em"} <br>
機械学習での学習用と検証用に分割したデータセットなど分析モデルの入出力形式です
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

`Pandas, Numpyとも「統計量」を算出するメソッドは多数提供されています。Pandas の方が使いやすく、見やすいという意見も多いです。`{:style="color: blue"} 


### Python標準の配列データの形式がlist

⼀つの変数に複数のデータを⼊れて扱う、配列データとして使うのが リスト型（list)です。したがって、Pythonプログラムの入出力の標準データ形式がlist ということになります。

>
`[listの使い道]`{:style="color: blue; font-size: 1.3em"} <br>
インデックス番号（添字と呼んだりします）で要素を指定することができる、Pyhtonプログラムの入出力データの標準的な配列形式です
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}



### まとめ

|                                                        | DataFrame                                      | ndarray                                        | list                                        |
| ------------------------------------------------------ | ---------------------------------------------- | ---------------------------------------------- | ------------------------------------------- |
| 利用するライブラリ                                     | Pandas                                         | Numpy                                          | Python標準                                  |
| ラベルインデックス<br>(列、行に任意の名前を付けること) | 可（列名、行名を指定してにデータの操作が可能） | 不可(0から始まるインデックス番号で操作する)    | 不可(0から始まるインデックス番号で操作する) |
| 特徴                                                   | 使いやすい、メソッドが豊富                     | 計算に特化した配列形式                         | tuple, dictionaryと並ぶ配列形式の一つ       |
| 目的                                                   | 欠損値処理、標準化等の分析データの整形         | 機械学習、ディープラーニングの目的、説明変数等 | Pythonプログラムのデータの入出力等          |



---

### ひとこと

> Python でデータを扱うその殆どがデータフレーム形式が実際だと思います。機械学習で例えば、`train_test_split(x_train_df, y_train_df, test_size=0.1, random_state=777)`でデータフレームを学習用と検証用にパーティショニングしたとたん、あまり馴染みのないndarrary形式となってしまいます。　Python を学び始めた頃に配列を変数化する際に必ず登場する`lst = [10, 20, 30, 40, 50] `実は、それぞれが絡みあってデータ分析をするのが実際だと思います。冒頭の変換図に近いものは皆さんメモされていると思います。基本的な内容ですが、ご参考になれば幸いです。

