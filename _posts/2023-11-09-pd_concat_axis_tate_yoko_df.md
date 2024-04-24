---
layout: post
title: データセットの結合 pd.concat 縦向き、横向き結合
feature-img: "assets/img/2020_08_15/cubes-7401572_1280.jpg"   
tags: [pandas, concat]
excerpt_separator: <!--more-->
---

DataFrameを縦方向でも横方向でも結合できるのがconcat関数の特徴を持つpd.concatについてまとました。
データフレームのデータの追加（縦結合）や属性の追加（横結合）で利用シーンの多い、pd.concatの利用方法についてまとめました。
<!--more-->

---

### pd.concat の引数axisとignore_index

下図を参照してください。

![concat_format]({{ "/assets/img/2020_08_15/fig_1117_01.png" | relative_url}})

### リスト形式で連結対象データフレームを指定する
concat 関数には連結したいデータフレームをリスト形式で渡します。　図のように、df1, df2, df3 の3つのデータフレームを一つに連結したいのであれば
`[df1, df2, df3]` とします。　pd.concat では一度に複数のデータフレームの結合が可能です。

### axis で連結方向：縦横が指定可能
axisは連結方向を示します。デフォルトの`axis=0`は縦方向、`axis=1`は横方向の連結です。

縦方向の連結では、列の内容が同じで行（データを追加したい等）のケースでとても便利です。いわゆる行を増やす縦持ちデータ追加です。　

一方、社員や製品の属性情報を追加する等の行ではなく、列を追加する場合は横方向にデータが追加します。　
縦方向でも横方向でも結合できるのがconcat関数の大きな特徴です。

### ignore_index 連結されたインデックスをそのままか、振り直すかを指定する

ignoreindexにはインデックスを振り直すか、そのまま他を指定します。falseを指定すると、そのままです。trueを指定すると、インデックスを振り直します。デフォルトはfalseでそのままです。


### axis=0 （デフォルト）で縦向きに連結する

連結するデータフレーム(df1,df2,df3)です。３つのデータフレームの列は同一です。

![concat_axis_0]({{ "/assets/img/2020_08_15/fig_1117_02.png" | relative_url}})

連結結果です。`ignore_index`の設定でインデックス番号がそのままだったり、振り直されたりしています。

![concat_axis_0]({{ "/assets/img/2020_08_15/fig_1117_03.png" | relative_url}})

このように、pd.concat のaxis=0 縦向き連結はデータの追加に適しています。

### axis=1 横向き連結

df4を作りたいと思います。df3.set_index(「名前」)で名前列をインデックスにします。
df4です。「名前」がインデックスになっていることがわかります。

新しいデータフレームを作成します。df5とします。
df5は名前と役職を持つデータフレームとします。そしてこのデータフレームのインデックスも「名前」に設定します。

![concat_axis_1]({{ "/assets/img/2020_08_15/fig_1117_04.png" | relative_url}})


### join="outer"は外部結合 、join="inner"は内部結合

この名前の列を軸（キー）に
df4とdf5の２つのデータフレームを横方向に結合してみます。axis=1を指定します。
今度は引数joinを指定してすることで連結のスタイルを指定します。join="outer"は外部結合です。
joinを指定しなかった時と同じ結果になります。

join="inner"は内部結合です。お互いに存在するデータのみが結合されます。
outerjoinとinnerjoinの違いは覚えておきたいところです。縦方向でも横方向でも結合できるのがconcat関数の特徴です。

![concat_axis_1]({{ "/assets/img/2020_08_15/fig_1117_06.png" | relative_url}})


`参照：`{:style="color: blue; font-size: 120"}[pd.concat](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.concat.html){:target="_blank"}


---


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [データセットの結合 pd.merge 左、右、外部、内部、クロス結合](https://www.so-wi.com/2023/11/08/pd_merge_left_right_outer_inner){:target="_blank"}<br>
2) [複数の行を連結して重複行を削除する](https://www.so-wi.com/2019/07/14/concat_rese_duplicaes){:target="_blank"}<br>
3) [Merge Join Concat Dataframes](https://www.so-wi.com/2022/03/01/dataframe_merge_concat_join){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}