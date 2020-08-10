---
layout: post
title: グラフに注釈をつける
feature-img: "assets/img/2019_07_01/apps-426559_1920.jpg"   
tags: [matplotlib, pandas]
excerpt_separator: <!--more-->
---

作画したグラフにより報告するにあたり、ピーク売上等の注目点を付け加えて、グラフの説明力を増したいことはよくあります。パワーポイントなどで
事後に追加してもいいかもしれませんが、`matplotlib`の機能で注釈(annotation)を追加してみました。


<!--more-->

[前回紹介した二軸グラフ]({{ "2019/12/11/two_axises_chart.html" | relative_url}}){:target="_blank"}で使った都道府県別の二軸のグラフの棒グラフ部分に`Peak of Month`の注釈をそれぞれに付けてグラフの自己説明力強化してみました。参考にしてください。

---



### グラフにannotation追加のポイント

基本的には、`annotate(text, xy, *args, **kwargs)` の一行追加するだけです。　
1. `text` 注釈のテキストです
2. `xy=(a,b)` がannotateする位置`(a,b)`です。
3. `xytext=(c,d)`は説明文の開始する位置を指定します。

参考: [matplotlib.pyplot.annotate](https://matplotlib.org/3.3.0/api/_as_gen/matplotlib.pyplot.annotate.html#matplotlib.pyplot.annotate
){:target="_blank"}

### サンプルコード

53行目から62行目までが追加した内容になります。

{% highlight python linenos %}
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pylab import rcParams
import seaborn as sb

# 背景白のグリッドにする
sb.set_style('whitegrid') 
%matplotlib inline

# 図のサイズを9inch x 6inch = 648px X 432px にする
rcParams['figure.figsize'] = 9,6

# 描画用のデータフレームを作成
df = pd.DataFrame({'Month': ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
                   'Revenue': [120, 200, 24, 70, 120, 230, 24, 70, 120, 230, 24, 70],
                   'Rate': [0.12, 0.84, 0.66, 0.3, 0.43, 0.56, 0.11, 0.29, 0.11, 0.98, 0.54, 0.33]},
                    index=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ])

# データフレームの各列をリスト形式の変数で受ける
month = df['Month']
x = month.values
y1 = df['Revenue']
y1 = y1.values
y2 = df['Rate']
y2 = y2.values

# 第一軸(ax1)と第二軸(ax2)を作ってax1 が左側の第一軸に、ax2 が右側で第二軸になります
fig, ax1 = plt.subplots()
ax2 = ax1.twinx()

#y1, y2軸それぞれの範囲を設定する
ax1.set_ylim([0, 250])
ax2.set_ylim([0, 1.1])

# グリッドは第一軸のみとする
ax1.grid(True)
ax2.grid(False)

#第一軸が棒グラフ、第二軸が折れ線グラフで描画する
ax1.bar(x, y1, label='# of Cases', color="lightblue" )
ax2.plot(x, y2, linewidth=2, color='orange', linestyle='solid', marker='o', markersize=8, label='Success Rate')

#タイトル、軸ラベル、凡例の表示、ｘ軸のラベル(month)は70度傾ける
ax1.set_title('2019 with annotation', pad=8, fontsize=20, color='blue')
ax1.set_ylabel('# of Cases')
ax2.set_ylabel('Success Rate')
ax1.set_xlabel('Month')
ax1.tick_params(axis='x', rotation=70)
ax1.legend(bbox_to_anchor=(0, 1), loc='upper left', borderaxespad=0.5, fontsize=10)
ax2.legend(bbox_to_anchor=(0, 0.95), loc='upper left', borderaxespad=0.5, fontsize=10)

# 棒グラフの最大値の値とインデックス番号(x軸の番号）を計算する
max = y1.max()
index_of_max = np.argmax(y1)

# 注釈の位置(index_of_max_next)は、インデックス番号の一つ右（＋１）とする
index_of_max_next = index_of_max + 1

# 最大値の月を"Peak of Month"と注釈(annotation)を付ける
ax1.annotate('Peak of Month', xy= (index_of_max, max), xytext=(index_of_max_next, max ),
           arrowprops=dict(facecolor='red', shrink=0.05))

plt.show()

# 描画した画像をカレントディレクトリにセーブする
fig.savefig('img_02_13.png')
{% endhighlight %}

#### 結果の図

以下のような図が描画されると思います。

![two_axis]({{ "assets/img/2019_07_01/img_02_131.png" | relative_url}})<br>

#### annotate のは軸あたり一つ

上記の計算では、最大値を求めて、それにannotateしましたが、サンプルデータでは230 の最大値を持つ月は6月の他に10月がありますが、
ご覧のとおり、最初の月（最初に現れた月）を最大値として持ってきています。最初に出現したものを最大値とするからですが、これは整数値でしかも取りうる値が限られている場合に最大値を求める計算の課題でもあります。

どうしても気になる場合は、ここだけ再計算して`annotate`を重ねることで解消はできます。

![two_axis]({{ "assets/img/2019_07_01/img_02_132.png" | relative_url}})<br>


### 二軸目にも当然、追加できます

今回のサンプルでは、ax1 が棒グラフ、ax2 が折れ線グラフとしています。　`annotate` をax2 に対して行なえば、二軸目にも注釈可能です。

![two_axis]({{ "assets/img/2019_07_01/img_02_133.png" | relative_url}})<br>


---

### ひとこと

>分析したデータの可視化での重要なポイントとしてグラフ自体の自己説明力は欠かせません。注釈(annotation) をつけることにより、見るものの着目点を誘導できますし、グラフだけで十分意味がとおり説明が不要になれば、プレゼンの準備もかなり楽になります。
