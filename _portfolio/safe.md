---
layout: post
title: UnicodeDecodeError: 'utf-8' codec can't decode byte 0x83 in position 2: invalid start byte
feature-img: "assets/img/portfolio/safe.png"
img: "assets/img/portfolio/safe.png"
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
