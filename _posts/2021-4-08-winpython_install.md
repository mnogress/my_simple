---
layout: post
title: WinPython でオフライン環境でPythonを使う
feature-img: "assets/img/2020_08_15/dogs-5941898_1280.jpg"   
tags: [WinPython, openpyxl, offline]
excerpt_separator: <!--more-->
---

新製品のテストデータや人事情報など機微な情報を扱う場合、多くの企業ではデータ流出の懸念からインターネット接続のない、いわゆるクローズドネットワークやスタンドアロンPCでPythonを使うことも少なくありません。 WinPythonでオフライン環境のPython開発環境構築されている方は少なく無いと思います。このBlogではWinPythonでの定番モジュールの追加のTips をまとめました。

<!--more-->

---


### WinPythonとは

PythonおよびWindow 用のPython 処理系とNumpy, Pandas, Scikit-learn, Tensorflow、Matplotlib などの主要な Python パッケージを１つにまとめポータブルアプリケーションとしてパッケージ化したソフトウェアです。

管理者権限でのアプリケーション導入の必要がありません。自己解凍形式(exeファイル)でまとめられているパッケージをサイトよりダウンロードして解凍するだけで使うことができます。ポータブルアプリケーションとして自己完結しておりOSと隔離して稼働が可能です。

### インストールはZIP解凍するだけ

[WinPython](https://winpython.github.io/){:target="_blank"} の最大の特徴は、自己解凍形式exeで圧縮されており好きなフォルダ配下でダブルクリックして解凍するだけの非常に簡単なインストールできてしまうところです。

不要となりアンインストールしたい時にはそのフォルダを削除するだけです。しかも、主要なパッケージが組み込まれているので　[Python3.7と3.8両方を使うための仮想環境を作成する_(Windows10)]({{ "2021/02/25/win10_multi_python_venv.html" | relative_url}}){:target="_blank"}や、[仮想環境にPIPで定番パッケージを導入する]({{ "2021/01/15/Install_numpy_pandas_tensorflow_by_pip.html" | relative_url}}){:target="_blank"}で紹介した手順でインターネット経由で各モジュールをダウンロード、インストールすることなく、解凍すればすぐに使えます。オフライン条件下のPython開発環境には持って来いのソフトウェアと言えます。

利用可能なPythonのバージョンは、3.3から3.10までラインナップされていますので、プロジェクト等での標準バージョンに合わせてダウンロードして環境を構築できます。個人的におすすめは3.8のTensorflow が入ったパッケージです。画面ショットを掲載します。

![winpython383]({{ "assets/img/2020_08_15/winpython383.png" | relative_url}})

460以上のパッケージが組み込まれており、以下の定番モジュールはすぐに使うことができます。[全リスト](https://github.com/winpython/winpython/blob/master/changelogs/WinPython-64bit-3.8.3.0.md){:target="_blank"}はGitHubのレポジトリから確認することができます。

| Name                                                      | Version    | Description                                        |
| --------------------------------------------------------- | ---------- | -------------------------------------------------- |
| [Python](http://www.python.org/)                          | 3.8.3      | Python 標準パッケージ（いわゆるBase)               |
| [flask](https://pypi.org/project/flask)                   | 1.1.2      | Web Applications フレームワーク                    |
| [jupyter](https://pypi.org/project/jupyter)               | 1.0.0      | Jupyter notebook (説明不要ですね)                  |
| [keras](https://pypi.org/project/keras)                   | 2.3.1      | TensorFlow上で動くニューラルネットワークライブラリ |
| [matplotlib](https://pypi.org/project/matplotlib)         | 3.2.1      | グラフ描画ライブラリ                               |
| [numpy](https://pypi.org/project/numpy)                   | 1.18.4+mkl | NumPy （説明不要ですね）mkl付です。                |
| [pandas](https://pypi.org/project/pandas)                 | 1.0.3      | Pandas （説明不要ですね）                          |
| [pip](https://pypi.org/project/pip)                       | 20.1.1     | Pythonパッケージインストールユーティリティ         |
| [scikit_learn](https://pypi.org/project/scikit_learn)     | 0.23.1     | 機械学習ライブラリ                                 |
| [tensorflow_cpu](https://pypi.org/project/tensorflow_cpu) | 2.2.0      | Google が公開したのDeep learning ライブラリ        |
| [xlrd](https://pypi.org/project/xlrd)                     | 1.2.0      | Microsoft Excel 読み込み・書き込みライブラリ       |



### オフライン環境でのライブラリの追加

主要なパッケージも同梱されており、すぐに使えて便利そうですが、使い込んでいくうちに、「当然ある」と思うようなパッケージや日本語化ライブラリが入っておらず、追加でライブラリをインストールする必要がどうしても出てきます。

`pip`コマンドがつかえますので、インターネット接続した環境であれば必要なモジュール名を指定すれば、依存関係を解いた上でインストールも問題なく行えます。

オフライン環境ではどうでしょうか。以下の手順がおすすめです。

> 1) インターネット接続した別のPC(オンラインPC)を用意する
>
> 2) オンラインPCから追加で必要はライブラリをダウンロードして、オフラインPCにUSB等で移動させておく
>
> 3) WinPython Control Panel から以下の動画のようにインストール

サンプルとしてopenpyxlを使えるようにした際の動画を載せています。参考にしてください。

動画を見てお気づきのとおり、openpyxl以外にjdcal とet_xml を一緒にインストールしないとインストールができません。注意してください。

![04_19_winpython_openpyxl_install3ea464f4.autosave4]({{ "assets/img/2020_08_15/04_19_winpython_openpyxl_install3ea464f4.autosave4.gif" | relative_url}})
<br>



---

### ひとこと

><p>WinPython は解凍するだけですぐに使えるターンキーソリューションです。オフライン環境での構築には威力を発揮します。しかし、オンライン環境では気にしなかったモジュールの依存関係、目的のモジュールとバンドルしてインストールされるモジュール等の管理のためには、オフライン環境とは別に、オンラインテスト環境での事前準備が必須になるかと思います。
