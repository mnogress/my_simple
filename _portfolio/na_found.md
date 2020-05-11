---
layout: post
title: ＃N/A を探す
feature-img: "assets/img/portfolio/cake.png"
img: "assets/img/portfolio/na_found.png"
date: 27 September 2019
tags: [pandas]
---

仮定の話：解析用のデータを情シスからもらいましたが、特定の列のみ、本来は`int64` でないといけないのに、`dtpey('O')`でオブジェクトになっている。　

どうやら、EXCEL でVllokupをかけて内容を他のEXCELシートから突合したようで、見つからない＝#N/A が入っているようだったので、
それを探すために以下のコマンドを打ち突き止めることができました。

{% highlight python linenos %}
# 列PY_10に`#N/A` が混ざっていないかを確認する
df[df['PY_10'].isin(['#N/A'])]
{% endhighlight %}

結果は、以下のとおり6303行目に発見！

![n/a_found]({{ "assets/img/portfolio/na_found_63003.png" | relative_url}})


ピンポイントに変更は、以下のように打ちました。 今回はゼロを代入しています。

{% highlight python linenos %}
# 特定の要素をピンポイントに変更する
df.at[6203, 'PY_10']=0

{% endhighlight %}
