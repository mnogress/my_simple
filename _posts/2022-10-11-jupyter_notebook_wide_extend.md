---
layout: post
title:  Jupyter Notebook 画面一杯を使えるようにする
feature-img: "assets/img/2020_08_15/flowers-6803234_640.png"
tags: [jupyter, pandas, Python]
excerpt_separator: <!--more-->
---

Jupyter Notebook を使うにあたり、まず最初にすることは画面一杯を使えるようにすることだと思います。 以下のコードでJupyter Notebook の作業域は最大化されます。


<!--more-->
### Jupyter Notebook の表示を画面一杯にする

Safari, Chrome, Edge どのブラウザーでも利用可能です。　忘れずに、最初に以下のコードを挿入しましょう。

{% highlight python linenos %}

from IPython.display import display, HTML
display(HTML("<style>.container { width:100% !important; }</style>"))

{% endhighlight %}

#### 拡大されたJupyter Notebook 画面イメージ

![dataframe_enlargement]({{ "assets/img/2020_08_15/iloc_pic0.png" | relative_url}})<br>


