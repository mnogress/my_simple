---
layout: post
title: formatで書式設定をする
feature-img: "assets/img/2019_07_01/format_basic.png"
img: "assets/img/2019_07_01/format_basic.png"
date: 2018-10-26
tags: [python]
---

チートシート

![df.shape]({{ "assets/img/2019_07_01/print_pi.png" | relative_url}})


{% highlight python linenos %}
Pi=3.1415926539
print('円周率は{}です'.format(round(Pi, 2) ))
{% endhighlight %}

{% highlight python %}
円周率は3.14です
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

##### いつもカッコの数が足りなく、エラーが出ています　お尻に３つ閉じカッコがいるところを２つしかないと。。

{% highlight python %}
File "<ipython-input-207-5b5bb335a438>", line ２
    print('円周率は{}です'.format(round(Pi, 2) )
                        ^
SyntaxError: unexpected EOF while parsing
{% endhighlight %}{:style="background-color: #e8ebe9; font-size: 0.82em"}
