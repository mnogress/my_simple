---
layout: post
title: 仮想環境にPIPで定番パケージ（Numpy, Pandas, Tensorflow）を導入する
feature-img: "assets/img/2019_07_01/background-2388586_1280.jpg"   
tags: [python, installation, Mac]
excerpt_separator: <!--more-->
---

### 仮想環境でNumpy, Pandas, Matplotbib , JupyterNotebook をインストールする

[先日のブログ]({{ "2021/01/08/multi-python-env.html" | relative_url}}){:target="_blank"}で**「仮想環境」** の作成をご紹介しました。Python 仮想環境を作成すれば、パッケージのインストール先をシステムから分離できます。<!--more-->　scikit learn やtensorflowなどのAI系パッケージなど頻繁にアップデートされ、各パッケージの依存関係が複雑にからみあい、一からやり直すと方が早いケースがあります。　そんな時最初から仮想環境しておけば、別の仮想環境でアップデートするなど使い勝手いいことが多々あります。　このブログ作成した仮想環境への必要最低限インストールすべきパッケージのインストールログをメモしました。

#### チートシート

| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 作成した仮想環境(例 py37env)の中に入る<br/>＝＞アクティベイトする | `. py37env/bin/activate`{:style="background: #ffebf6"}<br/>先頭に`(py37env)`があることを確認すること |
| PIPを最新のバージョンにする                                  | `pip install --upgrade pip`{:style="background: #ffebf6"}<br>頻繁に`PIP`は更新されているので、おまじないのように最初に行う。<br>`Requirement already satisfied: pip in ./py37env/lib/python3.7/site-packages (20.3.3)`が出れば最新になっている |
| Jupyter Notebook を導入する                                  | `pip install notebook`{:style="background: #ffebf6"}         |
| Jupyter Notebook を起動させる<br>ターミナルはそのままです    | `nohup jupyter notebook > /dev/null 2>&1 &`{:style="background: #ffebf6"} |
| Numpyをインストールする                                      | `pip install numpy`{:style="background: #ffebf6"}<br>`Successfully installed numpy-1.19.5` で正常にインストールできたことを確認できます。 |
| Pandasをインストールする                                     | `pip install pandas`{:style="background: #ffebf6"}<br/>正常にインストールできると`Successfully installed pandas-1.2.1 pytz-2020.5`のようなメッセージが出ます。 |
| Matplotlibをインストールする                                 | `pip install matplotlib`{:style="background: #ffebf6"}<br/>正常にインストールできると、`Successfully installed cycler-0.10.0 kiwisolver-1.3.1 matplotlib-3.3.3 pillow-8.1.0`が出現します。 |
| EXCELファイルをread/writeできるようにする                    | `pip install openpyxl`{:style="background: #ffebf6"}<br/>`pip install xlrd`{:style="background: #ffebf6"}<br>の２つのパッケージをインストールします。 |
| Seabornをインストールする                                    | `pip install seaborn`{:style="background: #ffebf6"}<br/>`Successfully installed scipy-1.6.0 seaborn-0.11.1`が出現すれば、OK |
| Scikit-learnをインストールする                               | `pip install -U scikit-learn`{:style="background: #ffebf6"}<br>`Successfully installed joblib-1.0.0 scikit-learn-0.24.1 threadpoolctl-2.1.0`でOK |
| Tensorflowをインストールする                                 | `pip install --upgrade tensorflow`{:style="background: #ffebf6"}<br/>Kerasも一緒にインストールしてくれます。 |
| 現仮想環境に導入されたパッケージのリストを出す               | `pip list`{:style="background: #ffebf6"}<br/>                |
| 仮想環境から出る<br>＝＞ディアクティベイトする               | `deactivate`{:style="background: #ffebf6"}<br>ディアクティベイトで、別の仮想環境の中に入ることができる |



#### 全体の流れ

> **１）仮想環境に入ります**<br>すべての操作を仮想環境上で行います。仮想環境の作成方法については[こちらのブログ]({{ "2021/01/08/multi-python-env.html" | relative_url}}){:target="_blank"}を参照してください。
>
> **２）PIPを最新のバージョンにする**<br>パッケージのインストールは、PIPコマンドで行います。PIPコマンドは頻繁にアップデートされますので、導入前にはおまじないのつもりで`pip install --upgrade pip`を叩く癖をつけましょう。
>
> **３）定番のパッケージをPIPコマンドでインストールします**<br>Python操作のためのJupyter Notebook、配列計算のNumpy、データフレーム計算のPandas、可視化用のMatplotlibとSeaborn、EXCEL操作のためのOpenxlとXlrd、Deep Learning 用のTensorflow(一緒にKerasも導入されます）
>
> **４）PIP List コマンドでインストール内容を確認します**<br>各パッケージの関係をリスト出力しておきます。
>
> **５）仮想環境から出ます**<br>



#### インストールログ

py37envという仮想環境に入ります。pip list でこの環境に導入済みのパッケージリストを出力しますが、pip 20.1.1 が入っているだけです。pip 20.1.1が古く、20.3.3があるのでそれにアップグレードしてくださいというメッセージが出ます。

{% highlight python linenos %}
$  . py37env/bin/activate
(py37env) ~/project1 % pip list          
Package  Version
---------- -------
pip    20.1.1
setuptools 47.1.0
WARNING: You are using pip version 20.1.1; however, version 20.3.3 is available.
You should consider upgrading via the '/Users/%/project1/py37env/bin/python3.7 -m pip install --upgrade pip'　command.
{% endhighlight %}

PIPをアップグレードして、定番パッケージを導入します。

{% highlight python linenos %}
(py37env) ~/project1 %  pip install --upgrade pip
Requirement already satisfied: pip in ./py37env/lib/python3.7/site-packages (20.3.3)
Collecting pip
 Downloading pip-21.0-py3-none-any.whl (1.5 MB)
   |████████████████████████████████| 1.5 MB 5.9 MB/s 
Installing collected packages: pip
 Attempting uninstall: pip
  Found existing installation: pip 20.3.3
  Uninstalling pip-20.3.3:
   Successfully uninstalled pip-20.3.3
Successfully installed pip-21.0

# PIP バーションを確認する

(py37env) ~/project1 % pip --version
pip 21.0 from /Users/%/project1/py37env/lib/python3.7/site-packages/pip (python 3.7)

# Jupyte Notebook を導入する

(py37env) ~/project1 % pip install notebook
Collecting notebook
 Downloading notebook-6.2.0-py3-none-any.whl (9.5 MB)
   |████████████████████████████████| 9.5 MB 52 kB/s 
Collecting jupyter-client>=5.3.4
 Downloading jupyter_client-6.1.11-py3-none-any.whl (108 kB)

# 中略 #

  Running setup.py install for pandocfilters ... done
Successfully installed MarkupSafe-1.1.1 Send2Trash-1.5.0 appnope-0.1.2 argon2-cffi-20.1.0 async-generator-1.10 attrs-20.3.0 backcall-0.2.0 bleach-3.2.2 cffi-1.14.4 decorator-4.4.2 defusedxml-0.6.0 entrypoints-0.3 importlib-metadata-3.4.0 ipykernel-5.4.3 ipython-7.19.0 ipython-genutils-0.2.0 jedi-0.18.0 jinja2-2.11.2 jsonschema-3.2.0 jupyter-client-6.1.11 jupyter-core-4.7.0 jupyterlab-pygments-0.1.2 mistune-0.8.4 nbclient-0.5.1 nbconvert-6.0.7 nbformat-5.1.2 nest-asyncio-1.4.3 notebook-6.2.0 packaging-20.8 pandocfilters-1.4.3 parso-0.8.1 pexpect-4.8.0 pickleshare-0.7.5 prometheus-client-0.9.0 prompt-toolkit-3.0.13 ptyprocess-0.7.0 pycparser-2.20 pygments-2.7.4 pyparsing-2.4.7 pyrsistent-0.17.3 python-dateutil-2.8.1 pyzmq-21.0.1 six-1.15.0 terminado-0.9.2 testpath-0.4.4 tornado-6.1 traitlets-5.0.5 typing-extensions-3.7.4.3 wcwidth-0.2.5 webencodings-0.5.1 zipp-3.4.0

### Jupyter Notebookを起動する　　jupyter notebook とコマンド入力

(py37env) ~/project1 % jupyter notebook
[I 14:50:08.335 NotebookApp] ノートブックサーバは cookie secret を /Users/%/Library/Jupyter/runtime/notebook_cookie_secret に書き込みます
[I 14:50:09.303 NotebookApp] ローカルディレクトリからノートブックをサーブ: /Users/%/python
[I 14:50:09.303 NotebookApp] Jupyter Notebook 6.2.0 is running at:
[I 14:50:09.303 NotebookApp] http://localhost:8888/?token=bf5386c42381d969aee7b81d9137ad97ccb9650ae49e156a
[I 14:50:09.303 NotebookApp]  or http://127.0.0.1:8888/?token=bf5386c42381d969aee7b81d9137ad97ccb9650ae49e156a
[I 14:50:09.303 NotebookApp] サーバを停止し全てのカーネルをシャットダウンするには Control-C を使って下さい(確認をスキップするには2回)。
[C 14:50:09.320 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///Users/home/Library/Jupyter/runtime/nbserver-12445-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=bf5386c42381d969aee7b81d9137ad97ccb9650ae49e156a
     or http://127.0.0.1:8888/?token=bf5386c42381d969aee7b81d9137ad97ccb9650ae49e156a

## お馴染みのJupyter Notebook がデフォルトブラウザから立ち上がるのを確認する

**** ctrl+c を二度打って終了させる

^C[I 14:54:21.219 NotebookApp] 中断しました
ローカルディレクトリからノートブックをサーブ: /Users/home/python
0 個のアクティブなカーネル
Jupyter Notebook 6.2.0 is running at:
http://localhost:8888/?token=c9559b4c6d6048bb607c4b354ce4028395c8f70cdfd86134
 or http://127.0.0.1:8888/?token=c9559b4c6d6048bb607c4b354ce4028395c8f70cdfd86134
このノートブックサーバをシャットダウンしますか？ (y/[n])^C[C 14:54:21.483 NotebookApp] シグナル 2 を受信。停止します
[I 14:54:21.483 NotebookApp] Shutting down 0 kernels
[I 14:54:21.484 NotebookApp] Shutting down 0 terminals
(py37env) ~/python % 


# Numpyをインストールする

(py37env) ~/project1 % pip install numpy
Collecting numpy
 Downloading numpy-1.19.5-cp37-cp37m-macosx_10_9_x86_64.whl (15.6 MB)
   |████████████████████████████████| 15.6 MB 65 kB/s 
Installing collected packages: numpy
Successfully installed numpy-1.19.5

# Pandas をインストールする

(py37env) ~/project1 % pip install pandas
Collecting pandas
 Downloading pandas-1.2.1-cp37-cp37m-macosx_10_9_x86_64.whl (10.3 MB)
   |████████████████████████████████| 10.3 MB 67 kB/s 
Requirement already satisfied: python-dateutil>=2.7.3 in ./py37env/lib/python3.7/site-packages (from pandas) (2.8.1)
Requirement already satisfied: numpy>=1.16.5 in ./py37env/lib/python3.7/site-packages (from pandas) (1.19.5)
Collecting pytz>=2017.3
 Downloading pytz-2020.5-py2.py3-none-any.whl (510 kB)
   |████████████████████████████████| 510 kB 17.6 MB/s 
Requirement already satisfied: six>=1.5 in ./py37env/lib/python3.7/site-packages (from python-dateutil>=2.7.3->pandas) (1.15.0)
Installing collected packages: pytz, pandas
Successfully installed pandas-1.2.1 pytz-2020.5

# Matplotlibをインストールする

(py37env) ~/project1 % pip install matplotlib
Collecting matplotlib
 Downloading matplotlib-3.3.3-cp37-cp37m-macosx_10_9_x86_64.whl (8.5 MB)

# 中略

Installing collected packages: pillow, kiwisolver, cycler, matplotlib
Successfully installed cycler-0.10.0 kiwisolver-1.3.1 matplotlib-3.3.3 pillow-8.1.0

# Openyxlをインストールする

(py37env) ~/project1 % pip install openpyxl
Collecting openpyxl
 Downloading openpyxl-3.0.6-py2.py3-none-any.whl (242 kB)
   |████████████████████████████████| 242 kB 8.1 MB/s 
Collecting jdcal
 Downloading jdcal-1.4.1-py2.py3-none-any.whl (9.5 kB)
Collecting et-xmlfile
 Downloading et_xmlfile-1.0.1.tar.gz (8.4 kB)
Using legacy 'setup.py install' for et-xmlfile, since package 'wheel' is not installed.
Installing collected packages: jdcal, et-xmlfile, openpyxl
  Running setup.py install for et-xmlfile ... done
Successfully installed et-xmlfile-1.0.1 jdcal-1.4.1 openpyxl-3.0.6

# Xlrdをインストールする

(py37env) ~/project1 % pip install xlrd   
Collecting xlrd
 Downloading xlrd-2.0.1-py2.py3-none-any.whl (96 kB)
   |████████████████████████████████| 96 kB 2.6 MB/s 
Installing collected packages: xlrd
Successfully installed xlrd-2.0.1

# Seabornをインストールする

(py37env) ~/project1 % pip install seaborn  
Collecting seaborn
 Downloading seaborn-0.11.1-py3-none-any.whl (285 kB)
   |████████████████████████████████| 285 kB 5.6 MB/s 
Requirement already satisfied: pandas>=0.23 in ./py37env/lib/python3.7/site-packages (from seaborn) (1.2.1)

# 中略 

Requirement already satisfied: pytz>=2017.3 in ./py37env/lib/python3.7/site-packages (from pandas>=0.23->seaborn) (2020.5)
Installing collected packages: scipy, seaborn
Successfully installed scipy-1.6.0 seaborn-0.11.1

# Scikit-learnをインストールする

(py37env) ~/project1 % pip install -U scikit-learn
Collecting scikit-learn
 Downloading scikit_learn-0.24.1-cp37-cp37m-macosx_10_13_x86_64.whl (7.2 MB)
   |████████████████████████████████| 7.2 MB 67 kB/s 
Collecting joblib>=0.11
 Downloading joblib-1.0.0-py3-none-any.whl (302 kB)
   |████████████████████████████████| 302 kB 15.0 MB/s 
Requirement already satisfied: numpy>=1.13.3 in ./py37env/lib/python3.7/site-packages (from scikit-learn) (1.19.5)
Collecting threadpoolctl>=2.0.0
 Downloading threadpoolctl-2.1.0-py3-none-any.whl (12 kB)
Requirement already satisfied: scipy>=0.19.1 in ./py37env/lib/python3.7/site-packages (from scikit-learn) (1.6.0)
Installing collected packages: threadpoolctl, joblib, scikit-learn
Successfully installed joblib-1.0.0 scikit-learn-0.24.1 threadpoolctl-2.1.0

# Tensorflowをインストールする

(py37env) ~/project1 % pip install --upgrade tensorflow
Collecting tensorflow
 Downloading tensorflow-2.4.1-cp37-cp37m-macosx_10_11_x86_64.whl (173.9 MB)
   |████████████████████████████████| 173.9 MB 38 kB/s 
Collecting astunparse~=1.6.3
Successfully installed absl-py-0.11.0 astunparse-1.6.3 cachetools-4.2.0 certifi-2020.12.5 chardet-4.0.0 flatbuffers-1.12 gast-0.3.3 google-auth-1.24.0 google-auth-oauthlib-0.4.2 google-pasta-0.2.0 grpcio-1.32.0 h5py-2.10.0 idna-2.10 keras-preprocessing-1.1.2 markdown-3.3.3 oauthlib-3.1.0 opt-einsum-3.3.0 protobuf-3.14.0 pyasn1-0.4.8 pyasn1-modules-0.2.8 requests-2.25.1 requests-oauthlib-1.3.0 rsa-4.7 tensorboard-2.4.1 tensorboard-plugin-wit-1.8.0 tensorflow-2.4.1 tensorflow-estimator-2.4.0 termcolor-1.1.0 urllib3-1.26.2 werkzeug-1.0.1 wheel-0.36.2 wrapt-1.12.1
{% endhighlight %}

### 仮想環境下にインストールしたパッケージをリストする

`pip list`{:style="background: #ffebf6"} でインストールしたパッケージをリストします。


{% highlight python %}
(py37env) ~/project1 % pip list
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
openpyxl               3.0.6
opt-einsum             3.3.0
packaging              20.9
pandas                 1.2.1
pandocfilters          1.4.3
parso                  0.8.1
pexpect                4.8.0
pickleshare            0.7.5
Pillow                 8.1.0
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
(py37env) ~/roject1 % 
{% endhighlight %}
