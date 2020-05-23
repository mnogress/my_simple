---
layout: post
title: ピボットテーブルでデータの集約化
feature-img: "assets/img/portfolio/jekyllblog2.png"   
tags: [Python, data_aggregation]
excerpt_separator: <!--more-->
---

データ分析の定番であるピボットテーブルでテータをグループ化して解析します。
<!--more-->
データセットの数値データとカテゴリカル・データを組み合わせて解析します。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
ピボットテーブルを作成する<br>計算列の値を平均する | pd.pivot_table(df, values=&#39;計算列&#39;, index=[&#39;列1&#39;, &#39;列2&#39;],<br> columns=[&#39;比較列1&#39;, &#39;比較列2&#39;], margins=True,  aggfunc=np.mean)


要素名 | 説明
---------- | -------------
計算列 | ピボットテーブルで計算したいデータの列
列1 | ピボットテーブルの親インデックス1
列2 | ピボットテーブルの子インデックス2
比較列1 | 集約列（親）
比較列2 | 集約列（子）

参照：　[pandas.DataFrame.pivot_table](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.pivot_table.html#pandas.DataFrame.pivot_table){:target="_blank"}

---


### Kaggle データで作成する

今回は、いつものデータフレームではなく、Kaggle より[Tipデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} をダウンロードしてピボットテーブルを作成しました。　欠損値のチェックやデータセットの理解のための一連の作業は実施済です。
Kaggle で tips, restaurant と検索すれば出てくると思います・

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}にデータセットの概要があります。参考にしてください。


### 今回使うデータのポイント

1. df.shape => 244 x 7
2. 第二列のラベル名 `tips`{:style="background: #cbe8f5"} に客が置いたチップの金額　$
3. 第三列以降に　「性別」、「喫煙・禁煙」、「木・金・土・日」、「ディナー・ランチ」

### ピボットテーブルの構成

ピボットテーブルはインデックス行と比較列で集約（計算）した内容がテーブルの要素になります

1. 性別と喫煙・禁煙の４つの組み合わせをインデックスとして
2. チップの金額の平均を「曜日」と「ディナー・ランチ」ごとに集約します
3. 最終列、最終行にそれぞれの行、列を計算します
4. 集約する計算方法は平均値になります


{% highlight python linenos %}
# ピボットテーブルを作成する
pd.pivot_table(df, values='tip', index=['sex', 'smoker'], columns=['day', 'time'], margins=True,  aggfunc=np.mean)

{% endhighlight %}

結果は以下のとおりですが、ビフォア、アフターで比較できるように、データフレームの最初５行も合わせて紹介します。今回は、`np.mean`{:style="background: #ffebf6"}で平均を計算してしますが、総和をとりたい場合は`np.sum`{:style="background: #ffebf6"}になります。

#### オリジナルのデータセット
![df,head()]({{ "/assets/img/2019_07_01/pivot_table_tips_before.png" | relative_url}})


#### ピボットテーブル
![ピボットテーブル]({{ "/assets/img/2019_07_01/pivot_table_tips.png" | relative_url}})


---

### ひとこと

> EXCELではおなじみのピボットテーブルですが、データ集約では欠かせません。　集約しただけで、思わぬ発見やこれだけでデータセットの理解が進んで、解析の方向性にも大きく影響する場合があります。`groupby`と同様に理解したいですね。

