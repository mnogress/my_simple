---
layout: post
title: 任意の列をピックアップして新しいデータフレームを作成
feature-img: "assets/img/portfolio/cabin.png"
img: "assets/img/portfolio/new_df_to_pick_up_cols.png"
date: 2017-05-26
tags: [pandas]
---

元のデータセットの中から、特定の列をピックアップして新しいデータフレームを作成する。新しく計算する際、定番の手順にもかかわらず、いつも忘れてしまい過去のやり方を確認しています。

{% highlight python %}
# 任意の列で新しいデータフレームを作成する
print('before', df.shape) 
df = df[['PY_02', 'PY_11']]
print('after', df.shape)
{% endhighlight %}

ビフォア、アフターでデータフレームの構成を確認する

{% highlight python %}
before (7507, 14)
after (7507, 2)
{% endhighlight %}

{% highlight python %}
# データフレームの先頭5行を見る
df.head()
{% endhighlight %}

カッコ内に数字をいれるとその数分、先頭から表示しますが、何も指定しないと 5行になります。

![df.head()]({{ "assets/img/portfolio/2_by_5_head.png" | relative_url}})