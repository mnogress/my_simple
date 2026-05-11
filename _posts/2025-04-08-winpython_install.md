---
layout: single
title:  WinPython でオフライン環境でPythonを使う
header:
  overlay_image: images/header_A5.png
  overlay_filter: rgba(107, 74, 43, 0.20)
toc: true
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
tag: [WinPython, openpyxl, offline]
category: Python
date: 2025-04-08
last_modified_at : 2026-04-02 09:00:00
excerpt: >
  機密性の高いデータ分析で求められるオフライン環境に最適な WinPython の導入方法をまとめたページです。ネット接続なしでは追加が難しいモジュールを、Control Panel を使ってインストールする手順を GIF つきでわかりやすく解説し、実務で安心して Python を使える環境づくりをサポートします。

---


新製品のテストデータや人事情報など機微な情報を扱う場合、多くの企業ではデータ流出の懸念からインターネット接続のない、いわゆるクローズドネットワークやスタンドアロンPCでPythonを使うことも少なくありません。 WinPythonでオフライン環境のPython開発環境構築されている方は少なく無いと思います。
<!--more-->
このBlogではWinPythonでの定番モジュールの追加のTips をまとめました。

<style type="text/css">
</style>


---


### WinPythonとは

PythonおよびWindow 用のPython 処理系とNumpy, Pandas, Scikit-learn, Tensorflow、Matplotlib などの主要な Python パッケージを１つにまとめポータブルアプリケーションとしてパッケージ化したソフトウェアです。

管理者権限でのアプリケーション導入の必要がありません。自己解凍形式(exeファイル)でまとめられているパッケージをサイトよりダウンロードして解凍するだけで使うことができます。ポータブルアプリケーションとして自己完結しておりOSと隔離して稼働が可能です。

### インストールはZIP解凍するだけ

[WinPython](https://winpython.github.io/){:target="_blank"} の最大の特徴は、自己解凍形式exeで圧縮されており好きなフォルダ配下でダブルクリックして解凍するだけの非常に簡単なインストールできてしまうところです。

不要となりアンインストールしたい時にはそのフォルダを削除するだけです。しかも、主要なパッケージが組み込まれているので　解凍すればすぐに使えます。オフライン条件下のPython開発環境には持って来いのソフトウェアと言えます。

利用可能なPythonのバージョンは、3.3から3.10までラインナップされていますので、プロジェクト等での標準バージョンに合わせてダウンロードして環境を構築できます。

460以上のパッケージが組み込まれており、以下の定番モジュールはすぐに使うことができます。[全リスト](https://github.com/winpython/winpython/blob/master/changelogs/WinPython-64bit-3.8.3.0.md){:target="_blank"}はGitHubのレポジトリから確認することができます。

<span class="bleu"><strong>WinPython64-3.8.30 (2020-02-May)</strong></span>

| Name                                                      | Version    | Description                                        |
| :----- | :-----  | :-----  |
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
{: style="font-size:0.80em;"}


### オフライン環境でのライブラリの追加

主要なパッケージも同梱されており、すぐに使えて便利そうですが、使い込んでいくうちに、「当然ある」と思うようなパッケージや日本語化ライブラリが入っておらず、追加でライブラリをインストールする必要がどうしても出てきます。

インターネット接続した環境であれば<strong>pip</strong>コマンドで必要なモジュール名を指定すれば、依存関係を解いた上でインストールも問題なく行えます。

オフライン環境ではどうでしょうか。以下の手順がおすすめです。

<div class="box33">
    <span class="box-title">おすすめ手順</span>
  <ol>  
<li>インターネット接続した別のPC(オンラインPC)を用意する</li>
<li>オンラインPCから追加で必要はライブラリをダウンロードして、オフラインPCにUSB等で移動させておく</li>
<li>WinPython Control Panel から以下の動画のようにインストール</li>
 </ol>
</div>


・サンプルとしてopenpyxlを使えるようにした際の動画を載せています。参考にしてください。<br>
・動画を見てお気づきのとおり、openpyxl以外にjdcal とet_xml を一緒にインストールしないとインストールができません。注意してください。
{: .notice--danger}


### サンプル動画　- openpyxl - のインストール
![winpython_openpyxl]({{ "/images/img/04_19_winpython_openpyxl_install3ea464f4.autosave4.gif" | relative_url}}){:height="600px" width="600px"}

---

### ひとこと
WinPython は、解凍するだけですぐに使える手軽なターンキー環境であり、特にオフライン環境での構築に大きな力を発揮します。
ただし実務では、オンライン環境では意識しなくてよかった **モジュール同士の依存関係**や、**目的のモジュールと一緒に自動的にインストールされるパッケージの整理**が必要になります。
そのため、完全オフラインで運用する場合でも、事前にオンライン環境でテストし、必要なモジュール構成を確認しておくことが欠かせません。  
**オンラインで構成を固めてから WinPython に反映する**ことで、オフライン環境でも安定した Python 実行環境を維持できます
{: .notice--warning}