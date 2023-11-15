---
layout: post
title: 混入した特定の文字を探す
feature-img: "assets/img/portfolio/cake.png"
img: "assets/img/portfolio/na_found.png"
date: 27 September 2023
tags: [pandas, .isin, .at]
---

仮定の状況ですが、解析用のデータを情報システムから提供されました。しかし、特定の列は本来`'int64'`{:style="background: #64f5eb; font-size: 105%"} であるべきなのに、`'dtype('O')'`{:style="background: #64f5eb; font-size: 105%"} でオブジェクト型になっていました。

おそらく、ExcelでVLOOKUP関数を使用して他のExcelシートから情報を照合し、一致しない場合に`'#N/A'`{:style="background: #64f5eb; font-size: 105%"} が入力されているようです。そのため、問題を特定するために以下のコマンドを使用して問題を解決しました。

{% highlight python linenos %}
# 列PY_10に`#N/A` が混ざっていないかを確認する
df[df['PY_10'].isin(['#N/A'])]
{% endhighlight %}

結果は、以下のとおり<strong>6203行目</strong>に発見！

![n/a_found]({{ "assets/img/portfolio/na_found_63003.png" | relative_url}})


具体的な変更点は、以下のように行いました。この場合、ゼロを代入しました。

{% highlight python linenos %}
# 特定の要素をピンポイントに変更する
df.at[6203, 'PY_10']=0

{% endhighlight %}
