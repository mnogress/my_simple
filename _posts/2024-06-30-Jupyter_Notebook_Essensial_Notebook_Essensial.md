---
layout: single
title: Jupyter NotebookでPandas 使う際の必須Coding集
header:
  overlay_image: images/header_I.png
  overlay_filter: rgba(107, 74, 43, 0.18)
toc: True
toc_label: "目次"
toc_icon: "heart" 
toc_sticky: True
excerpt_separator: <!--more-->
classes:
  - landing
  - dark-theme
  - wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
excerpt: >
  Jupyter Notebook を新規作成するときに毎回読み込んでいる、定番の初期設定コードをまとめたリファレンスです。NumPy・Pandas・Matplotlib など、分析作業で必ず使うモジュールを一度に準備できるよう整理しています。

---

<!--more-->
#### はじめに
Jupyter Notebook で新しいノートを作成するとき、毎回同じモジュールをインポートしたり、
表示設定を整えたりすることが多いと思います。特にデータ分析では、NumPy・Pandas・Matplotlib
などの基本的なライブラリを最初に読み込んでおくことで、作業をスムーズに始められます。

このページでは、Notebook を開いた直後に必ず実行している「定番の初期設定コード」をまとめています。
分析環境をすぐに整えられるよう、よく使うモジュールのロード、表示オプション、グラフ設定などを
ひとつのセルに集約しています。

日々の作業を効率化したい方や、Notebook のテンプレートを作りたい方にとって、
そのままコピーして使える実用的なリファレンスです。



#### 新規Notebook 作成際の必須Coding

{% highlight python linenos  %}

from IPython.display import display, HTML
display(HTML("<style>.container { width:100% !important; }</style>"))

# ライブラリを読み込む
import numpy as np
import pandas as pd
import seaborn as sns
import sqlite3
import openpyxl as xl
import win32com.client
import os
 
# matplotlibのグラフをRetinaの高解像度で表示する
%config InlineBackend.figure_formats = {'png', 'retina'}
# Jupyter Notebookの中で作図した画像を表示させる
%matplotlib inline
# matplotlib をインポートする
import matplotlib.pyplot as plt
# 図のサイズを12inch x 12inch = 864px X 864px にする
plt.rcParams['figure.figsize'] = 64, 9
# 日本語タイトルのため、japanizeをインポートする
import japanize_matplotlib
plt.rcParams['font.family'] = 'IPAexGothic'
#sns.set_style('whitegrid')

from pytz import timezone
from datetime import datetime

{% endhighlight %}
