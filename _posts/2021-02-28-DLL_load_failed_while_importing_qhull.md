---
layout: post
title: DLL load failed while importing qhull の対応方法について
feature-img: "assets/img/2019_07_01/header_image.jpg"   
tags: [seaborn, pip]
excerpt_separator: <!--more-->
---

オフラインpython環境で定番のパッケージの一つであるseabornをインポートしようとすると、`ImportError: DLL load failed while importing qhull: 指定されたモジュールが見つかりません。`{:style="color: blue"}が出てインポートできないというトラブルに遭遇しました。原因は一つに特定されず、原因に対応してなそれぞれの解決法があるとは思いますが、私が脱出できた方法をブログにまとめました。同じようなトラブルに遭遇した方々の参考になれば幸いです。


<!--more-->

#### 問題の所在

`import seaborn as sns`でseaborn をインポートしようとすると、以下のようなエラーでインポートできない。

{% highlight python linenos %}
----> 1 import seaborn as sns

~\WinPy_3_8_0\WPy64-3830\python-3.8.3.amd64\lib\site-packages\seaborn\__init__.py in <module>
      1 # Import seaborn objects
----> 2 from .rcmod import *  # noqa: F401,F403
      3 from .utils import *  # noqa: F401,F403
      4 from .palettes import *  # noqa: F401,F403
      5 from .relational import *  # noqa: F401,F403


ImportError: DLL load failed while importing qhull: 指定されたモジュールが見つかりません。

{% endhighlight %}

#### トラブルのきっかけとなったパッケージ追加作業

[Winpython](https://winpython.github.io/)  3.8.3 に対して[日本地図にデータをマップする]({{ "2021/02/11/japan_map_data_apply.html" | relative_url}}){:target="_blank"}で紹介した環境を構築しようとした

参考になった、[Webの記事](https://stackoverflow.com/questions/63613167/pycharm-error-dll-load-failed-while-importing-qhull-the-specified-module-could)では

**1) リプレースすべきモジュールが分かっているとして、正しいモジュールを再インストールする**<br>
**2) .pyc のキャッシュファイルを削除する**<br>
**3) 1), 2) でNGであれば、仮想環境を再作成し一からやり直す**<br>
としています。ヒントとなった部分の文章をそのまま転記します。

>Your question is too generic: there can be many reasons. My easiest and quick way to solve such class of problems (assuming you already checked the environment, and that you have relevant packages):<br><br>
>  ・remove all python cache (.pyc files)
> and if this doesn't solve the problem do:
>
>・copy the setting of your virtual environment (or conda environment)
>
>・delete the virtual environment (and then move or remove the remaining files)
>
>・create again the environment, with the packages you got from first point<br><br>
>Very often, with such procedures, you get again a working environment. It seems that on some updates, some files remain in the wrong place, and so the wrong version of a DLL is used, and it confuse python and windows, about inconsistent status.
>
>Sometime you may have segmentation fault in Python program, alternate to failed to load DLL error.
>
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}



確かに、このような状況に陥る前に、そのきっかけとなったパッケージの追加といった環境変更をしているはずですね。従って、問題となったモジュールを適切なバージョンに入れ替えるのはその通りだと思います。<br>
間違った場所をポイントするため、DLLが読み込まれない状況になり、ImportError: DLL load failed while importing qhullの例外を返してしまい、インポートができないということです。<br>
正しいモジュールが分かれば、それに入れ替えて、キャッシュファイルをクリアすれば解決するだろうということです。

#### 教訓１：仮想環境でパッケージの追加をテストし、安定してから本番(base)に導入

そもそも論として、パッケージの追加はモジュールの入れ替えが裏で行われて、このように突然、全然関係のない定番パッケージがインポートできなくなるというリスクがあります。これは、オープンソースの宿命です。このリスクから大切なpython環境を守るためにはやはり、仮想環境をいくつか作成して環境の変化が伴うパッケージの追加は、テスト環境で行うことが大切です。仮想化環境の作成については、以下のブログを参照してください。

>
>[Python3.7と3.8両方を使うための仮想環境を作成する_(Mac_Big_Sur)]({{ "2021/01/08/multi-python-env.html" | relative_url}})<br>
>[Python3.7と3.8両方を使うための仮想環境を作成する_(Windows10)]({{ "2021/02/25/win10_multi_python_venv.html" | relative_url}})<br>
>[仮想環境にPIPで定番パッケージを導入する]({{ "2021/01/15/Install_numpy_pandas_tensorflow_by_pip.html" | relative_url}}){:target="_blank"}
>
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}


#### 疑問１：パッケージのアンインストールで本当に解決するか？

一から再作成するのではなく、きっかけとなったパッケージのアンインストールではだめなのでしょうか？ <br>答えは、NO：アンインストールしただけでは、問題は解決しないと思います。　


`キャッシュが残るなどしてトラブルが継続されることがあり、再作成した方が解決の近道`{:style="color: blue"} 

>
>理由は、アンインストールしてキャッシュファイルを全て削除したつもりでも、何かしら残骸が存在してトラブルが継続されることがあります。キャッシュを全てクリアにするのであれば、結果的には再作成した方がいいというのが私の意見です。
>
{:style="background-color: #faebd7; border-left: #faebd7; font-size: 1.0em"}


`パッケージインストール自体が目的では無いため、トラブルに遭遇するまで、惰性でインストールし、原因となるモジュールの特定自体が難しい`{:style="color: blue"} 

>
パッケージのインストール自体も目的では無いため、パッケージの更新日、バージョンについて特に調べずに最新のパッケージを何も考えずに導入していたりしてそれからきっかけとなったパッケージを特定すること自体が結構、難しいことだと思います。
>
{:style="background-color: #faebd7; border-left: #faebd7; font-size: 1.0em"}


`数日後にトラブルに遭遇すると、何がきっかけだったかすら、想像できない`{:style="color: blue"} 

>
さらに、トラブルの発覚もパッケージインストール後、関連したモジュールのインポートで分かればまたラッキーで、数日経って、別のプログラムを起動した際に、このようなトラブルに遭遇すると、何がきっかけだったかすら、想像できないことも容易に想定されます。
>
{:style="background-color: #faebd7; border-left: #faebd7; font-size: 1.0em"}


#### 教訓2：Befor After のpip list を習慣化する

パッケージをインストール前後に `pip list` でモジュールのバージョンの変化を記録します。そして、再作成するときには、面倒でもパッケージの依存関係を確認して、何が悪さしたモジュールなのかを特定するのが結果的には早道だと思います。

#### 問題の解決

> 私が遭遇したトラブルでは:<br>
>１）問題を再現する目的で一から環境を作成し、モジュールの依存関係を洗い出す<br>
>２）再インストールの際、pip list でモジュールのバージョンをチェックし、原因となるモジュールを見つける。<br>
>３）その結果、opencv-pythonのバージョンを4.5.1.48から 4.2.0.32に変更し解決。<br>
>いい経験となりました。

以下が`WinPython`{:style="color: blue"}で問題をクリアしたPIPリストになります(一部）。

{% highlight python linenos %}
gmpy2                         2.0.8
google-auth                   1.14.3
google-auth-oauthlib          0.4.1
google-pasta                  0.2.0
gpytorch                      1.1.1
greenlet                      0.4.15
grpcio                        1.28.1
guidata                       1.7.7.dev1
h11                           0.9.0
h2                            3.2.0
h5py                          2.10.0
HeapDict                      1.0.1
helpdev                       0.7.1
holoviews                     1.13.2
hpack                         3.0.0
html5lib                      1.0.1
httpie                        2.1.0
hupper                        1.10.2
husl                          4.0.3
hvplot                        0.5.2
Hypercorn                     0.9.5
hyperframe                    5.2.0
hypothesis                    5.14.0
ibis-framework                1.3.0
idlex                         1.18
idna                          2.9
imagecodecs                   2020.2.18
imageio                       2.8.0
imageio-ffmpeg                0.4.2
imagesize                     1.2.0
imbalanced-learn              0.6.2
intake                        0.5.5
intervaltree                  3.0.2
ipykernel                     5.2.1
ipyleaflet                    0.12.6
ipympl                        0.5.6
ipyparallel                   6.3.0
ipython                       7.14.0
ipython-genutils              0.2.0
ipython-sql                   0.4.0
ipywidgets                    7.5.1
isort                         4.3.21
itsdangerous                  1.1.0
janus                         0.5.0
japanize-matplotlib           1.1.3
japanmap                      0.0.23
jedi                          0.17.0
Jinja2                        2.11.2
joblib                        0.15.1
json5                         0.9.3
jsonschema                    3.2.0
julia                         0.5.3
jupyter                       1.0.0
jupyter-client                6.1.3
jupyter-console               6.1.0
jupyter-core                  4.6.3
jupyter-server                0.1.1
jupyter-sphinx                0.2.3
jupyterlab                    2.1.2
jupyterlab-launcher           0.13.1
jupyterlab-pygments           0.1.1
jupyterlab-server             1.1.3
Keras                         2.3.1
Keras-Applications            1.0.8
Keras-Preprocessing           1.1.2
keras-vis                     0.4.1
keyring                       21.2.1
kiwisolver                    1.2.0
lazy-object-proxy             1.4.3
llvmlite                      0.32.1
lmfit                         1.0.1
locket                        0.2.0
loky                          2.8.0
lxml                          4.5.1
lz4                           3.0.2
Markdown                      3.2.2
MarkupSafe                    1.1.1
marshmallow                   3.6.0
matplotlib                    3.2.1
mccabe                        0.6.1
mercantile                    1.1.4
mergedeep                     1.3.0
metakernel                    0.24.4
mistune                       0.8.4
mizani                        0.6.0
mkl-service                   2.3.0
mlxtend                       0.17.2
monotonic                     1.5
more-itertools                8.3.0
moviepy                       1.0.3
mpl-scatter-density           0.6
mpld3                         0.3
mpldatacursor                 0.7.1
mpmath                        1.1.0
msgpack                       1.0.0
multipledispatch              0.6.0
multiprocess                  0.70.9
munch                         2.5.0
mypy                          0.770
mypy-extensions               0.4.3
mysql-connector-python        8.0.18
nbclient                      0.3.0
nbconvert                     5.6.1
nbconvert-reportlab           0.2
nbformat                      5.0.6
nest-asyncio                  1.3.3
netCDF4                       1.5.3
networkx                      2.4
NLopt                         2.6.2
nltk                          3.5
notebook                      6.0.3
numba                         0.49.1
numcodecs                     0.6.4
numdifftools                  0.9.39
numexpr                       2.7.1
numpy                         1.18.4+mkl
numpydoc                      0.9.2
oauthlib                      3.1.0
oct2py                        5.0.4
octave-kernel                 0.31.1
opencv-python                 4.2.0.32
opt-einsum                    3.2.1
osqp                          0.6.1
outcome                       1.0.1
packaging                     20.4
palettable                    3.3.0
pandas                        1.0.3
pandas-datareader             0.8.1
pandocfilters                 1.4.2
panel                         0.9.5
papermill                     2.1.1
param                         1.9.3
parambokeh                    0.2.3
paramiko                      2.7.1
paramnb                       2.0.4
parso                         0.7.0
partd                         1.1.0
passlib                       1.7.1
pathspec                      0.8.0
pathtools                     0.1.2
patsy                         0.5.1
pdfrw                         0.4
pdvega                        0.2.1.dev0
pefile                        2019.4.18
pep8                          1.7.1
pexpect                       4.8.0
pg8000                        1.13.1
pickleshare                   0.7.5
Pillow                        7.1.2
Pint                          0.11
pip                           20.1.1
pipdeptree                    0.13.2
pkginfo                       1.5.0.1
plotly                        4.7.1
plotnine                      0.6.0
pluggy                        0.13.1
ply                           3.11
portpicker                    1.3.1
ppci                          0.5.7
prettytable                   0.7.2
priority                      1.3.0
proglog                       0.1.9
prometheus-client             0.7.1
prompt-toolkit                3.0.5
protobuf                      3.11.3
psutil                        5.7.0
ptpython                      3.0.2
ptyprocess                    0.6.0
PuLP                          1.6.11
py                            1.8.1
pyaml                         20.4.0
pyarrow                       0.17.1
pyasn1                        0.4.8
pyasn1-modules                0.2.8
PyAudio                       0.2.11
pybars3                       0.9.7
pybind11                      2.5.0
pycodestyle                   2.6.0
pycosat                       0.6.3
pycparser                     2.20
pyct                          0.4.6
pydeck                        0.2.1
pyepsg                        0.4.0
{% endhighlight %}

