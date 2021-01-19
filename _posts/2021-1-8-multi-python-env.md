---
layout: post
title: Python3.7と3.8両方を使うための仮想環境を作成する (Mac Big Sur)
feature-img: "assets/img/2019_07_01/presents-1913987_1280.jpg"   
tags: [python, installation, Mac]
excerpt_separator: <!--more-->
---

### Python3.7と3.8 on macOS Big Sur

Python を使って開発では、目的や用途に応じて専用の実行環境を作成し、その実行環境内で使用します。Pythonでは一時的に作成する実行環境を、**「仮想環境」** として提供しています。　Python 仮想環境を使用して、パッケージのインストール先をシステムから分離して環境依存の問題を簡単に再現できます。　このブログでは macOS Big Sur にバージョンアップした際に再構築した仮想環境の手順をご紹介します。<!--more-->

#### チートシート

| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Homebrew をインストールする                                  | [Homebrew](https://brew.sh/index_ja){:target="_blank"}で最新のコマンドをコピペする         |
| 特定のPythonのバージョン(例3.7）をインストールする           | `brew install python@3.7`{:style="background: #ffebf6"}<br> @3.7を追加することでバージョンを指定できる |
| py37envという名前の仮想環境を作成する                      | `python3.7 -m venv py37env`{:style="background: #ffebf6"}<br>`mkdir` で任意のディレクトリを作成してその配下で行う |
| 作成した仮想環境(例 py37env)の中に入る<br>＝＞アクティベイトする | `. py38env/bin/activate`{:style="background: #ffebf6"}<br>先頭に`(py37env)`があることを確認すること |
| 仮想環境から出る<br>＝＞ディアクティベイトする               | `deactivate`{:style="background: #ffebf6"}<br>ディアクティベイトで、別の仮想環境の中に入ることができる |
| 最新のpip パッケージをインストールする<br>パッケージをインストールする前の必須手順です | `pip install --upgrade pip`{:style="background: #ffebf6"}                                  |



#### 全体の流れ

> １）コマンドラインデベロッパーツールを導入する
>
> 　　macOS をクリーンインストールしましたので、まずコマンドラインツールから導入します。
>
> ２）Homebrew をインストールする
>
> 　　3.7と3.8のPyhtonをMacOSのホームディレクトリインストールするためにMacバージョン管理のHomebrewをインストールします
>
> ３）仮想環境を作成する
>
> 　　py37envとpy38env という名前の仮想環境を作成します
>
> ４）tensorflow やjupyter notebook などのパッケージのインストール先を仮想環境として、MacOSホームディレクトリから分離してインストールします。



#### １）コマンドラインデベロッパーツールを導入する

ターミナルを起動して以下のようなコマンドを入力します

{% highlight python linenos %}
$ git --version
git version 2.13.6 (Apple Git-96)
{% endhighlight %}


コマンドラインデベロッパーツールがインストールされていないと、以下のような画面をがポップアップしますので、`インストールする`のボタンを押します。

![command]({{ "assets/img/2019_07_01/notification_cmd_too.png" | relative_url}})<br>


#### ２）Homebrew をインストールする

[Homebrew](https://brew.sh/index_ja){:target="_blank"}のホームページに行って、インストール用のコマンドがありますのでそれをホームディレクトリから入力します。ターミナルから`cd ~`を入力すると、 ホームディレクトリに戻ります。

{% highlight python linenos %}
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
{% endhighlight %}


以下のようにrootのパスワード（管理者権限でログインする際のパスワード）を聞いてきますので、それを入力すると、インストールが開始されます。

{% highlight python linenos %}
Password:　ここにMacのRootのパスワードを入れる
==> This script will install:
/usr/local/bin/brew
/usr/local/share/doc/homebrew

中略

From https://github.com/Homebrew/homebrew-core
 * [new branch]      master     -> origin/master
Updating files: 100% (5740/5740), done.
HEAD is now at de8bd53a32 netlify-cli: update 3.2.3 bottle.
==> Installation successful!

==> Homebrew has enabled anonymous aggregate formulae and cask analytics.
Read the analytics documentation (and how to opt-out) here:
  https://docs.brew.sh/Analytics
No analytics data has been sent yet (or will be during this `install` run).

==> Homebrew is run entirely by unpaid volunteers. Please consider donating:
  https://github.com/Homebrew/brew#donations

==> Next steps:
- Run `brew help` to get started
- Further documentation: 
    https://docs.brew.sh

{% endhighlight %}

#### ３）Python 3.7をインストールする

Python3.7 を導入しまが、まずPATHを通しておきます。　

次に**brew install python@3.7**と **3.7**とバージョンを明示します　以下がコマンド投入

{% highlight python linenos %}
$ export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
$ brew install python@3.7

Updating Homebrew...
==> Homebrew is run entirely by unpaid volunteers. Please consider donating:
  https://github.com/Homebrew/brew#donations
==> Auto-updated Homebrew!
Updated 1 tap (homebrew/core).
==> Updated Formulae
Updated 1 formula.

==> Downloading https://homebrew.bintray.com/bottles/gdbm-1.18.1_1.big_sur.bottle.tar.gz
==> Downloading from https://d29vzk4ow07wi7.cloudfront.net/36b492f1b0910367dd394cbdcffe1606f64ab41ec6701210becfb591a8557dee?response-content-dispo
######################################################################## 100.0%

中略

==> sqlite
sqlite is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have sqlite first in your PATH run:
  echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.zshrc

For compilers to find sqlite you may need to set:
  export LDFLAGS="-L/usr/local/opt/sqlite/lib"
  export CPPFLAGS="-I/usr/local/opt/sqlite/include"

==> python@3.7
Python has been installed as
  /usr/local/opt/python@3.7/bin/python3

{% endhighlight %}


`brew install python@3.7`としましたので、python3 と入力すると、3.7が起動されます。　今回は、3.8も導入したいので、リリースを起動時に明示できるよう以下のコマンドを投入します。

`ln -s /usr/local/opt/python@3.7/bin/python3.7 /usr/local/bin/python3.7`

**python3.7**と入力して3.7が起動されることを確認します。

{% highlight python linenos %}
python3.7
Python 3.7.9 (default, Nov 20 2020, 23:58:42) 
[Clang 12.0.0 (clang-1200.0.32.27)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
KeyboardInterrupt

>>> exit()
{% endhighlight %}

Python 3.7が起動されましたね。

#### ４）Python 3.7の仮想環境を作成する

py37envという仮想環境名で仮想環境を作成し、パッケージはシステムから切り離して、この仮想環境にインストールすることにします。

`mkdir project1` でホームディレクトリの配下にproject1 というディレクトリを作成します

仮想環境は、 `python3.7 -m venv py37env`で作成します。`. py37env/bin/activate`を投入して仮想環境アクティベイトして、仮想環境を利用できるようにします。

以下のログのとおり、アクティベイトして仮想環境の中に入ると`(py37env)` が先頭についてpy37envという仮想環境にいることがわかります。

{% highlight python linenos %}
. py37env/bin/activate
(py37env) ~/project1 sowi python3.7
Python 3.7.9 (default, Nov 20 2020, 23:58:42) 
[Clang 12.0.0 (clang-1200.0.32.27)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> exit()
(py37env) ~/project1 sowi deactivate
{% endhighlight %}


仮想環境から出るときには、上記のように`deactivate`コマンドを投入します。

#### ５）Python 3.7をインストールする

3.7と同様の手順で、python3.8 を導入します。 `cd ~`でホームディレクトリ戻り、Homebrewコマンドで3.8をホームディレクトリに導入します

{% highlight python linenos %}
~ brew install python@3.8
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 1 tap (homebrew/core).
==> Updated Formulae
Updated 2 formulae.

==> Downloading https://homebrew.bintray.com/bottles/python%403.8-3.8.7.big_sur.bottle.tar.gz
==> Downloading from https://d29vzk4ow07wi7.cloudfront.net/6b0d7c5a104db889edc53d303af10186b525c5c82efb9453aea864b578172ec1?response-content-dispo
######################################################################## 100.0%
==> Pouring python@3.8-3.8.7.big_sur.bottle.tar.gz

python@3.8 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.
{% endhighlight %}


`python3.8`と入力すれば、python 3.8が起動できるようにします

{% highlight python linenos %}
$ ln -s /usr/local/opt/python@3.8/bin/python3.8 /usr/local/bin/python3.8
$ python3.8

Python 3.8.7 (default, Dec 30 2020, 10:14:55) 
[Clang 12.0.0 (clang-1200.0.32.28)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
\>>> exit()
{% endhighlight %}

py38env というPython3.8の仮想環境を作成します。

{% highlight python linenos %}
$ cd project1
$ ~/project1 sowi python3.8 -m venv py38env
$ ~/project1 sowi . py38env/bin/activate
(py38env) ~/project1 sowi python3
Python 3.8.7 (default, Dec 30 2020, 10:14:55) 
[Clang 12.0.0 (clang-1200.0.32.28)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
\>>> exit()
(py38env) ~/project1 sowi deactivate
{% endhighlight %}

3.7と3.8 で別々の仮想環境を作成できました。　py38env をアクティベイトしてそこにpip パッケージのの最新バージョをインストールします。仮想環境へのインストールですから、システムとは分離されいろいろな開発環境を再現できるようになります。

{% highlight python linenos %}
$ ~/project1 sowi . py38env/bin/activate  
(py38env) ~/project1 sowi pip install --upgrade pip

Collecting pip
  Using cached pip-20.3.3-py2.py3-none-any.whl (1.5 MB)
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 20.2.3
    Uninstalling pip-20.2.3:
      Successfully uninstalled pip-20.2.3
Successfully installed pip-20.3.3
(py38env) ~/project1 sowi python3.8
Python 3.8.7 (default, Dec 30 2020, 10:14:55) 
[Clang 12.0.0 (clang-1200.0.32.28)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> exit()
{% endhighlight %}

