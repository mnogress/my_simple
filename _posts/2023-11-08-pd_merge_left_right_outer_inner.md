---
layout: post
title: データセットの結合 pd.merge 左、右、外部、内部、クロス結合
feature-img: "assets/img/2020_08_15/grid-811032_1280.jpg"   
tags: [pandas, data_handling]
excerpt_separator: <!--more-->
---

DataFrameまたは名前付きSeriesオブジェクトをデータベーススタイルの結合で結合する pd.mergeについてまとました。

結合(pd.merge)は列またはインデックスを共通の軸にして行われます。列同士で結合する場合、DataFrameのインデックスは無視されます。一方、インデックス同士で結合するか、インデックスを列と結合する場合、インデックスは引き継がれます。ちょっとややこしい pd.merge のルールをできるだけわかりやすくまとめてみました。
<!--more-->


---

### pd.merge のルール

1. DataFrame(DataFrame)または名前付きシリーズ(Series)オブジェクト*をデータベーススタイルの結合で結合します。
2. データベーススタイルの結合とは、SQLの左、右、フル外部結合、内部結合に類似した結合です。
3. 名前付きSeriesオブジェクトは、単一の名前付き列を持つDataFrameとして扱われます。
4. 結合は列またはインデックスで行われます。
5. 列を列で結合する場合、DataFrameのインデックスは無視されます。
6. 一方、インデックスをインデックスで結合するか、インデックスを列に結合する場合、インデックスは引き継がれます。
7. クロス結合を行う際には、結合対象の列の指定は許可されません。

* 名前付きSeriesオブジェクトでの結合はこのブログでは扱いません。すべて、DataFrameを前提にしています。

参照： [pd.merge](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge.html#pandas-merge){:target="_blank"}

### 結合のスタイル（how = '引数'） 

結合のスタイルを表でまとめてみました。

| 種類 | 内容 |
|:-----:|:-----|
|<strong>left（左）</strong>|左のDataFrameからのキーのみを使用し、SQLの左外部結合に類似します。キーの順序を保持します。|
|<strong>right（右）</strong>|右のDataFrameからのキーのみを使用し、SQLの右外部結合に類似します。キーの順序を保持します。|
|<strong>outer（外部）</strong> |両方のDataFrameからのキーの和集合を使用し、SQLのフル外部結合に類似します。キーを辞書式に並べ替えます。 |
|<strong>inner（内部）</strong>|両方のDataFrameからのキーの共通部分を使用し、SQLの内部結合に類似します。左側のキーの順序を保持します。 |
|<strong>cross（クロス）</strong>|両方のDataFrameからのデータの直積を作成し、左側のキーの順序を保持します。|

### pd.merge のコーディングルール

コーディングルールは以下のとおりです。[pd.merge](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge.html#pandas-merge){:target="_blank"}のとおり、引数は他にもありますので、興味がある場合参照してください。
df1 が左(left)、 df2 が右(right) です。

![merge_format]({{ "/assets/img/2020_08_15/fig_1113_01.png" | relative_url}})

### サンプルデータフレームの作成
各々の結合スタイルを例示するため、
サンプルDataFrame, df1 と df2 を以下のように作成すます。
また、サンプルではインデックスを軸に結合するため、`set_index('インデックスにしたい列名')`　で明示的にインデックスを指定しています。　また、元に戻す場合は、`reset_index()`で戻ります。

![merge_format]({{ "/assets/img/2020_08_15/fig_1113_02.png" | relative_url}})

### 左結合

左のDataFrame df1のインデックス[`a`, `b`, `c`, `d`]を軸にdf1のcol1にdf2のcol2が, col1,col2の順序で結合されます。インデックス値の順序は変わりません。　df2のインデックスには`c` がありませんので、col2 の値には`NaN`が代入されます。

![merge_format]({{ "/assets/img/2020_08_15/fig_1113_03.png" | relative_url}})

### 右結合

右のDataFrame df2のインデックス[`a`, `b`, `d`, `e`]を軸にdf1のcol1にdf2のcol2がcol1,col2の順序で結合されます。インデックス値の順序は変わりません。　df1のインデックスには`e` がありませんので、col1の値には`NaN`が代入されます。 当たり前ですが、df1 のインデックス値`c`は対象となりません。

![merge_format]({{ "/assets/img/2020_08_15/fig_1113_04.png" | relative_url}})

### 外部結合

df1のインデックス[`a`, `b`, `c`, `d`]とdf2のインデックス[`a`, `b`, `d`, `e`]の和集合のインデックス値[`a`, `b`, `c`, `d`, `e`]を軸にdf1のcol1にdf2のcol2が結合されます。インデックスの順序はa,b,c順です。　
df1のインデックスには`e` がdf2のインデックス値`c`がありませんので、それらはそれぞれ`NaN`が代入されます。 


![merge_format]({{ "/assets/img/2020_08_15/fig_1113_05.png" | relative_url}})

### 内部結合

df1のインデックス[<strong>`a`, `b`, `c`, `d`</strong>]とf2のインデックス[<strong>`a`, `b`, `d`, `e`</strong>]の積集合のインデックス値[<strong>`a`, `b`,  `d`, </strong>]を軸にdf1 にdf2 が結合されます。

![merge_format]({{ "/assets/img/2020_08_15/fig_1113_06.png" | relative_url}})


### クロス結合

クロス結合（cross join）は、2つのDataFrameの全ての行同士の組み合わせを生成する操作です。クロス結合は、結合する列（キー）を指定せずに、単に2つのDataFrameを結合し、結果として全ての行の組み合わせを生成します。

クロス結合は通常、大きなデータセットの場合や特定の条件を満たす全ての組み合わせを見つける必要がある場合に使用されます。ただし、注意が必要で、DataFrameが大きい場合は生成される組み合わせが爆発的に増加し、メモリ使用量が増加する可能性があるため、注意が必要です。

![merge_format]({{ "/assets/img/2020_08_15/fig_1113_07.png" | relative_url}})



### チートシート

|やりたいこと | コーディング|
|:-----|:-----|
|'キー列名 key'でdf1にdf2を左結合する | df1.merge(df2, how='left', on ='キー列名 key')|
|`列名 key`をデータフレームdfのインデックスにする|df.set_index('列名 key')|
|データフレームdfのインデックスを`0,1,2..` に戻す|df.reset_index()<br>  () のみにすること|


---


### Warning

> 両方のキーカラムにキーが`null`である行が含まれている場合、これらの行は互いに一致します。これは通常のSQLの結合動作とは違う挙動になります。


---


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [データセットの結合 pd.concat 縦向き、横向き結合](https://www.so-wi.com/2023/11/09/pd_concat_axis_tate_yoko_df){:target="_blank"}<br>
2) [複数の行を連結して重複行を削除する](https://www.so-wi.com/2019/07/14/concat_rese_duplicaes){:target="_blank"}<br>
3) [Merge Join Concat Dataframes](https://www.so-wi.com/2022/03/01/dataframe_merge_concat_join){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}
