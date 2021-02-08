---
layout: post
title: Jekyll 4.2.0 で静的サイトを作成する
feature-img: "assets/img/2019_07_01/pineapple-4772144_1280.jpg"   
tags: [jekyll, installation, Mac]
excerpt_separator: <!--more-->
---

[Jekyll（ジキル）](http://jekyllrb-ja.github.io/){:target="_blank"}は、SSGの中では最も人気があります。
SSGの中では、最大級のユーザとプラグインを有しています。当サイトもJekyll で作成されています。Jekyllの導入から公開までの道のりを最新Jekyll の導入を動画を交えて紹介します。<!--more-->

* TOC
{:toc}

### チートシート

| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Homebrew をホームディレクトリにインストールする              | [Homebrew](https://brew.sh/index_ja){:target="_blank"}で最新のコマンドをコピペする<br>コマンド投入前に`cd ~`{:style="background: #ffebf6"} でホームディレクトリにしておく。 |
| Homebrewが導入済みの場合、Homebrewのバージョンを<br>確認し、最新にアップデートする。<br>**後から確認してできるようにセットでコマンドを投入しておく | `brew -v`{:style="background: #ffebf6"}** バージョンを確認する<br><br>`brew update`{:style="background: #ffebf6"}<br/> |
| Rbenv を導入し、特定のRubyのバージョンをインストールできるようにする。<br>**Rbenvの初期化をお忘れなく。<br>`eval "$(rbenv init -)"`{:style="background: #ffebf6"}をzshrcシェルに入れておけば、<br>自動的にrbenvがロードされるようになる。 | `brew install rbenv`{:style="background: #ffebf6"}<br><br>`rbenv init`{:style="background: #ffebf6"} |
| Ruby 2.7.1 を導入する<br>2.7.1は2020/12現在のJekyllの推奨バージョン<br> | `rbenv install 2.7.1`{:style="background: #ffebf6"}          |
| 特定のRubyのバージョンのPATHを通す。<br>MacOSX のシェルは現在、.zshrc です。 | ```echo 'export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"' >> ~/.zshrc```{:style="background: #ffebf6"} |
| .zshrc シェルの中身を確認する。<br>ホームディレクトリから投入します。 | `ls -a`{:style="background: #ffebf6"}** ファイルの存在を確認する<br><br>`cat .zshrc`{:style="background: #ffebf6"} |
| Jekyll を導入する<br>                                        | `gem install --user-install bundler jekyll`{:style="background: #ffebf6"}<br><br>`jekyll -v`{:style="background: #ffebf6"} ** バージョン確認する |
| my_site フォルダにサイトイメージを出力する<br>my_siteというディレクトリを作成して、<br>そのディレクトリに移動しておくこと。 | `mkdir my_site`{:style="background: #ffebf6"}<br>`cd my_site`{:style="background: #ffebf6"}<br><br>`jekyll new my_site`{:style="background: #ffebf6"} |



### What is Jekyll?

[Jekyll（ジキル）](http://jekyllrb-ja.github.io/){:target="_blank"}は、SSGの中では最も人気があります。　Rubyで作られています。パーソナルなサイトを簡単に GitHub で展開、
公開が可能な[GitHub Pages](https://pages.github.com){:target="_blank"}は Jekyll で提供されています。 
GitHub Pagesでの公開は、カスタムドメイン名を含む全てが無料のため、個人のプロジェクトやサイトの公開先として人気です。　

WordPress のようにデータベースの管理や、煩わしい更新もなく、インストールするだけで済んでしまいます。
Markdown、Liquid、HTML、およびCSSが採用され、簡単に静的サイトを展開できるようになっています。　
ブログページに必要な、パーマリンク、カテゴリ、ページ、投稿、およびカスタムレイアウトは、殆どのテーマで提供されており、
静的サイトを立ち上げるのであれば、Jekyllを使えば、すべての用途において洗練したホームページの構築が可能です。

静的サイトの優れた点については、[動的サイトと静的サイト]({{ "2020/03/11/dynamic-vs-static-web-site.html" | relative_url}}){:target="_blank"}の記事を併せて参考にしてください。

また、Jekyllで作成された静的サイトの公開方法も多様な方法があります。まずはGithubページでの公開がおすすめです。
ホスティングサイトを用意することなく、自由にカスタム化されたドメイン名など簡単にデプロイすることができます。

管理人もJekyll での最初の公開は、Githubページを利用しました。いろいと展開先を変えて今に至っています。
JekyllのインストールからAWSでの公開まで、管理人が実際辿ってきた道のりをいくつかのブログにわけてお伝えしたいと思います。


### 早速、Jekyllをインストールしよう

Jekyllを使うためのOSは、MacOSが一般的です。
MacOSでJekyllをインストールするために必要なRuby のバージョン、関連するパッケージ管理システム 、
ツールは下の表でまとめています。前提となるRubyのバージョンは、
[オフィシャルサイト](https://jekyllrb.com/docs/installation/macos/#install-ruby){:target="_blank"}

によると2.4.0以上ですので、稼働は大丈夫そうですが、オフィシャルサイトで推奨するRubyの2.7.1 までバージョンアップします。
`ruby -v`{:style="background: #ffebf6"} でRuby のバージョンを確認します。

{% highlight python linenos %}
ruby -v

ruby 2.6.3p62 (2019-04-16 revision 67580) [universal.x86_64-darwin20]
{% endhighlight %}

Rubyを新規導入または最新版をインストールするには、Rubyインストールのためのパッケージ管理システムが必要です。
Linux では複数のバージョンを管理できるRbenvが一般的です。　Mac環境でもRbenv も使えます。本記事では、Rbenv からRubyをインストールする
方法をご紹介します。

Rubyは、Ruby言語用のライブラリである gem を使います。　このgem パッケージ管理システムのためのRubyGems も必要となってきます。　
Bundlerが、gem 同士の互換性を保ちながら各gemの導入、管理をします。　Jekyllインストールに必要なパッケージ管理システムを表でまとめました。

<table>
        <tbody>
          <tr>
            <th>名前</th>
            <th>説明</th>
          </tr>
          <tr>
            <td>RubyGems</td>
            <td>gem パッケージ管理システム（gemとはRubyのライブラリです）</td>
          </tr>
          <tr>
            <td>Bundler</td>
            <td>gem 同士の依存関係を保ちながら各gemの導入、管理します</td>
          </tr>
          <tr>
            <td>Homebrew　</td>
            <td>MacOS用のパッケージ管理システム（Rbenvの導入,Rubyも導入できます）</td>
          </tr>
          <tr>
            <td>Rbenv</td>
            <td>Ruby導入、複数環境の管理システムです。</td>
          </tr>          
        </tbody>
      </table>


### Homebrew のインストール

Homebrewのインストールは、[Homebrew](https://brew.sh/){:target="_blank"} にあるコマンドとURLをコピペしてそのまま、ターミナルに投入します。
Homebrewをホームディレクトリにインストールしますので、忘れずに
`cd ~`{:style="background: #ffebf6"} でカレントディレクトリをホームに戻します。

{% highlight python linenos %}
cd ~

~ % 

~ % /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
Password:
==> This script will install:
/usr/local/bin/brew
/usr/local/share/doc/homebrew
/usr/local/share/man/man1/brew.1
/usr/local/share/zsh/site-functions/_brew
/usr/local/etc/bash_completion.d/brew
/usr/local/Homebrew
==> The following new directories will be created:
/usr/local/bin
/usr/local/etc

*** 省略

Press RETURN to continue or any other key to abort
==> /usr/bin/sudo /bin/mkdir -p /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/sbin /usr/local/share /usr/local/var /usr/

*** 省略
==> Tapping homebrew/core
remote: Enumerating objects: 42, done.
remote: Counting objects: 100% (42/42), done.
remote: Compressing objects: 100% (30/30), done.
remote: Total 890062 (delta 27), reused 19 (delta 12), pack-reused 890020
Receiving objects: 100% (890062/890062), 353.44 MiB | 12.57 MiB/s, done.
Resolving deltas: 100% (603488/603488), done.

From https://github.com/Homebrew/homebrew-core
 * [new branch]      master     -> origin/master
Updating files: 100% (5740/5740), done.
HEAD is now at de8bd53a32 netlify-cli: update 3.2.3 bottle.
==> Installation successful!
{% endhighlight %}

Homebrewのバージョンを確認します。

{% highlight python linenos %}
~ % brew -v
Homebrew 3.0.0
Homebrew/homebrew-core (git revision 923c99; last commit 2021-02-07)
~ % 
{% endhighlight %}


###  Rbenv を導入する

Ruby を導入するためのソフトはRbenvです。複数のバージョンを管理できます。先ほど導入したHomebrewで rbenv を導入します。

{% highlight python linenos %}
~ % brew install rbenv
Updating Homebrew...
==> Downloading https://homebrew.bintray.com/bottles/autoconf-2.69.big_sur.bottle.4.tar.gz
==> Downloading from https://d29vzk4ow07wi7.cloudfront.net/4a05c5734bd99dc0adca0160e1ca79a291f2bd7fb8d52dd4605df0da30
######################################################################## 100.0%
==> Downloading https://homebrew.bintray.com/bottles/pkg-config-0.29.2_3.big_sur.bottle.tar.gz

*** 省略

To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
to your ~/.zshrc:
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

Note: this may interfere with building old versions of Ruby (e.g <2.4) that use
OpenSSL <1.1.
==> Summary
🍺  /usr/local/Cellar/ruby-build/20210119: 520 files, 259.9KB, built in 4 seconds
==> Installing rbenv
==> Pouring rbenv-1.1.2.big_sur.bottle.tar.gz
🍺  /usr/local/Cellar/rbenv/1.1.2: 36 files, 105.2KB
==> Caveats
==> ruby-build
ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.

To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
to your ~/.zshrc:
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

Note: this may interfere with building old versions of Ruby (e.g <2.4) that use
OpenSSL <1.1.
{% endhighlight %}

rbenv を初期化します。すると、zshrc シェルにrbenv が自動的にロードするよう```eval "$(rbenv init -)"```をシェルに
追加することを推奨します。　ちなみに、最新のMacOSはzshrcシェルを使います。　bashから変わりました。

{% highlight python linenos %}
~ % rbenv init

# Load rbenv automatically by appending
# the following to ~/.zshrc:

eval "$(rbenv init -)"
{% endhighlight %}



### rbenv でRuby 2.7.1を導入する

Rubyの導入は、Rbenvでも可能です。MacではHomebrewからも導入できますので、HomebrewでのRubyを導入します。

{% highlight python linenos %}
~ % rbenv install 2.7.1
Downloading openssl-1.1.1i.tar.gz...
-> https://dqw8nmjcqpjn7.cloudfront.net/e8be6a35fe41d10603c3cc635e93289ed00bf34b79671a3a4de64fcee00d5242
Installing openssl-1.1.1i...
Installed openssl-1.1.1i to /Users/home/.rbenv/versions/2.7.1

Downloading ruby-2.7.1.tar.bz2...
-> https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.1.tar.bz2
Installing ruby-2.7.1...
ruby-build: using readline from homebrew
Installed ruby-2.7.1 to /Users/home/.rbenv/versions/2.7.1
{% endhighlight %}


*** 導入したRubyのバージョンを確認します。

{% highlight python linenos %}
~ % ruby -v

ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin20]
~ %

{% endhighlight %}

Ruby 2.7.1 が導入されました。Jukyllに必要なRubyのバージョンをクリアできました。

### Jekyllをインストール

gem コマンドでJekyllをインストールします。[オフィシャルサイト](https://jekyllrb.com/docs/installation/macos/#install-ruby){:target="_blank"}のとおりインストールすれば、大丈夫です。

{% highlight python linenos %}
~ % gem install --user-install bundler jekyll
Fetching bundler-2.2.7.gem
Successfully installed bundler-2.2.7
Parsing documentation for bundler-2.2.7
Installing ri documentation for bundler-2.2.7
Done installing documentation for bundler after 6 seconds
Fetching colorator-1.1.0.gem
Fetching em-websocket-0.5.2.gem

*** 省略

Parsing documentation for terminal-table-2.0.0
Installing ri documentation for terminal-table-2.0.0
Parsing documentation for jekyll-4.2.0
Installing ri documentation for jekyll-4.2.0
Done installing documentation for public_suffix, addressable, colorator, eventmachine, http_parser.rb, em-websocket, concurrent-ruby, i18n, ffi, sassc, jekyll-sass-converter, rb-fsevent, rb-inotify, listen, jekyll-watch, kramdown, kramdown-parser-gfm, liquid, mercenary, forwardable-extended, pathutil, rouge, safe_yaml, unicode-display_width, terminal-table, jekyll after 65 seconds
27 gems installed
{% endhighlight %}

Jekyllがちゃんと導入されたか、バージョンを調べます。

{% highlight python linenos %}
~ % jekyll -v

jekyll 4.2.0
~ % 
{% endhighlight %}

jekyll バージョン4.2.0 がインストールされました。


### Jekyllの稼働確認

インストールできましたので、稼働確認をして、正常にインストールされたことを確認します。jkyll 実行コマンド(my_site フォルダにサイトイメージを出力するコマンド）を打って、ローカル環境でサーバの稼働を確認します。

{% highlight python linenos %}
~ % jekyll new my_site

  Bundler: Fetching gem metadata from https://rubygems.org/..........
  Bundler: Resolving dependencies...
  Bundler: Using public_suffix 4.0.6
  Bundler: Using bundler 2.2.7
  Bundler: Using colorator 1.1.0
  Bundler: Using concurrent-ruby 1.1.8
  Bundler: Using eventmachine 1.2.7
  Bundler: Using http_parser.rb 0.6.0
  Bundler: Using ffi 1.14.2
  Bundler: Using forwardable-extended 2.6.0
  Bundler: Using rb-fsevent 0.10.4
  Bundler: Using liquid 4.0.3

  *** 省略

 Bundler: Bundle complete! 6 Gemfile dependencies, 31 gems now installed.
  Bundler: Use `bundle info [gemname]` to see where a bundled gem is installed.Following files may not be writable, so sudo is needed:
  Bundler: /Library/Ruby/Gems/2.6.0
  Bundler: /Library/Ruby/Gems/2.6.0/build_info
  Bundler: /Library/Ruby/Gems/2.6.0/cache
  Bundler: /Library/Ruby/Gems/2.6.0/doc
  Bundler: /Library/Ruby/Gems/2.6.0/extensions
  Bundler: /Library/Ruby/Gems/2.6.0/gems
  Bundler: /Library/Ruby/Gems/2.6.0/specifications
New jekyll site installed in /Users/home/my_site. 
{% endhighlight %}


`cd my_site` でサイトのディレクトリに移動します

{% highlight python linenos %}
~ % cd my_site

~/my_site % ls
404.html        Gemfile         Gemfile.lock    _config.yml     _posts          _site           about.markdown  index.markdown
{% endhighlight %}


### サイトイメージの出力
ホームディレクトリ配下の my_site から `bundle exec jekyll serve`{:style="background: #ffebf6"} でJekyllを起動します。

{% highlight python linenos %}
~/my_site % bundle exec jekyll serve

Configuration file: /Users/home/my_site/_config.yml
Configuration file: /Users/home/my_site/_config.yml
Source: /Users/home/my_site
Destination: /Users/home/my_site/_site
Incremental build: disabled. Enable with --incremental
Generating...
done in 1.406 seconds.
Auto-regeneration: enabled for '/Users/home/my_site'
Configuration file: /Users/home/my_site/_config.yml
Server address: http://127.0.0.1:4000/
Server running... press ctrl-c to stop. 
{% endhighlight %}


サーバーがローカルで動き出したようです。http://127.0.0.1:4000/ にアクセス
して、サイトイメージを確認します。

![Jekyll稼働確認]({{"assets/img/2019_07_01/Jekell_serv_5.gif" | relative_url}})


{% highlight python linenos %}
~/my_site %　ls

404.html        Gemfile         Gemfile.lock    _config.yml     _posts          _site           about.markdown  index.markdown
{% endhighlight %}

以上がjekyll のインストールと稼働確認になります。


