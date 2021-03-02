---
layout: post
title: Python3.7と3.8両方を使うための仮想環境を作成する (Windows10)
feature-img: "assets/img/2019_07_01/guitars-2912447_1280.jpg"   
tags: [python, installation, Windows]
excerpt_separator: <!--more-->
---

### Python3.7と3.8 on Windows10

[Python3.7と3.8両方を使うための仮想環境を作成する_(Mac_Big_Sur)]({{ "2021/01/08/multi-python-env.html" | relative_url}}){:target="_blank"}
では、macOSでの方法をブログしましたが、Windows10でも同様に仮想化環境を構築して、運用はPython 3.7で開発は3.8もしくは3.9の環境で行う事は珍しくありません。
このように目的や用途に応じて専用の実行環境を作成し、その実行環境内で使用します。Python 仮想環境を使用して、パッケージのインストール先をシステムから分離して環境依存の問題を簡単に再現できます。　このブログでは Windows10 にanacondaを導入して、3.7と3.8の仮想環境構築の手順をご紹介します。<!--more-->

#### チートシート

| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| anaconda をインストールする                                  | [anaconda インストール](https://www.python.jp/install/anaconda/windows/install.html){:target="_blank"}のページにアクセスする<br><br>[anaconda個人エディション](https://www.anaconda.com/products/individual)の後方から該当するインストーラーをダウンロードする<br>`Python3.8`{:style="background: #ffebf6"}がベースとなります |
| anaconda のPython環境(コマンドプロンプト)を<br>専用メニューから起動する | `start `{:style="background: #ffebf6"} >>>>` Anaconda3 (64-bit)`{:style="background: #ffebf6"}  >>>>` Anaconda Prompt (anconda3)`{:style="background: #ffebf6"} |
| 一般のコマンドプロンプトからPythonを起動する                 | `start `{:style="background: #ffebf6"} >>>>` Anaconda3 (64-bit)`{:style="background: #ffebf6"}  >>>>` Anaconda Prompt (anconda3)`{:style="background: #ffebf6"}<br><br>`conda init`{:style="background: #ffebf6"}を`最初だけ投入する`{:style="color: orange"} |
| ベースのconda環境を有効にする<br>ベースはPython3.8です。     | `conda activate`{:style="background: #ffebf6"}<br><br>`(base)c:¥Users¥home> `    `先頭に、(base) がつく`{:style="color: orange"} |
| Pythonのバージョンを確認する<br>                             | ```(base)c:¥Users¥home>```　```python```{:style="background: #ffebf6"}<br><br>`Python 3.8.5 (default, Sep  3 2020, 21:29:08) [MSC v.1916 64 bit (AMD64)] :: Anaconda, Inc. on win32`{:style="color:gray"}<br/>`Type "help", "copyright", "credits" or "license" for more information.>>>>`{:style="color:gray"} |
| Python3.7の仮想環境をインストールする                        | `(base) PS C:\Users\home>` `conda create --name py37 python=3.7`{:style="background: #ffebf6"} |
| Python3.7の環境を有効にする                                  | `(base) PS C:\Users\home>`  `conda activate py37`{:style="background: #ffebf6"} |
| tensor flow 2.0を導入する                                    | `(py37) PS C:\Users\home>`  `conda install tensorflow=2.0`{:style="background: #ffebf6"}<br><br>`コマンド投入前に(py37)が先頭にあることを確認すること`{:style="color: red"} |
| 定番パッケージをインストールする<br>`jupyter notebook`<br>`numpy`<br>`matplotlib`<br>`openpyxl`<br>`xlrd`<br>`scikit-learn`<br>`seaborn`<br>`japabmap`<br>`japanize-matplotlib` | `(py37) PS C:\Users\home>`  `conda install notebook`{:style="background: #ffebf6"}<br><br>`(py37) PS C:\Users\home>` `conda install numpy`{:style="background: #ffebf6"}<br><br>` (py37) PS C:\Users\home>` `conda install matplotlib`{:style="background: #ffebf6"}<br/><br/>` (py37) PS C:\Users\home>` `conda install openpyxl`{:style="background: #ffebf6"}<br/><br/>` (py37) PS C:\Users\home>` `conda install xlrd`{:style="background: #ffebf6"}<br/><br/>` (py37) PS C:\Users\home>` `conda install scikit-learn`{:style="background: #ffebf6"}<br/><br/>`(py37) PS C:\Users\home>` `conda install seaborn`{:style="background: #ffebf6"}<br/><br/>`(py37) PS C:\Users\home>` `pip install japanmap`{:style="background: #ffebf6"}<br/><br/>`(py37) PS C:\Users\home>` `pip install japanize-matplotlib`{:style="background: #ffebf6"}<br/><br/> |



#### 全体の流れ

> **１）anacondaをインストールする**<br>インストーラーから導入する通常のアプリケーション導入です。　Python3.8がベースとしてインストールされます。<br>Python3.7をインストールするだけですね。
>
> **２）仮想環境を作成する**<br>baseとpy37 という名前の仮想環境を作成します
>
> **３）定番パッケージをインストールする**<br>tensorflow やjupyter notebook などのパッケージのインストール先をpy37に導入します



#### １）anacondaを導入する

[anaconda インストール](https://www.python.jp/install/anaconda/windows/install.html){:target="_blank"}のページにアクセスします。<br><br>[anaconda個人エディション](https://www.anaconda.com/products/individual)のページの後方に該当するWindows、通常は64bitのインストーラーをダウンロードしてダブルクリック、その後は画面の指示通り進めば完了です。<br>

#### １.２）anaconda のPython環境(コマンドプロンプト)を専用メニューから起動する

`start`{:style="background: #ffebf6"} >>>> `Anaconda3 (64-bit)`{:style="background: #ffebf6"} >>>> `Anaconda Prompt (anconda3)`{:style="background: #ffebf6"}で以下のような画面をがポップアップしますので、`Anaconda Prompt (anaconda3)`を選択します。

![command]({{ "assets/img/2019_07_01/start_menue.png" | relative_url}})<br>


#### ２）仮想環境を作成する


以下のように`conda create --name py37 python=3.7`を入力すると、導入パッケージが表示され、`y`とすると画面が変わりインストールが開始されます。

{% highlight python linenos %}
(base) PS C:\Users\home> conda create --name py37 python=3.7
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - python=3.7


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    ca-certificates-2021.1.19  |       haa95532_0         122 KB
    certifi-2020.12.5          |   py37haa95532_0         141 KB
    openssl-1.1.1j             |       h2bbff1b_0         4.8 MB
    pip-21.0.1                 |   py37haa95532_0         1.8 MB
    python-3.7.10              |       h6244533_0        14.5 MB
    setuptools-52.0.0          |   py37haa95532_0         711 KB
    vc-14.2                    |       h21ff451_1           8 KB
    vs2015_runtime-14.27.29016 |       h5e58377_2        1007 KB
    wheel-0.36.2               |     pyhd3eb1b0_0          33 KB
    wincertstore-0.2           |           py37_0          14 KB
    ------------------------------------------------------------
                                           Total:        23.0 MB

The following NEW packages will be INSTALLED:

  ca-certificates    pkgs/main/win-64::ca-certificates-2021.1.19-haa95532_0
  certifi            pkgs/main/win-64::certifi-2020.12.5-py37haa95532_0
  openssl            pkgs/main/win-64::openssl-1.1.1j-h2bbff1b_0
  pip                pkgs/main/win-64::pip-21.0.1-py37haa95532_0
  python             pkgs/main/win-64::python-3.7.10-h6244533_0
  setuptools         pkgs/main/win-64::setuptools-52.0.0-py37haa95532_0
  sqlite             pkgs/main/win-64::sqlite-3.33.0-h2a8f88b_0
  vc                 pkgs/main/win-64::vc-14.2-h21ff451_1
  vs2015_runtime     pkgs/main/win-64::vs2015_runtime-14.27.29016-h5e58377_2
  wheel              pkgs/main/noarch::wheel-0.36.2-pyhd3eb1b0_0
  wincertstore       pkgs/main/win-64::wincertstore-0.2-py37_0
  zlib               pkgs/main/win-64::zlib-1.2.11-h62dcd97_4

{% endhighlight %}

#### ３）定番パッケージをインストールする

以下がコマンド投入ログです。

{% highlight python linenos %}

(base) PS C:\Users\home> conda activate py37
(py37) PS C:\Users\home> conda install tensorflow=2.0
Collecting package metadata (current_repodata.json): done
Solving environment: failed with initial frozen solve. Retrying with flexible solve.
Collecting package metadata (repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - tensorflow=2.0


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _tflow_select-2.2.0        |            eigen           3 KB
    absl-py-0.11.0             |     pyhd3eb1b0_1         103 KB
    aiohttp-3.7.4              |   py37h2bbff1b_1         507 KB
    astor-0.8.1                |   py37haa95532_0          47 KB
    async-timeout-3.0.1        |   py37haa95532_0          14 KB
    blinker-1.4                |   py37haa95532_0          23 KB
    brotlipy-0.7.0             |py37h2bbff1b_1003         337 KB
    cachetools-4.2.1           |     pyhd3eb1b0_0          13 KB
    cffi-1.14.5                |   py37hcd4344a_0         220 KB
    chardet-3.0.4              |py37haa95532_1003         192 KB
    click-7.1.2                |     pyhd3eb1b0_0          64 KB
    coverage-5.4               |   py37h2bbff1b_2         276 KB
    cryptography-3.3.1         |   py37hcd4344a_1         542 KB
    cython-0.29.22             |   py37hd77b12b_0         1.7 MB
    gast-0.2.2                 |           py37_0         155 KB
    google-auth-1.27.0         |     pyhd3eb1b0_0          72 KB
    google-auth-oauthlib-0.4.2 |     pyhd3eb1b0_2          18 KB
    google-pasta-0.2.0         |             py_0          46 KB
    grpcio-1.35.0              |   py37hc60d5dd_1         1.7 MB
    h5py-2.10.0                |   py37h5e291fa_0         808 KB
    idna-2.10                  |     pyhd3eb1b0_0          52 KB
    keras-applications-1.0.8   |             py_1          29 KB
    keras-preprocessing-1.1.2  |     pyhd3eb1b0_0          35 KB
    libprotobuf-3.14.0         |       h23ce68f_0         1.9 MB
    markdown-3.3.4             |   py37haa95532_0         144 KB
    mkl-service-2.3.0          |   py37h196d8e1_0          45 KB
    mkl_fft-1.3.0              |   py37h46781fe_0         131 KB
    mkl_random-1.1.1           |   py37h47e9c7a_0         233 KB
    multidict-5.1.0            |   py37h2bbff1b_2          85 KB
    numpy-1.19.2               |   py37hadc3359_0          22 KB
    numpy-base-1.19.2          |   py37ha3acd2a_0         3.8 MB
    oauthlib-3.1.0             |             py_0          91 KB
    opt_einsum-3.1.0           |             py_0          54 KB
    protobuf-3.14.0            |   py37hd77b12b_1         240 KB
    pyasn1-0.4.8               |             py_0          57 KB
    pyasn1-modules-0.2.8       |             py_0          72 KB
    pyjwt-1.7.1                |           py37_0          49 KB
    pyopenssl-20.0.1           |     pyhd3eb1b0_1          49 KB
    pyreadline-2.1             |           py37_1         143 KB
    pysocks-1.7.1              |           py37_1          28 KB
    requests-2.25.1            |     pyhd3eb1b0_0          52 KB
    requests-oauthlib-1.3.0    |             py_0          23 KB
    rsa-4.7.2                  |     pyhd3eb1b0_1          28 KB
    scipy-1.6.1                |   py37h14eb087_0        12.9 MB
    six-1.15.0                 |   py37haa95532_0          51 KB
    tensorboard-2.3.0          |     pyh4dce500_0         5.2 MB
    tensorboard-plugin-wit-1.6.0|             py_0         630 KB
    tensorflow-2.0.0           |eigen_py37hbfc5123_0           4 KB
    tensorflow-base-2.0.0      |eigen_py37h01553b8_0        28.9 MB
    tensorflow-estimator-2.0.0 |     pyh2649769_0         250 KB
    termcolor-1.1.0            |   py37haa95532_1           9 KB
    typing-extensions-3.7.4.3  |       hd3eb1b0_0          12 KB
    typing_extensions-3.7.4.3  |     pyh06a4308_0          28 KB
    urllib3-1.26.3             |     pyhd3eb1b0_0         105 KB
    werkzeug-0.16.1            |             py_0         258 KB
    win_inet_pton-1.1.0        |   py37haa95532_0          35 KB
    wrapt-1.12.1               |   py37he774522_1          49 KB
    yarl-1.6.3                 |   py37h2bbff1b_0         151 KB
    ------------------------------------------------------------
                                           Total:        62.5 MB

The following NEW packages will be INSTALLED:

  _tflow_select      pkgs/main/win-64::_tflow_select-2.2.0-eigen
  absl-py            pkgs/main/noarch::absl-py-0.11.0-pyhd3eb1b0_1
  aiohttp            pkgs/main/win-64::aiohttp-3.7.4-py37h2bbff1b_1
  astor              pkgs/main/win-64::astor-0.8.1-py37haa95532_0
  async-timeout      pkgs/main/win-64::async-timeout-3.0.1-py37haa95532_0
  attrs              pkgs/main/noarch::attrs-20.3.0-pyhd3eb1b0_0
  blas               pkgs/main/win-64::blas-1.0-mkl
  blinker            pkgs/main/win-64::blinker-1.4-py37haa95532_0
  brotlipy           pkgs/main/win-64::brotlipy-0.7.0-py37h2bbff1b_1003
  cachetools         pkgs/main/noarch::cachetools-4.2.1-pyhd3eb1b0_0
  cffi               pkgs/main/win-64::cffi-1.14.5-py37hcd4344a_0
  chardet            pkgs/main/win-64::chardet-3.0.4-py37haa95532_1003
  click              pkgs/main/noarch::click-7.1.2-pyhd3eb1b0_0
  coverage           pkgs/main/win-64::coverage-5.4-py37h2bbff1b_2
  cryptography       pkgs/main/win-64::cryptography-3.3.1-py37hcd4344a_1
  cython             pkgs/main/win-64::cython-0.29.22-py37hd77b12b_0
  gast               pkgs/main/win-64::gast-0.2.2-py37_0
  google-auth        pkgs/main/noarch::google-auth-1.27.0-pyhd3eb1b0_0
  google-auth-oauth~ pkgs/main/noarch::google-auth-oauthlib-0.4.2-pyhd3eb1b0_2
  google-pasta       pkgs/main/noarch::google-pasta-0.2.0-py_0
  grpcio             pkgs/main/win-64::grpcio-1.35.0-py37hc60d5dd_1
  h5py               pkgs/main/win-64::h5py-2.10.0-py37h5e291fa_0
  hdf5               pkgs/main/win-64::hdf5-1.10.4-h7ebc959_0
  icc_rt             pkgs/main/win-64::icc_rt-2019.0.0-h0cc432a_1
  idna               pkgs/main/noarch::idna-2.10-pyhd3eb1b0_0
  importlib-metadata pkgs/main/noarch::importlib-metadata-2.0.0-py_1
  intel-openmp       pkgs/main/win-64::intel-openmp-2020.2-254
  keras-applications pkgs/main/noarch::keras-applications-1.0.8-py_1
  keras-preprocessi~ pkgs/main/noarch::keras-preprocessing-1.1.2-pyhd3eb1b0_0
  libprotobuf        pkgs/main/win-64::libprotobuf-3.14.0-h23ce68f_0
  markdown           pkgs/main/win-64::markdown-3.3.4-py37haa95532_0
  mkl                pkgs/main/win-64::mkl-2020.2-256
  mkl-service        pkgs/main/win-64::mkl-service-2.3.0-py37h196d8e1_0
  mkl_fft            pkgs/main/win-64::mkl_fft-1.3.0-py37h46781fe_0
  mkl_random         pkgs/main/win-64::mkl_random-1.1.1-py37h47e9c7a_0
  multidict          pkgs/main/win-64::multidict-5.1.0-py37h2bbff1b_2
  numpy              pkgs/main/win-64::numpy-1.19.2-py37hadc3359_0
  numpy-base         pkgs/main/win-64::numpy-base-1.19.2-py37ha3acd2a_0
  oauthlib           pkgs/main/noarch::oauthlib-3.1.0-py_0
  opt_einsum         pkgs/main/noarch::opt_einsum-3.1.0-py_0
  protobuf           pkgs/main/win-64::protobuf-3.14.0-py37hd77b12b_1
  pyasn1             pkgs/main/noarch::pyasn1-0.4.8-py_0
  pyasn1-modules     pkgs/main/noarch::pyasn1-modules-0.2.8-py_0
  pycparser          pkgs/main/noarch::pycparser-2.20-py_2
  pyjwt              pkgs/main/win-64::pyjwt-1.7.1-py37_0
  pyopenssl          pkgs/main/noarch::pyopenssl-20.0.1-pyhd3eb1b0_1
  pyreadline         pkgs/main/win-64::pyreadline-2.1-py37_1
  pysocks            pkgs/main/win-64::pysocks-1.7.1-py37_1
  requests           pkgs/main/noarch::requests-2.25.1-pyhd3eb1b0_0
  requests-oauthlib  pkgs/main/noarch::requests-oauthlib-1.3.0-py_0
  rsa                pkgs/main/noarch::rsa-4.7.2-pyhd3eb1b0_1
  scipy              pkgs/main/win-64::scipy-1.6.1-py37h14eb087_0
  six                pkgs/main/win-64::six-1.15.0-py37haa95532_0
  tensorboard        pkgs/main/noarch::tensorboard-2.3.0-pyh4dce500_0
  tensorboard-plugi~ pkgs/main/noarch::tensorboard-plugin-wit-1.6.0-py_0
  tensorflow         pkgs/main/win-64::tensorflow-2.0.0-eigen_py37hbfc5123_0
  tensorflow-base    pkgs/main/win-64::tensorflow-base-2.0.0-eigen_py37h01553b8_0
  tensorflow-estima~ pkgs/main/noarch::tensorflow-estimator-2.0.0-pyh2649769_0
  termcolor          pkgs/main/win-64::termcolor-1.1.0-py37haa95532_1
  typing-extensions  pkgs/main/noarch::typing-extensions-3.7.4.3-hd3eb1b0_0
  typing_extensions  pkgs/main/noarch::typing_extensions-3.7.4.3-pyh06a4308_0
  urllib3            pkgs/main/noarch::urllib3-1.26.3-pyhd3eb1b0_0
  werkzeug           pkgs/main/noarch::werkzeug-0.16.1-py_0
  win_inet_pton      pkgs/main/win-64::win_inet_pton-1.1.0-py37haa95532_0
  wrapt              pkgs/main/win-64::wrapt-1.12.1-py37he774522_1
  yarl               pkgs/main/win-64::yarl-1.6.3-py37h2bbff1b_0
  zipp               pkgs/main/noarch::zipp-3.4.0-pyhd3eb1b0_0


  (py37) PS C:\Users\home> pip list
Package                Version
---------------------- -------------------
absl-py                0.11.0
aiohttp                3.7.4
astor                  0.8.1
async-timeout          3.0.1
attrs                  20.3.0
blinker                1.4
brotlipy               0.7.0
cachetools             4.2.1
certifi                2020.12.5
cffi                   1.14.5
chardet                3.0.4
click                  7.1.2
coverage               5.4
cryptography           3.3.1
Cython                 0.29.22
gast                   0.2.2
google-auth            1.27.0
google-auth-oauthlib   0.4.2
google-pasta           0.2.0
grpcio                 1.35.0
h5py                   2.10.0
idna                   2.10
importlib-metadata     2.0.0
Keras-Applications     1.0.8
Keras-Preprocessing    1.1.2
Markdown               3.3.4
mkl-fft                1.3.0
mkl-random             1.1.1
mkl-service            2.3.0
multidict              5.1.0
numpy                  1.19.2
oauthlib               3.1.0
opt-einsum             3.1.0
pip                    21.0.1
protobuf               3.14.0
pyasn1                 0.4.8
pyasn1-modules         0.2.8
pycparser              2.20
PyJWT                  1.7.1
pyOpenSSL              20.0.1
pyreadline             2.1
PySocks                1.7.1
requests               2.25.1
requests-oauthlib      1.3.0
rsa                    4.7.2
scipy                  1.6.1
setuptools             52.0.0.post20210125
six                    1.15.0
tensorboard            2.3.0
tensorboard-plugin-wit 1.6.0
tensorflow             2.0.0
tensorflow-estimator   2.0.0
termcolor              1.1.0
typing-extensions      3.7.4.3
urllib3                1.26.3
Werkzeug               0.16.1
wheel                  0.36.2
win-inet-pton          1.1.0
wincertstore           0.2
wrapt                  1.12.1
yarl                   1.6.3
zipp                   3.4.0
(py37) PS C:\Users\home> conda install notebook
Collecting package metadata (current_repodata.json): done
Solving environment: failed with initial frozen solve. Retrying with flexible solve.
Solving environment: failed with repodata from current_repodata.json, will retry with next repodata source.
Collecting package metadata (repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - notebook


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    argon2-cffi-20.1.0         |   py37h2bbff1b_1          49 KB
    async_generator-1.10       |   py37h28b3542_0          40 KB
    backcall-0.2.0             |     pyhd3eb1b0_0          13 KB
    bleach-3.3.0               |     pyhd3eb1b0_0         113 KB
    colorama-0.4.4             |     pyhd3eb1b0_0          21 KB
    decorator-4.4.2            |     pyhd3eb1b0_0          12 KB
    defusedxml-0.6.0           |     pyhd3eb1b0_0          23 KB
    entrypoints-0.3            |           py37_0          12 KB
    ipykernel-5.3.4            |   py37h5ca1d4c_0         182 KB
    ipython-7.20.0             |   py37hd4e2768_1         995 KB
    ipython_genutils-0.2.0     |     pyhd3eb1b0_1          27 KB
    jedi-0.17.0                |           py37_0         776 KB
    jinja2-2.11.3              |     pyhd3eb1b0_0         101 KB
    jupyter_core-4.7.1         |   py37haa95532_0          85 KB
    markupsafe-1.1.1           |   py37hfa6e2cd_1          22 KB
    mistune-0.8.4              |py37hfa6e2cd_1001          55 KB
    nbclient-0.5.3             |     pyhd3eb1b0_0          62 KB
    nbconvert-6.0.7            |           py37_0         498 KB
    nbformat-5.1.2             |     pyhd3eb1b0_1          68 KB
    nest-asyncio-1.5.1         |     pyhd3eb1b0_0          10 KB
    notebook-6.2.0             |   py37haa95532_0         4.4 MB
    packaging-20.9             |     pyhd3eb1b0_0          37 KB
    pandocfilters-1.4.3        |   py37haa95532_1          14 KB
    parso-0.8.1                |     pyhd3eb1b0_0          69 KB
    pickleshare-0.7.5          |  pyhd3eb1b0_1003          13 KB
    prometheus_client-0.9.0    |     pyhd3eb1b0_0          45 KB
    pygments-2.8.0             |     pyhd3eb1b0_0         703 KB
    pyparsing-2.4.7            |     pyhd3eb1b0_0          59 KB
    pyrsistent-0.17.3          |   py37he774522_0          91 KB
    python-dateutil-2.8.1      |     pyhd3eb1b0_0         221 KB
    pywin32-227                |   py37he774522_1         5.5 MB
    pywinpty-0.5.7             |           py37_0          50 KB
    pyzmq-20.0.0               |   py37hd77b12b_1         393 KB
    send2trash-1.5.0           |     pyhd3eb1b0_1          14 KB
    terminado-0.9.2            |   py37haa95532_0          26 KB
    testpath-0.4.4             |     pyhd3eb1b0_0          85 KB
    tornado-6.1                |   py37h2bbff1b_0         592 KB
    traitlets-5.0.5            |     pyhd3eb1b0_0          81 KB
    webencodings-0.5.1         |           py37_1          19 KB
    zeromq-4.3.3               |       ha925a31_3         4.2 MB
    ------------------------------------------------------------
                                           Total:        19.6 MB

The following NEW packages will be INSTALLED:

  argon2-cffi        pkgs/main/win-64::argon2-cffi-20.1.0-py37h2bbff1b_1
  async_generator    pkgs/main/win-64::async_generator-1.10-py37h28b3542_0
  backcall           pkgs/main/noarch::backcall-0.2.0-pyhd3eb1b0_0
  bleach             pkgs/main/noarch::bleach-3.3.0-pyhd3eb1b0_0
  colorama           pkgs/main/noarch::colorama-0.4.4-pyhd3eb1b0_0
  decorator          pkgs/main/noarch::decorator-4.4.2-pyhd3eb1b0_0
  defusedxml         pkgs/main/noarch::defusedxml-0.6.0-pyhd3eb1b0_0
  entrypoints        pkgs/main/win-64::entrypoints-0.3-py37_0
  importlib_metadata pkgs/main/noarch::importlib_metadata-2.0.0-1
  ipykernel          pkgs/main/win-64::ipykernel-5.3.4-py37h5ca1d4c_0
  ipython            pkgs/main/win-64::ipython-7.20.0-py37hd4e2768_1
  ipython_genutils   pkgs/main/noarch::ipython_genutils-0.2.0-pyhd3eb1b0_1
  jedi               pkgs/main/win-64::jedi-0.17.0-py37_0
  jinja2             pkgs/main/noarch::jinja2-2.11.3-pyhd3eb1b0_0
  jsonschema         pkgs/main/noarch::jsonschema-3.2.0-py_2
  jupyter_client     pkgs/main/noarch::jupyter_client-6.1.7-py_0
  jupyter_core       pkgs/main/win-64::jupyter_core-4.7.1-py37haa95532_0
  jupyterlab_pygmen~ pkgs/main/noarch::jupyterlab_pygments-0.1.2-py_0
  libsodium          pkgs/main/win-64::libsodium-1.0.18-h62dcd97_0
  m2w64-gcc-libgfor~ pkgs/msys2/win-64::m2w64-gcc-libgfortran-5.3.0-6
  m2w64-gcc-libs     pkgs/msys2/win-64::m2w64-gcc-libs-5.3.0-7
  m2w64-gcc-libs-co~ pkgs/msys2/win-64::m2w64-gcc-libs-core-5.3.0-7
  m2w64-gmp          pkgs/msys2/win-64::m2w64-gmp-6.1.0-2
  m2w64-libwinpthre~ pkgs/msys2/win-64::m2w64-libwinpthread-git-5.0.0.4634.697f757-2
  markupsafe         pkgs/main/win-64::markupsafe-1.1.1-py37hfa6e2cd_1
  mistune            pkgs/main/win-64::mistune-0.8.4-py37hfa6e2cd_1001
  msys2-conda-epoch  pkgs/msys2/win-64::msys2-conda-epoch-20160418-1
  nbclient           pkgs/main/noarch::nbclient-0.5.3-pyhd3eb1b0_0
  nbconvert          pkgs/main/win-64::nbconvert-6.0.7-py37_0
  nbformat           pkgs/main/noarch::nbformat-5.1.2-pyhd3eb1b0_1
  nest-asyncio       pkgs/main/noarch::nest-asyncio-1.5.1-pyhd3eb1b0_0
  notebook           pkgs/main/win-64::notebook-6.2.0-py37haa95532_0
  packaging          pkgs/main/noarch::packaging-20.9-pyhd3eb1b0_0
  pandoc             pkgs/main/win-64::pandoc-2.11-h9490d1a_0
  pandocfilters      pkgs/main/win-64::pandocfilters-1.4.3-py37haa95532_1
  parso              pkgs/main/noarch::parso-0.8.1-pyhd3eb1b0_0
  pickleshare        pkgs/main/noarch::pickleshare-0.7.5-pyhd3eb1b0_1003
  prometheus_client  pkgs/main/noarch::prometheus_client-0.9.0-pyhd3eb1b0_0
  prompt-toolkit     pkgs/main/noarch::prompt-toolkit-3.0.8-py_0
  pygments           pkgs/main/noarch::pygments-2.8.0-pyhd3eb1b0_0
  pyparsing          pkgs/main/noarch::pyparsing-2.4.7-pyhd3eb1b0_0
  pyrsistent         pkgs/main/win-64::pyrsistent-0.17.3-py37he774522_0
  python-dateutil    pkgs/main/noarch::python-dateutil-2.8.1-pyhd3eb1b0_0
  pywin32            pkgs/main/win-64::pywin32-227-py37he774522_1
  pywinpty           pkgs/main/win-64::pywinpty-0.5.7-py37_0
  pyzmq              pkgs/main/win-64::pyzmq-20.0.0-py37hd77b12b_1
  send2trash         pkgs/main/noarch::send2trash-1.5.0-pyhd3eb1b0_1
  terminado          pkgs/main/win-64::terminado-0.9.2-py37haa95532_0
  testpath           pkgs/main/noarch::testpath-0.4.4-pyhd3eb1b0_0
  tornado            pkgs/main/win-64::tornado-6.1-py37h2bbff1b_0
  traitlets          pkgs/main/noarch::traitlets-5.0.5-pyhd3eb1b0_0
  wcwidth            pkgs/main/noarch::wcwidth-0.2.5-py_0
  webencodings       pkgs/main/win-64::webencodings-0.5.1-py37_1
  winpty             pkgs/main/win-64::winpty-0.4.3-4
  zeromq             pkgs/main/win-64::zeromq-4.3.3-ha925a31_3

  (py37) PS C:\Users\home> conda install numpy
Collecting package metadata (current_repodata.json): done
Solving environment: done

# All requested packages already installed.

(py37) PS C:\Users\home> conda install pandas
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - pandas


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    pandas-1.2.2               |   py37hf11a4ad_0         7.7 MB
    pytz-2021.1                |     pyhd3eb1b0_0         181 KB
    ------------------------------------------------------------
                                           Total:         7.8 MB

The following NEW packages will be INSTALLED:

  pandas             pkgs/main/win-64::pandas-1.2.2-py37hf11a4ad_0
  pytz               pkgs/main/noarch::pytz-2021.1-pyhd3eb1b0_0

  (py37) PS C:\Users\home> conda install matplotlib
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - matplotlib


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    cycler-0.10.0              |           py37_0          13 KB
    kiwisolver-1.3.1           |   py37hd77b12b_0          52 KB
    lz4-c-1.9.3                |       h2bbff1b_0         131 KB
    matplotlib-3.3.4           |   py37haa95532_0          27 KB
    matplotlib-base-3.3.4      |   py37h49ac443_0         5.1 MB
    olefile-0.46               |           py37_0          49 KB
    pillow-8.1.0               |   py37h4fa10fc_0         663 KB
    pyqt-5.9.2                 |   py37h6538335_2         3.3 MB
    sip-4.19.8                 |   py37h6538335_0         262 KB
    ------------------------------------------------------------
                                           Total:         9.5 MB

The following NEW packages will be INSTALLED:

  cycler             pkgs/main/win-64::cycler-0.10.0-py37_0
  freetype           pkgs/main/win-64::freetype-2.10.4-hd328e21_0
  icu                pkgs/main/win-64::icu-58.2-ha925a31_3
  jpeg               pkgs/main/win-64::jpeg-9b-hb83a4c4_2
  kiwisolver         pkgs/main/win-64::kiwisolver-1.3.1-py37hd77b12b_0
  libpng             pkgs/main/win-64::libpng-1.6.37-h2a8f88b_0
  libtiff            pkgs/main/win-64::libtiff-4.1.0-h56a325e_1
  lz4-c              pkgs/main/win-64::lz4-c-1.9.3-h2bbff1b_0
  matplotlib         pkgs/main/win-64::matplotlib-3.3.4-py37haa95532_0
  matplotlib-base    pkgs/main/win-64::matplotlib-base-3.3.4-py37h49ac443_0
  olefile            pkgs/main/win-64::olefile-0.46-py37_0
  pillow             pkgs/main/win-64::pillow-8.1.0-py37h4fa10fc_0
  pyqt               pkgs/main/win-64::pyqt-5.9.2-py37h6538335_2
  qt                 pkgs/main/win-64::qt-5.9.7-vc14h73c81de_0
  sip                pkgs/main/win-64::sip-4.19.8-py37h6538335_0
  tk                 pkgs/main/win-64::tk-8.6.10-he774522_0
  xz                 pkgs/main/win-64::xz-5.2.5-h62dcd97_0
  zstd               pkgs/main/win-64::zstd-1.4.5-h04227a9_0

done
(py37) PS C:\Users\home> pip list
Package                Version
---------------------- -------------------
absl-py                0.11.0
aiohttp                3.7.4
argon2-cffi            20.1.0
astor                  0.8.1
async-generator        1.10
async-timeout          3.0.1
attrs                  20.3.0
backcall               0.2.0
bleach                 3.3.0
blinker                1.4
brotlipy               0.7.0
cachetools             4.2.1
certifi                2020.12.5
cffi                   1.14.5
chardet                3.0.4
click                  7.1.2
colorama               0.4.4
coverage               5.4
cryptography           3.3.1
cycler                 0.10.0
Cython                 0.29.22
decorator              4.4.2
defusedxml             0.6.0
entrypoints            0.3
gast                   0.2.2
google-auth            1.27.0
google-auth-oauthlib   0.4.2
google-pasta           0.2.0
grpcio                 1.35.0
h5py                   2.10.0
idna                   2.10
importlib-metadata     2.0.0
ipykernel              5.3.4
ipython                7.20.0
ipython-genutils       0.2.0
jedi                   0.17.0
Jinja2                 2.11.3
jsonschema             3.2.0
jupyter-client         6.1.7
jupyter-core           4.7.1
jupyterlab-pygments    0.1.2
Keras-Applications     1.0.8
Keras-Preprocessing    1.1.2
kiwisolver             1.3.1
Markdown               3.3.4
MarkupSafe             1.1.1
matplotlib             3.3.4
mistune                0.8.4
mkl-fft                1.3.0
mkl-random             1.1.1
mkl-service            2.3.0
multidict              5.1.0
nbclient               0.5.3
nbconvert              6.0.7
nbformat               5.1.2
nest-asyncio           1.5.1
notebook               6.2.0
numpy                  1.19.2
oauthlib               3.1.0
olefile                0.46
opt-einsum             3.1.0
packaging              20.9
pandas                 1.2.2
pandocfilters          1.4.3
parso                  0.8.1
pickleshare            0.7.5
Pillow                 8.1.0
pip                    21.0.1
prometheus-client      0.9.0
prompt-toolkit         3.0.8
protobuf               3.14.0
pyasn1                 0.4.8
pyasn1-modules         0.2.8
pycparser              2.20
Pygments               2.8.0
PyJWT                  1.7.1
pyOpenSSL              20.0.1
pyparsing              2.4.7
pyreadline             2.1
pyrsistent             0.17.3
PySocks                1.7.1
python-dateutil        2.8.1
pytz                   2021.1
pywin32                227
pywinpty               0.5.7
pyzmq                  20.0.0
requests               2.25.1
requests-oauthlib      1.3.0
rsa                    4.7.2
scipy                  1.6.1
Send2Trash             1.5.0
setuptools             52.0.0.post20210125
six                    1.15.0
tensorboard            2.3.0
tensorboard-plugin-wit 1.6.0
tensorflow             2.0.0
tensorflow-estimator   2.0.0
termcolor              1.1.0
terminado              0.9.2
testpath               0.4.4
tornado                6.1
traitlets              5.0.5
typing-extensions      3.7.4.3
urllib3                1.26.3
wcwidth                0.2.5
webencodings           0.5.1
Werkzeug               0.16.1
wheel                  0.36.2
win-inet-pton          1.1.0
wincertstore           0.2
wrapt                  1.12.1
yarl                   1.6.3
zipp                   3.4.0
(py37) PS C:\Users\home>

(py37) PS C:\Users\home> conda install openpyxl
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - openpyxl


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    openpyxl-3.0.6             |     pyhd3eb1b0_0         159 KB
    ------------------------------------------------------------
                                           Total:         159 KB

The following NEW packages will be INSTALLED:

  et_xmlfile         pkgs/main/noarch::et_xmlfile-1.0.1-py_1001
  jdcal              pkgs/main/noarch::jdcal-1.4.1-py_0
  openpyxl           pkgs/main/noarch::openpyxl-3.0.6-pyhd3eb1b0_0


Proceed ([y]/n)?

done
(py37) PS C:\Users\home> conda install xlrd
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - xlrd


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    xlrd-2.0.1                 |     pyhd3eb1b0_0          90 KB
    ------------------------------------------------------------
                                           Total:          90 KB

The following NEW packages will be INSTALLED:

  xlrd               pkgs/main/noarch::xlrd-2.0.1-pyhd3eb1b0_0


Proceed ([y]/n)?

done
(py37) PS C:\Users\home> pip list
Package                Version
---------------------- -------------------
absl-py                0.11.0
aiohttp                3.7.4
argon2-cffi            20.1.0
astor                  0.8.1
async-generator        1.10
async-timeout          3.0.1
attrs                  20.3.0
backcall               0.2.0
bleach                 3.3.0
blinker                1.4
brotlipy               0.7.0
cachetools             4.2.1
certifi                2020.12.5
cffi                   1.14.5
chardet                3.0.4
click                  7.1.2
colorama               0.4.4
coverage               5.4
cryptography           3.3.1
cycler                 0.10.0
Cython                 0.29.22
decorator              4.4.2
defusedxml             0.6.0
entrypoints            0.3
et-xmlfile             1.0.1
gast                   0.2.2
google-auth            1.27.0
google-auth-oauthlib   0.4.2
google-pasta           0.2.0
grpcio                 1.35.0
h5py                   2.10.0
idna                   2.10
importlib-metadata     2.0.0
ipykernel              5.3.4
ipython                7.20.0
ipython-genutils       0.2.0
jdcal                  1.4.1
jedi                   0.17.0
Jinja2                 2.11.3
jsonschema             3.2.0
jupyter-client         6.1.7
jupyter-core           4.7.1
jupyterlab-pygments    0.1.2
Keras-Applications     1.0.8
Keras-Preprocessing    1.1.2
kiwisolver             1.3.1
Markdown               3.3.4
MarkupSafe             1.1.1
matplotlib             3.3.4
mistune                0.8.4
mkl-fft                1.3.0
mkl-random             1.1.1
mkl-service            2.3.0
multidict              5.1.0
nbclient               0.5.3
nbconvert              6.0.7
nbformat               5.1.2
nest-asyncio           1.5.1
notebook               6.2.0
numpy                  1.19.2
oauthlib               3.1.0
olefile                0.46
openpyxl               3.0.6
opt-einsum             3.1.0
packaging              20.9
pandas                 1.2.2
pandocfilters          1.4.3
parso                  0.8.1
pickleshare            0.7.5
Pillow                 8.1.0
pip                    21.0.1
prometheus-client      0.9.0
prompt-toolkit         3.0.8
protobuf               3.14.0
pyasn1                 0.4.8
pyasn1-modules         0.2.8
pycparser              2.20
Pygments               2.8.0
PyJWT                  1.7.1
pyOpenSSL              20.0.1
pyparsing              2.4.7
pyreadline             2.1
pyrsistent             0.17.3
PySocks                1.7.1
python-dateutil        2.8.1
pytz                   2021.1
pywin32                227
pywinpty               0.5.7
pyzmq                  20.0.0
requests               2.25.1
requests-oauthlib      1.3.0
rsa                    4.7.2
scipy                  1.6.1
Send2Trash             1.5.0
setuptools             52.0.0.post20210125
six                    1.15.0
tensorboard            2.3.0
tensorboard-plugin-wit 1.6.0
tensorflow             2.0.0
tensorflow-estimator   2.0.0
termcolor              1.1.0
terminado              0.9.2
testpath               0.4.4
tornado                6.1
traitlets              5.0.5
typing-extensions      3.7.4.3
urllib3                1.26.3
wcwidth                0.2.5
webencodings           0.5.1
Werkzeug               0.16.1
wheel                  0.36.2
win-inet-pton          1.1.0
wincertstore           0.2
wrapt                  1.12.1
xlrd                   2.0.1
yarl                   1.6.3
zipp                   3.4.0
(py37) PS C:\Users\home>

(py37) PS C:\Users\home> conda install -U scikit-learn
usage: conda-script.py [-h] [-V] command ...
conda-script.py: error: unrecognized arguments: -U
(py37) PS C:\Users\home> conda install scikit-learn
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - scikit-learn


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    joblib-1.0.1               |     pyhd3eb1b0_0         208 KB
    scikit-learn-0.24.1        |   py37hf11a4ad_0         4.7 MB
    ------------------------------------------------------------
                                           Total:         4.9 MB

The following NEW packages will be INSTALLED:

  joblib             pkgs/main/noarch::joblib-1.0.1-pyhd3eb1b0_0
  scikit-learn       pkgs/main/win-64::scikit-learn-0.24.1-py37hf11a4ad_0
  threadpoolctl      pkgs/main/noarch::threadpoolctl-2.1.0-pyh5ca1d4c_0


Proceed ([y]/n)?

(py37) PS C:\Users\home> pip install japanmap
Collecting japanmap
  Downloading japanmap-0.0.23-py3-none-any.whl (167 kB)
     |████████████████████████████████| 167 kB 3.3 MB/s
Collecting opencv-python<5.0.0,>=4.2.0
  Downloading opencv_python-4.5.1.48-cp37-cp37m-win_amd64.whl (34.9 MB)
     |████████████████████████████████| 34.9 MB 6.4 MB/s
Requirement already satisfied: numpy<2.0.0,>=1.18.2 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from japanmap) (1.19.2)
Collecting Pillow<8.0.0,>=7.1.1
  Downloading Pillow-7.2.0-cp37-cp37m-win_amd64.whl (2.1 MB)
     |████████████████████████████████| 2.1 MB ...
Installing collected packages: Pillow, opencv-python, japanmap
  Attempting uninstall: Pillow
    Found existing installation: Pillow 8.1.0
    Uninstalling Pillow-8.1.0:
      Successfully uninstalled Pillow-8.1.0
Successfully installed Pillow-7.2.0 japanmap-0.0.23 opencv-python-4.5.1.48
(py37) PS C:\Users\home>

(py37) PS C:\Users\home> conda install seaborn
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: C:\Users\home\anaconda3\envs\py37

  added / updated specs:
    - seaborn


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    seaborn-0.11.1             |     pyhd3eb1b0_0         212 KB
    ------------------------------------------------------------
                                           Total:         212 KB

The following NEW packages will be INSTALLED:

  seaborn            pkgs/main/noarch::seaborn-0.11.1-pyhd3eb1b0_0

(py37) PS C:\Users\home> pip install japanize-matplotlib
Collecting japanize-matplotlib
  Downloading japanize-matplotlib-1.1.3.tar.gz (4.1 MB)
     |████████████████████████████████| 4.1 MB 3.2 MB/s
Requirement already satisfied: matplotlib in c:\users\home\anaconda3\envs\py37\lib\site-packages (from japanize-matplotlib) (3.3.4)
Requirement already satisfied: python-dateutil>=2.1 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from matplotlib->japanize-matplotlib) (2.8.1)
Requirement already satisfied: pillow>=6.2.0 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from matplotlib->japanize-matplotlib) (7.2.0)
Requirement already satisfied: kiwisolver>=1.0.1 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from matplotlib->japanize-matplotlib) (1.3.1)
Requirement already satisfied: numpy>=1.15 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from matplotlib->japanize-matplotlib) (1.19.2)
Requirement already satisfied: cycler>=0.10 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from matplotlib->japanize-matplotlib) (0.10.0)
Requirement already satisfied: pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.3 in c:\users\home\anaconda3\envs\py37\lib\site-packages (from matplotlib->japanize-matplotlib) (2.4.7)
Requirement already satisfied: six in c:\users\home\anaconda3\envs\py37\lib\site-packages (from cycler>=0.10->matplotlib->japanize-matplotlib) (1.15.0)
Building wheels for collected packages: japanize-matplotlib
  Building wheel for japanize-matplotlib (setup.py) ... done
  Created wheel for japanize-matplotlib: filename=japanize_matplotlib-1.1.3-py3-none-any.whl size=4120274 sha256=b48ca99ffd08a6b9e3578b78bfa2cda7c785cf2b0d6e3e62859c9384341145dc
  Stored in directory: c:\users\home\appdata\local\pip\cache\wheels\83\97\6b\e9e0cde099cc40f972b8dd23367308f7705ae06cd6d4714658
Successfully built japanize-matplotlib
Installing collected packages: japanize-matplotlib
Successfully installed japanize-matplotlib-1.1.3
(py37) PS C:\Users\home>

{% endhighlight %}

