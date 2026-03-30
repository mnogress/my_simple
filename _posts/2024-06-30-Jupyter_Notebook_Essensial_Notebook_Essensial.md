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
  #- wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
---

Jupyter NotebookでPandas 使う際の必須Coding集<!--more-->


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
