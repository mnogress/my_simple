---
layout: post
title: 日本語対応した matplotlib 2軸グラフ
feature-img: "assets/img/2019_07_01/geometric-3066116_1280.jpg"   
tags: [matplotlib, japanese, pandas]
excerpt_separator: <!--more-->
---

matplotlib で作画した２軸のグラフでEXECLと決定的に違うところは、日本語対応です。何もしないと日本語のラベルは文字化けしてしまい、□□いわゆる豆腐になってしまいます。ブログで紹介した「[matplotlibで二軸のグラフを作成する]({{ "2019/12/11/two_axises_chart.html" | relative_url}}){:target="_blank"}」やそれに注釈をつけた「[二軸グラフに注釈をつける]({{ "2020/02/13/annotation_to_chart.html" | relative_url}}){:target="_blank"}」では、いずれも英語のラベルや注釈でしたが、簡単に文字化けせず、日本語で表示する方法をご紹介します。

<!--more-->

[二軸グラフに注釈をつける]({{ "2020/02/13/annotation_to_chart.html" | relative_url}}){:target="_blank"}で使った月別の二軸のグラフの縦軸、横軸、注釈部分を日本語で表記する例について、MacOSX Big Surでの例をご紹介します。

---


### 日本語化のポイント
>
>基本的には、`japanize-matplotlib` のパッケージを追加導入します　
>1. 日本語フォント`IPAGothic` をインストールします
>2. ```sns.set(font='IPAGothic')```を指定します
>3. `sns.set`メソッドを以降、指定しないようにします。
>

参考: [japanize-matplotlib](https://github.com/uehara1414/japanize-matplotlib){:target="_blank"}

### japanize-matplotlib　のインストール

PIPコマンドで`japanize-matplotlib`{:style="background: #ffebf6"} を追加します。　ホームディレクトリに追加してもいいですが、
パッケージをインストールすればするほど、システム全体の依存関係が複雑になります。
[仮想環境にPIPで定番パッケージを導入する]({{ "2021/01/15/Install_numpy_pandas_tensorflow_by_pip.html" | relative_url}}){:target="_blank"}でもご紹介しているとおり、システム全体にインストールする前に仮想環境でテストされることをお薦めします。
実際の開発現場では少なからず行っていることです。


>
このインストールログでは、**仮想環境名 `(py37env)`** の中に入り、**ホームディレクトリ配下の`python`**というディレクトリの下でパッケージをインストールしています。仮想環境の作成については
[Python3.7と3.8両方を使うための仮想環境を作成する_(Mac_Big_Sur)]({{ "2021/01/08/multi-python-env.html" | relative_url}}){:target="_blank"}の記事で仮想環境の作成方法を紹介しています。併せて参考にしてください。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 0.9em"}


{% highlight python linenos %}
(py37env) ~/python % pip install japanize-matplotlib

Collecting japanize-matplotlib
  Downloading japanize-matplotlib-1.1.3.tar.gz (4.1 MB)
     |████████████████████████████████| 4.1 MB 5.4 MB/s 
Requirement already satisfied: matplotlib in ./py37env/lib/python3.7/site-packages (from japanize-matplotlib) (3.3.4)
Requirement already satisfied: numpy>=1.15 in ./py37env/lib/python3.7/site-packages (from matplotlib->japanize-matplotlib) (1.19.5)
Requirement already satisfied: pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.3 in ./py37env/lib/python3.7/site-packages (from matplotlib->japanize-matplotlib) (2.4.7)
Requirement already satisfied: cycler>=0.10 in ./py37env/lib/python3.7/site-packages (from matplotlib->japanize-matplotlib) (0.10.0)
Requirement already satisfied: kiwisolver>=1.0.1 in ./py37env/lib/

## 中略

Stored in directory: /Users/home/Library/Caches/pip/wheels/83/97/6b/e9e0cde099cc40f972b8dd23367308f7705ae06cd6d4714658
Successfully built japanize-matplotlib
Installing collected packages: japanize-matplotlib
Successfully installed japanize-matplotlib-1.1.3
(py37env) ~/python % 

{% endhighlight %}

### IPAGothicフォントをインストールする

[文字情報技術促進協議会のダウンロードページ](https://moji.or.jp/ipafont/ipafontdownload/)から ZIP形式をフォントをダウンロードして、ダブルクリックしてインストールします。利用規約には必ず目を通しましょう。

---

### サンプルコード

ライン番号７から14が今回追加したところです。　それ以外は、タイトル、ラベルなどを日本語にしています。

{% highlight python linenos %}
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pylab import rcParams
import seaborn as sns

# 日本語表記のためのモジュールをインポートする
import japanize_matplotlib

sns.set(font='IPAGothic')
# 以降 sns.setは使わないこと上書きされてしまう
plt.rcParams['font.family'] = 'IPAexGothic'

%matplotlib inline

# 図のサイズを9inch x 6inch = 648px X 432px にする
rcParams['figure.figsize'] = 9,6

# 描画用のデータフレームを作成
df = pd.DataFrame({'Month': ['１月','２月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
                   'Revenue': [120, 200, 24, 70, 120, 230, 24, 70, 120, 211, 24, 70],
                   'Rate': [0.12, 0.84, 0.66, 0.3, 0.43, 0.86, 0.11, 0.29, 0.11, 0.77, 0.54, 0.33]},
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
ax2.plot(x, y2, linewidth=2, color='orange', linestyle='solid', marker='o', markersize=8, label='成功率')

#タイトル、軸ラベル、凡例の表示、ｘ軸のラベル(month)は70度傾ける
ax1.set_title('2020年 with annotation', pad=8, fontsize=20, color='blue')
ax1.set_ylabel('訪問件数')
ax2.set_ylabel('成功率')
ax1.set_xlabel('月')
ax1.tick_params(axis='x', rotation=70)
ax1.legend(bbox_to_anchor=(0, 1), loc='upper left', borderaxespad=0.5, fontsize=10)
ax2.legend(bbox_to_anchor=(0, 0.95), loc='upper left', borderaxespad=0.5, fontsize=10)

# 棒グラフの最大値の値とインデックス番号(x軸の番号）を計算する
max = y1.max()
index_of_max = np.argmax(y1)

# 注釈の位置(index_of_max_next)は、インデックス番号の一つ右（＋１）とする
index_of_max_next = index_of_max + 1

# 最大値の月を"Peak of Month"と注釈(annotation)を付ける
ax1.annotate('ピーク月', xy= (index_of_max, max), xytext=(index_of_max_next, max ),
           arrowprops=dict(facecolor='red', shrink=0.05))

plt.show()

# 描画した画像をカレントディレクトリにセーブする
fig.savefig('img_02_13.png')
{% endhighlight %}


#### 結果の図

以下のような図が描画されると思います。

![two_axis]({{ "assets/img/2019_07_01/img_02_13_jpn.png" | relative_url}})<br>



---

### ひとこと

>分析したデータを可視化するにあたり、グラフ自体の自己説明力は欠かせません。日本語化の利点は、オーディエンスが全て日本人であれば、できるだけ日本語にした方が、図への理解度の速さは英語とは格段によくなります。特に、説明するチャートが多ければ多いほど、直ぐに分かる（分からせる）ことが大切です。キーとなるチャートのタイトル、注釈、ラベルは日本語にするのも一手ですね。
