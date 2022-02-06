---
layout: post
title: Python と SPSS Modeler で XGBoost の特徴量選択を比較する
feature-img: "assets/img/2020_08_15/circuit-board-6522546_1280.png"
tags: [Python, SPSS Modeler, XGBoost]
excerpt_separator: <!--more-->
---

特徴量選択（feature selection）＝どれを説明変数として使うかは、データ分析では重要です。実際のところドメイン知識が大きな力を発揮するため、データサイエンスに精通しないがドメイン知識をもつ専門家にもっと、モデルを作成してもらうためIBM のSPSS® Modeler等の統計ソフトは大手企業、官公庁向の研究者やテータ分析担当者向けに導入が進んでいます。

<!--more-->
このBlogでは、特徴量選択についてXGBoostのアルゴリズムでSPSS® Modeler の特徴量選択とPython Scikit-Learnの結果を比較してみたいと思います。
SPSS® Modeler には、Python 固有のアルゴリズムを使用するためのノードが用意されています。XGBoost Tree© は、
ツリー モデルを基本モデルとして使用する勾配ブースティング・アルゴリズムを実装しており、Python で実装されています。

この記事で扱うPC環境は以下のとおりです。

| ソフトウエア     | バージョン                                                       |
| -------- | ----------------------------------------------------------- |
| SPSS Modeler | 18.3  on Windows 10                     |
| XGBoost on Scikit-learn   | 1.4.0 on Python 3.8 |

使うデータは[カリフォルニア住宅価格](https://scikit-learn.org/stable/datasets/real_world.html#california-housing-dataset
){:target="_blank"}です。Scikit-Learnの標準データセットです。

20640 rows × 9 columns　のサイズです。各々のカラムの意味は以下のとおりです。

- F0: (MedInc)median income in block-`収入の中央値`{:style="color: blue"} 
- F1: (HouseAge)median house age in block-`築年数の中央値`{:style="color: blue"} 
- F2: (AveRooms)average number of rooms-`平均部屋数`{:style="color: blue"} 
- F3: (AveBedrms)average number of bedrooms-`平均ベッドルーム数`{:style="color: blue"} 
- F4: (Population)block population-`人口`{:style="color: blue"} 
- F5: (AveOccup)average house occupancy-`平均住宅占有率`{:style="color: blue"} 
- F6: (Latitude)house block latitude-`家屋の緯度`{:style="color: blue"} 
- F7  (Longitude)house block longitude-`ハウスブロックの経度`{:style="color: blue"} 

目的変数はカリフォルニア地区の住宅価格で単位は10万ドルです。データセット自体は1990年の米国国勢調査(U.S. census) のもので、一行に国勢調査で使われるブロックグループ単位で集計されています。ブロックグループは米国国勢調査において、最小の地理的な単位です。概ね、600～3,000人を一つのグループにしています。　

世帯（household) は一つの住宅に居住する人数です。平均部屋数、ベッドルーム数はこの統計が世帯当たりで計算していますが、しばしばブロックグループ単位で計算すると「数世帯」と「多くの空き家」があるようなリゾート地では現実離れした大きな数字になる場合があります。それら大きな数字は外れ値としての処理が必要です。

![outliner]({{ "assets/img/2020_08_15/fig_0.png" | relative_url}})<br>

外れ値の求め方には色々な方法があります。代表的な方法は以下の二つです。　いずれも、SPSS Modeler でサポートされています。
1. 平均から標準偏差のn倍(例：3倍）を範囲外とする
2. 全体のnパーセンタイル（例：0.99)を超えるものを範囲外とする

ここでは、方法2の 99パーセンタイルで平準化した場合の分布イメージを載せます。

![99percentail]({{ "assets/img/2020_08_15/fig_99.png" | relative_url}})<br>

### ドメイン知識による次元削減

特徴量の抽出で重要なタスクはドメイン知識を持つ、データセット由来の業界知識・専門知識を持ついわゆる専門家からデータセットのカラムのうち、特徴量（説明変数）としては
適切で無いものを除外する事です。今回の不動産価格においてはその地理的座標は不要とのことなので、ブロックの地理的座標軸（経度:F6、緯度:F7）は除きます。

>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em"} <br>
上記が説明変数になりますが、このうちドメイン知識よりブロックの地理的座標軸（経度:F6、緯度:F7）は除きます。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

### ドメイン知識で除かれる経度:F6、緯度:F7のデータが与える影響を可視化する

経度:F6、緯度:F7を除く前のXGBoostによるFeature Imporanceの計算をPythonで行ない、経度:F6、緯度:F7の影響を見ておく事とします。
Code は以下の通りです。　とても簡単なコードですね。

{% highlight python %}
from sklearn.datasets import fetch_california_housing
import pandas as pd
import seaborn as sns
import xgboost as xgb
import matplotlib.pyplot as plt 
from pylab import rcParams
%matplotlib inline
rcParams['figure.figsize'] = 9,6

housing_array = fetch_california_housing()
x = housing_array.data
y = housing_array.target

xgb_model = xgb.XGBRegressor()
xgb_model.fit(x,y)

{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

特徴量を可視化します。左の図のとおり、経度:F6、緯度:F7は計算上は、住宅価格の決定要因としては、収入に次ぐ要因となっています。
それらを除外して再計算した結果を右側に並べて見るとその影響がよく分かりますね。

![feature_importance1]({{ "assets/img/2020_08_15/fig_3.png" | relative_url}})<br>


### Python (Sciki-Learn) vs SPSS Modeler 特徴量計算を比較する

次に同じデータセットでSPSS Modeler を使って計算します。　左がPythonで右がSPSS Modeler での計算結果です。 計算結果に少しだけ、差異があります。
Python では：
1. F0: (MedInc)median income in block-収入の中央値
2. F5: (AveOccup)average number of household members-平均世帯人数
3. F2: (AveRooms)average number of rooms-平均部屋数
と平均住宅占有率が２番目に大きな影響力があるとい結果でしたが

SPSS Modeler では：
1. F0: (MedInc)median income in block-収入の中央値
2. F2: (AveRooms)average number of rooms-平均部屋数
3. F5: (AveOccup)average number of household members-平均世帯人数
とPython では3番目の`平均部屋数`{:style="color: blue"} が２番目という結果でしたが、それ以外は同じ順位でした。


![feature_importance1]({{ "assets/img/2020_08_15/fig_5.png" | relative_url}})<br>

`＊SPSS Modelerでは、Feature をF1から始めて作図されます。本ブログではPythonとの比較のため、Python と同じようにF0からに変更しています。`{:style="background-color: #faf5d2; font-size: 0.82em"}

### SPSS Modeler ストリームと設定
SPSS Modeler 上でのストリームと設定の概要は以下のとおりです。

#### ストリーム画面
![SPSS_Modeler1]({{ "assets/img/2020_08_15/fig_6.png" | relative_url}})<br>

#### データ型ノードの設定
![SPSS_Modeler2]({{ "assets/img/2020_08_15/fig_7.png" | relative_url}})<br>

#### XGBoost Tree Pythonノードの作成オプション
![SPSS_Modeler3]({{ "assets/img/2020_08_15/fig_8.png" | relative_url}})<br>


>
`【考察】`{:style="color: blue; font-size: 1.3em"} <br>
カルフォルニアの住宅価格の決定要因としては
1. 収入(お金に余裕があるかどうか)　＞　部屋数（家の広さ）＞　平均世帯人数（何人暮らしか）
2. 築年数はさほど影響しない
3. 計算に使用したアルゴリズム XGBoostにおいてPython, SPSS ともほぼ同じ結論を導いている
{:style="background-color: #e0dff0; border-left: #e0dff0; font-size: 1.0em"}


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。
>
1) [Python API Reference](https://xgboost.readthedocs.io/en/stable/python/python_api.html){:target="_blank"}<br>
2) [XGBoost ツリー・ノード](https://www.ibm.com/docs/ja/spss-modeler/SaaS?topic=nodes-xgboost-tree-node){:target="_blank"}<br>
3) [特徴量選択（feature selection）方法３選〜Python](https://lunarwoffie.com/3feature-selection-algo-jp/){:target="_blank"}<br>
4) [Python ノード](https://www.ibm.com/docs/ja/spss-modeler/18.2.0?topic=help-python-nodes){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}
