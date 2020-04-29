---
layout: post
title: 任意の列をデータフレームからドロップする
feature-img: "assets/img/portfolio/ttt.png"
img: "assets/img/portfolio/drop_cols_create_new_df.png"
date: 2017-08-26
tags: [pandas]
---

列を元のデータフレームからドロップして新しいデータフレームとする方がピックアップして作るより多いと思います。この例では14列程度の小さなデータフレームなので、その気になれば一から組み立てることもできますが、実際の解析では、500以上の列というのはザラです。　そんな時、10程度の列をドロップしてNaNを完全になくしたデータフレームを作成するには、やはり`drop`メソッドを使うことが多いと思います。　それなのに、忘れてしまいがちな構文です。

{% highlight python %}
# 元のデータフレームから5つの任意の列をドロップする
print('before', df.shape) 

to_drop = ['PY_01',
           'PY_04',
           'PY_08',
           'PY_09',
           'PY_10']

df.drop(to_drop, inplace=True, axis=1)

print('after', df.shape) 
{% endhighlight %}

{% highlight python %}
before (7507, 14)
after (7507, 9)
{% endhighlight %}

`inplace=True`{:style="background: #ffebf6"}  でオブジェクトそのものに変更を加える。　そしてカラムに対して行うというコーディングです。

また、以下で同じことです。この場合は、ドロップした結果をdfに再度、代入しています。　

{% highlight python %}
print('before', df.shape) 
df =  df.drop(columns=['PY_01', 'PY_04','PY_08', 'PY_09', 'PY_10'])
print('after', df.shape) 
{% endhighlight %}


```df.head()``` 中身は以下のとおりでした。

![df.head()]({{ "assets/img/portfolio/drop_cols_to_make_new_df.png" | relative_url}})