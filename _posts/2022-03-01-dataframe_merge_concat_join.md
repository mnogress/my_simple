---
layout: post
title: Merge Join Concat Dataframes
feature-img: "assets/img/2020_08_15/puzzle-gc00eeec6b_640.jpg"
tags: [Pandas, DataFrame, Python]
excerpt_separator: <!--more-->
---

Pandas を使って各種データセットの結合の方法を備忘録的にまとめたいと思います。とりあえず、まとめたところから公開したいと思います。今後、追加、編集していくブログになります。

<!--more-->

### 左結合(Left Join)

左結合とは、DataFrame1（df1）にDataFrame2（df２）を結合するにあたり、キーとなる列（ここでは”key”列）でマッチする行を結合します

{% highlight python linenos %}
df1 = pd.DataFrame({'col1': ['A', 'B', 'C', 'D'],
                    'key': [1, 2, 3, 4]})
df2 = pd.DataFrame({'col2': ['C', 'D', 'E', 'F'],
                    'key': [3, 4, 5, 6]})

df1.merge(df2,how='left',on='key')

{% endhighlight %}

![merge_left]({{ "assets/img/2020_08_15/pic1.png" | relative_url}})<br>

`df1.merge(df2,how='left',on='key')`{:style="background: #ffebf6"}は、`pd.merge(df1, df2,how=‘left’,on=‘key‘)`{:style="background: #ffebf6"}でも可


### インデックスJoin

merge left では軸となるキー列を`on=キーとなるなる列名`{:style="background: #ffebf6"}で指定しましたが、インデックスJoin ではデータフレームのインデックスに沿ってデータフレーム同士を結合します。

{% highlight python linenos %}
df1 = pd.DataFrame({'col1': ['A', 'B', 'C', 'D'],
                    'key': [1, 2, 3, 4]})
df2 = pd.DataFrame({'col2': ['C', 'D', 'E', 'F', 'G', 'H'],
                    'key': [3, 4, 5, 6, 7, 8]})
df1.join(df2, rsuffix='_2')

{% endhighlight %}

![index_join]({{ "assets/img/2020_08_15/pic2.png" | relative_url}})<br>


### チートシート

| **結合の種類**               | **Coding**                                                   |
| -------------------------- | ------------------------------------------------------------ |
| 左結合(left join)           | `df1.merge(df2,how='left',on='key')`{:style="background: #ffebf6"} または<br> <br> `pd.merge(df1, df2,how=‘left’,on=‘key‘)`{:style="background: #cbe8f5"}|
| インデックス Join            | `df1.join(df2, rsuffix='_2')`{:style="background: #ffebf6"} |




