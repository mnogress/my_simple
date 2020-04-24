---
layout: post
title: UnicodeDecodeErrorで csv ファイルが読み込みエラーになる
feature-img: "assets/img/portfolio/safe.png"
img: "assets/img/portfolio/lighthouse.png"
date: August, 16 2019
tags: [pandas]
---

折角作ってもらった、`data.csv` ファイルがうまくread できないで；

```UnicodeDecodeError: 'utf-8' codec can't decode byte 0x83 in position 2: invalid start byte``` 

でエラーとなった場合の対処法


{% highlight python %}
# データの内容を無視してread する
import codecs
with codecs.open("data.csv", mode ="r", encoding ="Shift-JIS", errors="ignore") as file:
    df = pd.read_csv(file, delimiter =",", header=0)
{% endhighlight %}

もちろん、一旦ファイルをEXCELで開いて、`data.xlsx` 形式にして以下のようにEXCELファイルで読み込むことも可能ですが、この場合
csv to xlsx の手作業が発生する。頻繁にデータの入れ替えをして解析する場合やチームで対応する場合は実質このような方法は無理な場合が多いと思います。

{% highlight python %}
# EXCELファイルをread する
df.to_excel('data.xlsx', sheet_name='Sheet1')
{% endhighlight %}

