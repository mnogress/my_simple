---
layout: single
title: データセットの結合 pd.concat 縦向き、横向き結合
header:
  overlay_image: images/header_045_1280by336.png
  overlay_filter: rgba(44, 82, 207, 0.35)
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
tag: ["Pandas", "script"]
date: 2026-04-12
last_modified_at : 2026-04-12 11:00:00
excerpt: 
  Pandas の pd.concat を使ったデータフレームの縦結合・横結合をわかりやすく解説。
  複数データの統合、行追加・列追加の基本を図解で理解できます。
  データ分析で必須の concat の使い方を短時間でマスターしましょう。

---
<!--more-->
Pandas の pd.concat を使った縦結合・横結合を、図解中心で直観的に理解できるように解説。
外部結合・内部結合の違いも視覚的に整理し、複数データの統合や行追加・列追加がすぐに使える形で身につきます。
データ分析で必須の concat を、図で見てそのままコマンドに落とし込める構成でまとめました。

---

### pd.concat の引数axisとignore_index

下図を参照してください。

![concat_format]({{ "/images/img/fig_1117_01.png" | relative_url}})

#### リスト形式で連結対象データフレームを指定する
concat 関数には連結したいデータフレームをリスト形式で渡します。　図のように、df1, df2, df3 の3つのデータフレームを一つに連結したいのであれば
`[df1, df2, df3]` とします。　pd.concat では一度に複数のデータフレームの結合が可能です。

#### axis で連結方向：縦横が指定可能
axisは連結方向を示します。デフォルトの`axis=0`は縦方向、`axis=1`は横方向の連結です。

縦方向の連結では、列の内容が同じで行（データを追加したい等）のケースでとても便利です。いわゆる行を増やす縦持ちデータ追加です。　

一方、社員や製品の属性情報を追加する等の行ではなく、列を追加する場合は横方向にデータが追加します。　
縦方向でも横方向でも結合できるのがconcat関数の大きな特徴です。

#### ignore_index 連結されたインデックスをそのままか、振り直すかを指定する

ignoreindexにはインデックスを振り直すか、そのまま他を指定します。falseを指定すると、そのままです。trueを指定すると、インデックスを振り直します。デフォルトはfalseでそのままです。


#### axis=0 （デフォルト）で縦向きに連結する

連結するデータフレーム(df1,df2,df3)です。３つのデータフレームの列は同一です。

![concat_axis_0]({{ "/images/img/fig_1117_02.png" | relative_url}})

連結結果です。`ignore_index`の設定でインデックス番号がそのままだったり、振り直されたりしています。

![concat_axis_0]({{ "/images/img/fig_1117_03.png" | relative_url}})

このように、pd.concat のaxis=0 縦向き連結はデータの追加に適しています。

#### axis=1 横向き連結

df4を作りたいと思います。df3.set_index(「名前」)で名前列をインデックスにします。
df4です。「名前」がインデックスになっていることがわかります。

新しいデータフレームを作成します。df5とします。
df5は名前と役職を持つデータフレームとします。そしてこのデータフレームのインデックスも「名前」に設定します。

![concat_axis_1]({{ "/images/img/fig_1117_04.png" | relative_url}})


#### join="outer"は外部結合 、join="inner"は内部結合

この名前の列を軸（キー）に
df4とdf5の２つのデータフレームを横方向に結合してみます。axis=1を指定します。
今度は引数joinを指定してすることで連結のスタイルを指定します。join="outer"は外部結合です。
joinを指定しなかった時と同じ結果になります。

join="inner"は内部結合です。お互いに存在するデータのみが結合されます。
outerjoinとinnerjoinの違いは覚えておきたいところです。縦方向でも横方向でも結合できるのがconcat関数の特徴です。

![concat_axis_1]({{ "/images/img/fig_1117_06.png" | relative_url}})


ページ内容（pd.concat の解説）を踏まえて、  
**記事の最後に置く「まとめ（箇条書き）」** を、読みやすさと SEO を意識して作成しました。  
内容はあなたのページの実データに基づいています。   [localhost](http://localhost/reference/pd_concat_axis_tate_yoko_df)

---

### **まとめ**

- **pd.concat は複数の DataFrame を一度に結合できる便利な関数**  
- **axis=0（縦結合）** は行の追加に最適で、データ拡張に向いている  
- **axis=1（横結合）** は列の追加に使い、属性情報の付与に便利  
- **ignore_index** でインデックスを保持するか振り直すかを選べる  
- **join="outer" / "inner"** により、横結合時のデータの残し方を制御できる  
- **縦横どちらの結合にも対応できる柔軟性が concat の最大の特徴**

---


`参照：`{:style="color: blue; font-size: 120"}[pd.concat](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.concat.html){:target="_blank"}


---