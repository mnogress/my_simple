---
layout: post
title: Python と SPSS Modeler で XGBoost の特徴量選択を比較する
feature-img: "assets/img/2020_08_15/circuit-board-6522546_1280.png"
tags: [Python, SPSS Modeler, XGBoost]
excerpt_separator: <!--more-->
---

特徴量選択（feature selection）＝どれを説明変数として使うかは、データ分析では重要です。実際のところドメイン知識が大きな力を発揮するため、データサイエンスに精通しないがドメイン知識をもつ専門家にもっと、モデルを作成してもらうためIBM のSPSS Modeler等の統計ソフトは大手企業、官公庁向の研究者やテータ分析担当者向けに導入が進んでいます。

<!--more-->
このBlogでは、特徴量選択についてXGBoostのアルゴリズムでSPSS Modeler の特徴量選択とPython Scikit-Learnの結果を比較してみたいと思います。

この記事で扱うPC環境は以下のとおりです。

| ソフトウエア     | バージョン                                                       |
| -------- | ----------------------------------------------------------- |
| SPSS Modeler | 18.3  on Windows 10                     |
| XGBoost on Scikit-learn   | 1.4.0 on Python 3.8 |

使うデータはカリフォルニア住宅価格です。Scikit-Learnの標準データセットです。
- F0: (MedInc)median income in block-`収入の中央値`{:style="color: blue"} 
- F1: (HouseAge)median house age in block-`築年数の中央値`{:style="color: blue"} 
- F2: (AveRooms)average number of rooms-`平均部屋数`{:style="color: blue"} 
- F3: (AveBedrms)average number of bedrooms-`平均ベッドルーム数`{:style="color: blue"} 
- F4: (Population)block population-`人口`{:style="color: blue"} 
- F5: (AveOccup)average house occupancy-`平均住宅占有率`{:style="color: blue"} 
- F6: (Latitude)house block latitude-`家屋の緯度`{:style="color: blue"} 
- F7  (Longitude)house block longitude-`ハウスブロックの経度`{:style="color: blue"} 

>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em"} <br>
上記が説明変数になりますが、このうちドメイン知識より家の座標軸（経度:F6、緯度:F7）は除きます。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

### 経度:F6、緯度:F7のデータが与える影響を可視化する

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

>
`【考察】`{:style="color: blue; font-size: 1.3em"} <br>
カルフォルニアの住宅価格の決定要因としては
1. 収入(お金に余裕があるかどうか)　＞　部屋数（家の広さ）＞　平均世帯人数（何人暮らしか）
2. 築年数はさほど影響しない
3. 計算に使用したアルゴリズム XGBoost
{:style="background-color: #e0dff0; border-left: #e0dff0; font-size: 1.0em"}


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。
>
1) [Python API Reference](https://xgboost.readthedocs.io/en/stable/python/python_api.html){:target="_blank"}<br>
2) [XGBoost ツリー・ノード](https://www.ibm.com/docs/ja/spss-modeler/SaaS?topic=nodes-xgboost-tree-node){:target="_blank"}<br>
3) [特徴量選択（feature selection）方法３選〜Python](https://lunarwoffie.com/3feature-selection-algo-jp/){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}
