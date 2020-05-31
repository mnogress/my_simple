---
layout: post
title: 任意の列をピックアップして新しいデータフレームを作成
feature-img: "assets/img/portfolio/cabin.png"
img: "assets/img/portfolio/new_df_to_pick_up_cols.png"
date: 2017-05-26
tags: [pandas]
---

元のデータセットの中から、特定の列をピックアップして新しいデータフレームを作成する。新しく計算する際、定番の手順にもかかわらず、いつも忘れてしまい過去のやり方を確認しています。

---
### チートシート

やりたいこと　| コーディング
---------- | -------------
dfの列1と列2で新しい<br>データフレームを作成する| df = df[[&#39;列1&#39; , &#39;列2&#39;]]

1. 角括弧2つ [[ ]] で、列を指定すればいい
2. チートシートのように、df に代入すると、df自体の列が指定されたものだけになる＝他の列を削除したこととなる

---

### サンプルオペレーション

{% highlight python linenos %}
# 任意の列で新しいデータフレームを作成する
print('before', df.shape) 
df = df[['PY_02', 'PY_11']]
print('after', df.shape)
{% endhighlight %}

ビフォア、アフターでデータフレームのシェイプを確認する

{% highlight python %}
before (7507, 14)
after (7507, 2)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

{% highlight python linenos %}
# データフレームの先頭5行を見る
df.head()
{% endhighlight %}

カッコ内に数字をいれるとその数分、先頭から表示しますが、何も指定しないと 5行になります。

![df.head()]({{ "assets/img/portfolio/2_by_5_head.png" | relative_url}})