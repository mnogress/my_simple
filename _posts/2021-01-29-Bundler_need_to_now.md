---
layout: post
title: Bundler これだけは知っておきたい
feature-img: "assets/img/2019_07_01/geometric-3066080_1280.jpg"   
tags: [jekyll, installation, Mac]
excerpt_separator: <!--more-->
---


[Bundler](https://bundler.io/){:target="_blank"}は、[Jekyll](http://jekyllrb-ja.github.io/){:target="_blank"}とは別物のRubyアプリケーションです。Rubyアプリケーション間の依存関係を解決します。Bundlerなしでは、Jekyllはインストールできません。
Bundlerは、Jekyllにとって、必須ツールです。　しかし、実際、Jekyllの運用ではBundlerの多くを知る必要はありません。　

Jekyll での静的サイト運用するにあたり、最低限知っておくべき、`Gemfile`と`Gemfie.lock`の役割について説明します。<!--more-->

* TOC
{:toc}

----

### チートシート



| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `Ruby` のバージョンを確認する。<br>`Bundler`導入の前提として`Ruby`が必要。バージョンを確認する。<br>安定したバージョン2.7.1であることを確認(as of 2020/12) | `$ ruby -v`{:style="background: #ffebf6"}<br>`ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin20]` |
| ホームディレクトリにBundlerをインストールする<br>`Bundler version 2.2.7(as of 2020/12)` | `$  cd ~`{:style="background: #ffebf6"}<br>`$ gem install bundler`{:style="background: #ffebf6"}<br>`Successfully installed bundler-2.2.7` |
| `missing gem` のインストール<br>`Ruby` アプリの最初の起動時、必要な`gem`が無い場合に投入する | `$ bundle install`<br>`Fetching gem metadata from https://rubygems.org/..........`でインストールが開始する |



------



### Bundlerとは

Bundler は個々のRubyプロジェクトで必要とするさまざまなバージョンのRubyアプリケーション群の依存関係を管理するツールです。
Jekyll の導入でもBundler は欠かせません。　

Jekyllでは20から30のRubyアプリケーションで構成されています。個々のRubyアプリケーションは
gemspec にそのアプリケーションが稼働する前提となる他のRubyアプリケーションやバージョンを記述します。
Gemfileには依存するgem の取得先を記述します。　

通常は、`source`{:style="background: #ffebf6"} 行でURLを記述するだけです。
ただし、Jekyll の場合はいかのGemfile のように導入当初は`gemspec`を使わず、`Gemfile`に依存関係と必要な`gem`を記述しています。

アプリの稼働のための前提条件を依存関係といいます。
個々のrubyアプリケーションの依存関係が複雑に絡みあい、管理ツールが無ければ、いわゆる「依存関係地獄」状態です。　
その依存関係地獄を解決するのが、Bundlerです。

そんなBundlerについて、これだけは知っておきたいところを説明します。

### Bundlerのインストール

Bundlerのインストールは、gemで行われます。Rubyが導入されている環境が必要です。
`ruby -v`{:style="background: #ffebf6"} で導入されているRubyのバージョンを確認します。この場合は、2.7.1 の安定版が導入されています。

{% highlight vb linenos %}
$ ruby -v
ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin20]

$ gem install bundler

Successfully installed bundler-2.2.7
Parsing documentation for bundler-2.2.7
Done installing documentation for bundler after 2 seconds
1 gem installed

$ bundler -v

Bundler version 2.2.7
{% endhighlight %}

`bundler -v`{:style="background: #ffebf6"}で導入されたBundler のバージョンを確認します。

Bundler の2.2.7 が導入されました。簡単ですね。

### Gemfile 

Jekyllにおいて、Bundlerが使用するファイルは、`Gemfile` と`Gemfile.lock` の二つです。
`Gemfile`はどのgemをロードしたいかを指定します。ユーザは必要に応じて、こちらのファイルを編集します。

`Gemdfile`をもとに`Gemfile.lock` にすべての依存関係とgemの依存ツリーをBundlerが自動生成します。　
その依存関係とロードすべきgemのリストは、マニフェストファイルと呼ぶことがあります。
このように、Gemfie.lockはユーザが編集するファイルではありません。

Jekyll 4.2.0 のインストールで作成したサイトのディレクトリに移動して、Gemfile とGemfiile.lockファイルを確認します。

{% highlight vb linenos %}
$ ls

404.html        Gemfile         Gemfile.lock    _config.yml     
_posts          _site           about.markdown  index.markdown

{% endhighlight %}

[Jekyll 4.2.0 導入のページ](http://jekyllrb-ja.github.io/docs/installation/macos/){:target="_blank"}でも作成されている`Gemfile` と`Gemfiile.lock`中身を見てみましょう。　Gemfileです。

{% highlight vb linenos %}
source "https://rubygems.org"
# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!
gem "jekyll", "~> 4.2.0"
# This is the default theme for new Jekyll sites. You may change this to anything you like.
gem "minima", "~> 2.5"
# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
{% endhighlight %}


line 10の```gem "jekyll", "~> 4.2.0"```で前提とするJekyllのバージョンを定義しています。
line 12の```gem "minima", "~> 2.5"```デフォルトのテーマである"minima" のバージョンを定義しています。
`gem`名　`jekyll`と`minima` は`source`行で示された"https://rubygems.org"　にあるということです。

line 17から19まででプラグインを指定しますが、最小限ということで、```gem "jekyll-feed", "~> 0.12```のみです。
通常、テーマに付随するSEOであるとか、sitemap のようなプラグインを指定します。　

### Gemfile.lock

`Gemfile`の内容をもとに以下のような、各Rubyアプリケーションのバージョンの依存関係が`Gemfile.lock`に出力されています。```"minima"```のテーマを使った場合になります。

{% highlight python linenos %}
PATH
  remote: .
  specs:
    type-on-strap (2.0.3)
      jekyll (>= 3.5, < 5.0)
      jekyll-feed (~> 0.9)
      jekyll-paginate (~> 1.1)
      jekyll-seo-tag (~> 2.6)

GEM
  remote: https://rubygems.org/
  specs:
    addressable (2.7.0)
      public_suffix (>= 2.0.2, < 5.0)
    colorator (1.1.0)
    concurrent-ruby (1.1.8)
    em-websocket (0.5.2)
      eventmachine (>= 0.12.9)
      http_parser.rb (~> 0.6.0)
    eventmachine (1.2.7)
    ffi (1.14.2)
    forwardable-extended (2.6.0)
    http_parser.rb (0.6.0)
    i18n (1.8.8)
      concurrent-ruby (~> 1.0)
    jekyll (4.2.0)
      addressable (~> 2.4)
      colorator (~> 1.0)
      em-websocket (~> 0.5)
      i18n (~> 1.0)
      jekyll-sass-converter (~> 2.0)
      jekyll-watch (~> 2.0)
      kramdown (~> 2.3)
      kramdown-parser-gfm (~> 1.0)
      liquid (~> 4.0)
      mercenary (~> 0.4.0)
      pathutil (~> 0.9)
      rouge (~> 3.0)
      safe_yaml (~> 1.0)
      terminal-table (~> 2.0)
    jekyll-feed (0.15.1)
      jekyll (>= 3.7, < 5.0)
    jekyll-paginate (1.1.0)
    jekyll-sass-converter (2.1.0)
      sassc (> 2.0.1, < 3.0)
    jekyll-seo-tag (2.7.1)
      jekyll (>= 3.8, < 5.0)
    jekyll-watch (2.2.1)
      listen (~> 3.0)
    kramdown (2.3.0)
      rexml
    kramdown-parser-gfm (1.1.0)
      kramdown (~> 2.0)
    liquid (4.0.3)
    listen (3.4.1)
      rb-fsevent (~> 0.10, >= 0.10.3)
      rb-inotify (~> 0.9, >= 0.9.10)
    mercenary (0.4.0)
    pathutil (0.16.2)
      forwardable-extended (~> 2.6)
    public_suffix (4.0.6)
    rb-fsevent (0.10.4)
    rb-inotify (0.10.1)
      ffi (~> 1.0)
    rexml (3.2.4)
    rouge (3.26.0)
    safe_yaml (1.0.5)
    sassc (2.4.0)
      ffi (~> 1.9)
    terminal-table (2.0.0)
      unicode-display_width (~> 1.1, >= 1.1.1)
    unicode-display_width (1.7.0)

PLATFORMS
  x86_64-darwin-20

DEPENDENCIES
  type-on-strap!

BUNDLED WITH
   2.2.7
{% endhighlight %}



### まとめ

>
1. BundlerはJekyllの必須ツールです。
2. Rubyアプリケーション間の依存関係を解決するツールです。
3. Gemfile がユーザ定義、Gemfiile.lockがBundlerが使う依存関係の詳細です。
4. Gemfile でJekyllのバージョンか、一緒に使うプラグインアプリケーション、Jekyllのテーマ等を指定します
>

