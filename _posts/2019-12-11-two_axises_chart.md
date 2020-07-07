---
layout: post
title: matplotlibで二軸のグラフを作成する
feature-img: "assets/img/2019_07_01/Origami-pandas.jpg"   
tags: [matplotlib, pandas]
excerpt_separator: <!--more-->
---

Pandas でデータ解析をしていて、作図はEXCELに頼ることはしばしばあります。できればJupyter Notebookの中で完結したいですね。

簡単な図であれば、このBlogでも紹介したように`matplotlib`の基本機能で大丈夫ですが、EXCELでは、ごく一般的な棒グラフと折れ線グラフ
が重なりあった二軸のグラフを`matplotlib`で描画するのは、やはり最初は、ネットで調べる時間と使い方の理解が必要です。


<!--more-->

私も二軸のグラフを都道府県別に作図することとなり、`matplotlib`で挑戦しましたので、Blogにまとめました。
データフレームのデータから書き起こしました。そのまま、コピペすれば作図できるようにしました。
参考にしてください。

---



### 二軸のグラフ描画のポイント

1. データフレームの列をそのまま、入力データには出来ません。　リスト形式[]にする必要があります
2. 第一軸(ax1)と第二軸(ax2)を作ってお互いを関連付けます  `ax2 = ax1.twinx()`
2. 第一軸が棒グラフ、第二軸が折れ線グラフで描画しています。
3. 第一軸と第二軸のそれぞれの範囲を定義します
4. 描画した画像をカレントディレクトリにセーブします
5. グラフのスタイルセットを`seaborn`からロードしています。　`seaborn`をインポートする必要があります。
6. `rcParams`でグラフ画像のサイズを指定しています。 `pylab`をインポートする必要があります。


### サンプルコード

{% highlight python linenos %}
# 必要なモジュールをインポートします
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

#第一軸(ax1)と第二軸(ax2)を作ってax1 が左側の第一軸に、ax2 が右側で第二軸になります
fig, ax1 = plt.subplots()
ax2 = ax1.twinx()

#y1, y2軸それぞれの範囲を設定する
ax1.set_ylim([0, 250])
ax2.set_ylim([0, 1.1])

#グリッドは第一軸のみとする
ax1.grid(True)
ax2.grid(False)

#第一軸が棒グラフ、第二軸が折れ線グラフで描画する
ax1.bar(x, y1, label='# of Cases', color="lightblue" )
ax2.plot(x, y2, linewidth=2, color='orange', linestyle='solid', marker='o', markersize=8, label='Success Rate')

#タイトル、軸ラベル、凡例の表示、ｘ軸のラベル(month)は70度傾ける
ax1.set_title('2019', pad=8, fontsize=20, color='blue')
ax1.set_ylabel('# of Cases')
ax2.set_ylabel('Success Rate')
ax1.set_xlabel('Month')
ax1.tick_params(axis='x', rotation=70)
ax1.legend(bbox_to_anchor=(0, 1), loc='upper left', borderaxespad=0.5, fontsize=10)
ax2.legend(bbox_to_anchor=(0, 0.95), loc='upper left', borderaxespad=0.5, fontsize=10)

plt.show()

# 描画した画像をカレントディレクトリにセーブする
fig.savefig('img_01_19.png')
{% endhighlight %}

#### 結果の図

以下のような図が描画されると思います。

![two_axis]({{ "assets/img/2019_07_01/img_01_19.png" | relative_url}})<br>

#### クイック表示

細かくパラメータを設定する必要がありますが、一旦作成するとデータを変えて繰り返しスタイルのグラフを作成する場合は、便利な機能だと思います。　ただ、どのようなグラフになるか傾向を知りたいだけの場合、やはり長ったらしい設定であることは否めません。
クイックで見たい場合は、以下の二行でとりあえず、作図できます。　併せて、理解されることをお勧めします。

{% highlight python linenos %}
df['Revenue'].plot.bar()
df['Rate'].plot(secondary_y=True, style='g')
{% endhighlight %}

結果は以下のようなとてもシンプルなグラフ画鋲がされます。　プレゼン資料には使えないかもしれませんが、傾向値のイメージは掴めます。
<br>
![two_axis]({{ "assets/img/2019_07_01/quick_19_02.png" | relative_url}})<br>


### タイトル、ラベルの日本語化について

グラフのタイトル、ラベルが英語表記だとお気付きの方も少なくないと思います。
私は、仕事でmatplotlibを使うにあたり、ローマ字や英語表記で問題ないですが、
気になる方はIPAexGothic等の日本語フォントをダウンロードしmatplotlibで使えるようにする必要があります。



---

### ひとこと

分析したデータの可視化により、解析内容が分かりやすくなるだけでなく、増減傾向や出現パターンが明らかすることができます。それによりインスピレーションが呼び起され新たな分析の視点が生まれたりします。
作図となるとどうしてもEXCELに頼りたくなりますが、時間をかけてもせめてEXCELでできる作図程度は`matplotlib`でサクサクとやりたいですね。
