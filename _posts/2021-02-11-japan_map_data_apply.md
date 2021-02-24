---
layout: post
title: 日本地図にデータをマップする
feature-img: "assets/img/2019_07_01/the-background-293017_1280.png"   
tags: [matplotlib, japanmap, statistics]
excerpt_separator: <!--more-->
---

都道府県別にまとめたデータを日本地図上にマップしてデータの持つ地理的な特性を可視化させたい事は多々あります。パワポの白地図にデータを転記するするでなく、直接Python から地図に描き出せれば、生産性がグンと向上します。それを簡単に実現させてくれる[japanmap](https://pypi.org/project/japanmap/){:target="_blank"}のパッケージをご紹介します。すでに、[県別データの可視化](https://qiita.com/SaitoTsutomu/items/6d17889ba47357e44131){:target="_blank"}としてqiitaでも紹介されています。総務省統計局が公表する[労働力調査](https://www.stat.go.jp/data/roudou/pref/index.html){:target="_blank"}から都道府県別完全失業率を地図にマップさせました。その際、気が付いたコメントを追記してブログにしました。先の紹介ページとともに参考にして頂ければと思います。

<!--more-->

---

### チートシート

| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| japanmap をインストールする                                  | `pip install -U japanmap`{:style="background: #ffebf6"}<br><br>`python 3.8もしくは3.9 でインストールする。3.7は不可`{:style="color: blue"}<br>``一緒に、Pillowとopencv-pythonがインストールされます``{:style="color: blue"}。 |
| 01.xlsxというexcel ファイルから必要なデータ<br>13行〜60行、2列目と8列目を抜き出してデータフレームを作成する | `xlsx = pd.ExcelFile('01.xlsx')`{:style="background: #ffebf6"}<br><br>`df = pd.read_excel(xlsx, '最新結果', index_col=0, header=11, usecols=[1, 7], skipfooter=11)`{:style="background: #ffebf6"}<br><br>`df.rename(columns= {'Unnamed: 7': '完全失業率'}, inplace =True)`{:style="background: #ffebf6"}<br>**読み込むEXCELファイルのフォーマットで変える必要があります。 |
| matplotlibのグラフをRetinaの高解像度で表示する               | `%config InlineBackend.figure_formats = {'png', 'retina'}`{:style="background: #ffebf6"} |
| Jupyter Notebookの中で作図した画像を表示させる<br>別ウィンドウでは表示させないようにする | `%matplotlib inline`{:style="background: #ffebf6"}           |
| 明度と彩度を増やし色合いで順序を表すシーケンシャルカラーマップを指定する   | `cmap = plt.get_cmap('YlOrBr')`{:style="background: #ffebf6"}<br>黄色からブラウンに増加させる<br> |
| Normalize関数を作り、値の大きさによって色合いを変化させる    | `norm = Normalize(vmin=data.min(), vmax=data.max())`{:style="background: #ffebf6"}<br><br>`print norm(1), norm(2), norm(3)`{:style="background: #ffebf6"}<br><br>`==>0.0 0.25 0.5`{:style="background:#cbe8f5"} |
| cmapで指定したシーケンシャルカラーマップに従った<br>#から始まる16進数コードを生成する関数を定義する<br>関数名：`unemp_col`{:style="background: #ffebf6"} | `unemp_col = lambda x: '#' + bytes(cmap(norm(x), bytes=True)[:3]).hex()`{:style="background: #ffebf6"} |





### 全体の流れ

大まかな手順を説明します。

>
1. [japanmap](https://github.com/SaitoTsutomu/japanmap){:target="_blank"}をインストールします
2. 総務省統計局から都道府県別の集計をダウンロードします。今回は、[2020年7〜9月期平均結果](https://www.stat.go.jp/data/roudou/pref/zuhyou/01.xlsx)を例として使います。
3. エクセルファイル`01.xlsx`から必要なデータ(13行〜60行、2列目と8列目)を抜き出してデータフレームとします。
4. 都道府県別の完全失業率をノーマライズしその値をベースに都道府県別に色をマップします
>


---

## japanmapをインストールします

{% highlight python linenos %}
% pip install -U japanmap
Collecting japanmap
  Downloading japanmap-0.0.23-py3-none-any.whl (167 kB)
     |████████████████████████████████| 167 kB 5.3 MB/s 
Collecting Pillow<8.0.0,>=7.1.1
  Downloading Pillow-7.2.0-cp37-cp37m-macosx_10_10_x86_64.whl (2.2 MB)
     |████████████████████████████████| 2.2 MB 7.6 MB/s 
Requirement already satisfied: numpy<2.0.0,>=1.18.2 in ./py37env/lib/python3.7/site-packages (from japanmap) (1.19.5)
Collecting opencv-python<5.0.0,>=4.2.0
  Downloading opencv_python-4.5.1.48-cp37-cp37m-macosx_10_13_x86_64.whl (40.3 MB)
     |████████████████████████████████| 40.3 MB 24.8 MB/s 
Installing collected packages: Pillow, opencv-python, japanmap
  Attempting uninstall: Pillow
    Found existing installation: Pillow 8.1.0
    Uninstalling Pillow-8.1.0:
      Successfully uninstalled Pillow-8.1.0
Successfully installed Pillow-7.2.0 japanmap-0.0.23 opencv-python-4.5.1.48
{% endhighlight %}

`pip list`{:style="background: #ffebf6"}コマンドでインストールされたパッケージのバージョンを確認します。

>
`(参考)`{:style="color: blue; font-size: 1.3em"} <br>
今回は、`japanmap`{:style="color: blue; font-size: 1.0em"}, `Pillow`{:style="color: blue; font-size: 1.0em"}, `opencv`{:style="color: blue; font-size: 1.0em"}に加えて EXCELを読み込むため定番パッケージの`xlrd`{:style="color: blue; font-size: 1.0em"}が必要となります。<br>
定番パッケージについては：<br>
[仮想環境にPIPで定番パッケージを導入する]({{ "2021/01/15/Install_numpy_pandas_tensorflow_by_pip.html" | relative_url}}){:target="_blank"}を参考にしてください。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}




{% highlight python linenos %}
% pip list
Package                Version
---------------------- ---------
absl-py                0.11.0
appnope                0.1.2
argon2-cffi            20.1.0
astunparse             1.6.3
async-generator        1.10
attrs                  20.3.0
backcall               0.2.0
bleach                 3.3.0
cachetools             4.2.1
certifi                2020.12.5
cffi                   1.14.4
chardet                4.0.0
cycler                 0.10.0
decorator              4.4.2
defusedxml             0.6.0
entrypoints            0.3
et-xmlfile             1.0.1
flatbuffers            1.12
gast                   0.3.3
google-auth            1.25.0
google-auth-oauthlib   0.4.2
google-pasta           0.2.0
grpcio                 1.32.0
h5py                   2.10.0
idna                   2.10
importlib-metadata     3.4.0
ipykernel              5.4.3
ipython                7.20.0
ipython-genutils       0.2.0
japanize-matplotlib    1.1.3
japanmap               0.0.23
jdcal                  1.4.1
jedi                   0.18.0
Jinja2                 2.11.3
joblib                 1.0.0
jsonschema             3.2.0
jupyter-client         6.1.11
jupyter-core           4.7.1
jupyterlab-pygments    0.1.2
Keras-Preprocessing    1.1.2
kiwisolver             1.3.1
Markdown               3.3.3
MarkupSafe             1.1.1
matplotlib             3.3.4
mistune                0.8.4
nbclient               0.5.1
nbconvert              6.0.7
nbformat               5.1.2
nest-asyncio           1.5.1
notebook               6.2.0
numpy                  1.19.5
oauthlib               3.1.0
opencv-python          4.5.1.48
openpyxl               3.0.6
opt-einsum             3.3.0
packaging              20.9
pandas                 1.2.1
pandocfilters          1.4.3
parso                  0.8.1
pexpect                4.8.0
pickleshare            0.7.5
Pillow                 7.2.0
pip                    21.0.1
prometheus-client      0.9.0
prompt-toolkit         3.0.14
protobuf               3.14.0
ptyprocess             0.7.0
pyasn1                 0.4.8
pyasn1-modules         0.2.8
pycparser              2.20
Pygments               2.7.4
pyparsing              2.4.7
pyrsistent             0.17.3
python-dateutil        2.8.1
pytz                   2021.1
pyzmq                  22.0.2
requests               2.25.1
requests-oauthlib      1.3.0
rsa                    4.7
scikit-learn           0.24.1
scipy                  1.6.0
seaborn                0.11.1
Send2Trash             1.5.0
setuptools             47.1.0
six                    1.15.0
tensorboard            2.4.1
tensorboard-plugin-wit 1.8.0
tensorflow             2.4.1
tensorflow-estimator   2.4.0
termcolor              1.1.0
terminado              0.9.2
testpath               0.4.4
threadpoolctl          2.1.0
tornado                6.1
traitlets              5.0.5
typing-extensions      3.7.4.3
urllib3                1.26.3
wcwidth                0.2.5
webencodings           0.5.1
Werkzeug               1.0.1
wheel                  0.36.2
wrapt                  1.12.1
xlrd                   2.0.1
zipp                   3.4.0
{% endhighlight %}

## ファイルを読み込みます。



総務省統計局から都道府県別の集計をダウンロードします。今回は、[2020年7〜9月期平均結果](https://www.stat.go.jp/data/roudou/pref/zuhyou/01.xlsx)を例として使います。読み込まれるEXCELファイル名は、 `01.xlsx` です。必要なデータ部分を確認するためにEXCELでオープンしてシート名、データのレイアウトを確認します。今回は、2列目と８列目でした。Pythonでは列番号が0から始まるため、それぞれマイナス１にして`usecol=[1,7]`と指定します。

同様に、13行目から北海道のデータが入り、59行目が沖縄県です。60行目から70行目までは、コメント等の不要なデータですのでそれらをスキップして読み込みます。

{% highlight python linenos %}
# ファイル名 01.xlsx をxlsx という変数で受けます 
xlsx = pd.ExcelFile('01.xlsx')
# シート名'最新結果'内のデータ12行目がヘッダーで、後ろか数えて１１行をスキップします。
# 列番号 1と7だけを使います。列番号1がデータフレームでは最初になるため、それを=columns 番号0をインデックスにします。
df = pd.read_excel(xlsx, '最新結果', index_col=0, header=11, usecols=[1, 7], skipfooter=11)
# 列番号7は、'Unnamed: 7'として読み込まれたため、列名を'完全失業率'と書き換えます
df.rename(columns= {'Unnamed: 7': '完全失業率'}, inplace =True)

# データフレームのシェイプと最初3行と最後のだけプリントします。
print(df.shape)
print(df.head(3))

{% endhighlight %}

結果は、以下の通りでした。

{% highlight python %}
(47, 1)
     完全失業率
北海道    2.7
青森県    2.9
岩手県    2.6

{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

## 日本地図上にマップします。

パッケージの導入、データの準備が整いましたので、いよいよ完全失業率データを該当する都道府県別に色分けしてマップします。

{% highlight python linenos %}
# matplotlibのグラフをRetinaの高解像度で表示する
%config InlineBackend.figure_formats = {'png', 'retina'}
# Jupyter Notebookの中で作図した画像を表示させる
%matplotlib inline
# matplotlib をインポートする
import matplotlib.pyplot as plt
# japanmap から日本地図と都道府県名をインポートする
from japanmap import picture
from japanmap import pref_names
# 図のサイズを12inch x 12inch = 864px X 864px にする
plt.rcParams['figure.figsize'] = 12, 12

# 日本語タイトルのため、seabornをインポートする
import seaborn as sns
# 日本語タイトルのため、japanizeをインポートする
import japanize_matplotlib

# フォントをIPAGothicをセットする
sns.set(font='IPAGothic')
plt.rcParams['font.family'] = 'IPAexGothic'
# タイトルをつける
plt.title('2020年7～9月期完全失業率平均結果', pad=8, fontsize=20, color='blue')
# 白い編みかけ（グリッド）が出ないようにする
plt.grid(False)

# 明度と彩度を増やし色合いで順序を表すシーケンシャルカラーマップを指定する
# カラーセットとして、黄色からブラウンに変わる色'YlOrBr'を選ぶ
cmap = plt.get_cmap('YlOrBr')
# 完全失業率の最大と最小値でノーマライズし、変数normで受ける
norm = plt.Normalize(vmin=df.完全失業率.min(), vmax=df.完全失業率.max())
# lambda関数オブジェクト'unemp_col'で#ffffe5から#662505のHexCodeにする
unemp_col = lambda x: '#' + bytes(cmap(norm(x), bytes=True)[:3]).hex()
# カラー尺度をつける
plt.colorbar(plt.cm.ScalarMappable(norm, cmap))
# 各都道府県に対して'unemp_col'でlambda関数を適用する
plt.imshow(picture(df.完全失業率.apply(unemp_col)));
# 描画した画像をカレントディレクトリにセーブする
plt.savefig('img_02_11.png')
{% endhighlight %}

#### 結果の図

以下のような図が描画されると思います。

![japan_map]({{ "assets/img/2019_07_01/img_02_11.png" | relative_url}})<br>

### 参照ページ一覧
日本地図へのマップにあたっては、必要に応じて以下のページを参考にしてください。
>
1) [日本語対応した_matplotlib_2軸グラフ]({{ "2021/02/02/japanize_matplotlib_two_axis.html" | relative_url}}){:target="_blank"}<br>
2) [仮想環境にPIPで定番パッケージを導入する]({{ "2021/01/15/Install_numpy_pandas_tensorflow_by_pip.html" | relative_url}}){:target="_blank"}<br>
3) [Python3.7と3.8両方を使うための仮想環境を作成する_(Mac_Big_Sur)]({{ "2021/01/08/multi-python-env.html" | relative_url}}){:target="_blank"}<br>
4) [japanmap](https://pypi.org/project/japanmap/){:target="_blank"}<br>
5) [総務省統計局_労働力調査（基本集計）都道府県別結果](https://www.stat.go.jp/data/roudou/pref/index.html){:target="_blank"}<br>
6) [シーケンシャルカラーマップ](https://matplotlib.org/3.1.3/tutorials/colors/colormaps.html#classes-of-colormaps){:target="_blank"}<br>
{:style="border-color: red; border-top-color: red; font-size: 1.0em; background-color: white;"}

