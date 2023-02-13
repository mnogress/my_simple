---
layout: post
title: PyPDF2を使ったPDFからのテキストファイルの抽出
feature-img: "assets/img/2020_08_15/retro-gd50c79e33_640.png"
tags: [Python, PyPDF2, テキスト操作 ]
excerpt_separator: <!--more-->
---

最新のPyPDF2のモジュールを利用してPDFからテキストデータを取り込み方についてまとめたいと思います。
まず、単一PDFファイルの内容をテキストファイルに書き出しについてまとめます。

<!--more-->
次に、glob を使ったフォルダ配下の複数のPDFファイルのテキスト情報をひとつにまとめる方法を後半でご紹介します。
さらに、各々のテキスト化の最初にファイル名を挿入しています。テキスト化の参考になれば幸いです。

---

### PyPDF2 をインストールする

 [PyPDF2](https://pypi.org/project/PyPDF2/3.0.1/){:target="_blank"}を利用します。
通常のPIPコマンド `pip install PyPDF2`{:style="background: #ffebf6"} でインストールできます。<br>
今回は以下の環境で記事を書いています。

>
* PyPDF2 3.0.1
* python 3.9.13
* Windows 10
>




サンプルコードでテキストデータを抽出するPDFは下図のとおりです。

![2page_pdf_sample]({{ "assets/img/2020_08_15/pdffig1.png" | relative_url}})<br>


サンプルPDFには以下のような特徴があります。

1. 複数のページ（今回は2ページ）から構成されている
2. 縦書きと横書きが混在する。
3. 日本語（全角）と記号（半角）が混在する

#### Input 及び Output file

サンプルコードでは、このPDF（サンプル文書.pdf ）をプログラムと同じ
ディレクトリ配下に配置しています。
PDFから抽出したtxt ファイル（サンプル文書.txt）も同じフォルダ配下に書き出します。

---
### サンプルコード

以下がサンプルコードになります。

{% highlight python linenos %}

from PyPDF2 import PdfReader

reader = PdfReader("サンプル文書.pdf")

all_text = []

number_of_pages = len(reader.pages)

for i in range(number_of_pages):
    page = reader.pages[i]
    output = page.extract_text()
    all_text.append(output)
    
s = ''.join(all_text)
with open("サンプル文書.txt", "w", encoding ="utf_8", errors="ignore") as f:
    f.write(s)

{% endhighlight %}


### 各ステップの説明

For ループで各ページ毎にテキストデータを抽出します。
抽出した内容は、リスト形式で格納します。

1. `PyPDF2` から`PdfReader` をインポートします
2. `PdfReader` を使ってターゲットの"サンプル文書.pdf"を読み込み、`reader` というオブジェクトに格納します
3. PDFの各ページのテキストデータをページ毎に`all_text` というリスト形式に格納するため、まず初期化します
4. ページ数を `len(reader.page)`で求め、その値（今回は2）を変数 `number_of_pages`に格納します
5. 変数 iでページ数までのFor ループを宣言し、各ページについて以下の事を行います
    1. `reader.page[i]` ：最初のページから１ページずつ`page` というオブジェクトに格納します
    2. `page` オブジェクトからテキストを抽出して、`output` という変数に格納します
    3. `output` (pdf のテキスト）を `all_text` に`append` でリストの要素を追加します
    4. `[‘page1’, ‘page2’, ,,,,’pageEnd’]`  という感じで `all_text` 出来上がります。　ちなみに今回は２ページです。
6. `s = ''.join(all_text)` でリスト形式で追加された `all_text` をひとつにまとめてその変数を`s`とします
7. `with open` で"サンプル文書.txt"というテキストファイルを定義して、オプション`"w"` でファイルを上書き作成します。

### 抽出したテキストファイル

抽出したテキストファイルをWindowsのメモ帳で開け時の内容が以下のとおりです。

![2page_pdf_sample]({{ "assets/img/2020_08_15/pdffig2.png" | relative_url}})<br>


>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em"} 
1. ワードで作成された縦書きなどの文字には各文字に
改行キーを入れて実現しているため、テキストのみを抽出した場合、文字ごとに改行がついた状態になります。
2.  `[‘page1’, ‘page2’, ,,,,’pageEnd’]`  というリスト形式でのテキスト化では、改行キー`\n`がテキストとして出現し、改行されません。
3. コード例のように`s = ''.join(all_text)`でひとつにまとめると改行キーで改行されて見やすくなります。
4. いずれにしても、縦書きのテキストファイル化は避けたいところです。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

---

### Globを使ってディレクトリ配下の複数PDFを順次読み込み、テキスト化する

前半のCode ではファイル名を指定し、そのPDFファイルをテキスト化する内容でした。　しかし、複数のファイルを順次読み込み、都度テキスト化する方が
効率的です。また、ファイル名を指定しない分，手間も省けますす。

{% highlight python linenos %}

from PyPDF2 import PdfReader
import os, glob, sys
file_path = 'C:\\Users\\your_directory_to_text'
files = glob.glob(os.path.join(file_path,'*.pdf'))

for file in files:
    reader = PdfReader(file)
    count = len(reader.pages)
    all_text = []
    for i in range(count):
        page = reader.pages[i]
        all_text.append(page.extract_text())
        newoutput = ''.join(all_text)
    with open("output_example.txt", "a", encoding = "utf-8") as f:
        f.write( "\n" + "\n" +"***********  " + file + "  *************" + "\n" + "\n" + newoutput)

{% endhighlight %}

1. `PyPDF2` から`PdfReader` をインポートします
2. `os`, `glob`, `sys` をインポートします。これらは、標準ライブラリです。   pip でインストール不要です
3. `file_path` という変数名でテキスト化したいPdfが設置されているディレクトリを指定します。
4. `files` という変数に拡張子が pdf のファイルのみ順次読み込みます。
5. `for file in files` で`files` で読み込まれたそれぞれの pdf file である`file`に対してfor ループ処理をします 
6. `PdfReader` を使ってターゲットの"サンプル文書.pdf"を読み込み、`reader` というオブジェクトに格納します（前半と同じですね）
7. ページ数を `len(reader.page)`で求め、その値（今回は2）を変数 `count`に格納します (前半のコードと変数名変えています！)
8. PDFの各ページのテキストデータをページ毎に`all_text` というリスト形式に格納するため、まず初期化します
9. 変数 iでページ数までのFor ループを宣言し、各ページについて以下の事を行います
    1. `reader.page[i]` ：最初のページから１ページずつ`page` というオブジェクトに格納します
    2. `page` オブジェクトからテキストを抽出して、`output` という変数に格納します
    3. `output` (pdf のテキスト）を `all_text` に`append` でリストの要素を追加します
    4. `[‘page1’, ‘page2’, ,,,,’pageEnd’]`  という感じで `all_text` 出来上がります。　ちなみに今回もいずれも２ページです。
10. `newoutput = ''.join(all_text)` でリスト形式で追加された `all_text` をひとつにまとめてその変数を`newoutput`とします
11. `with open` で"サンプル文書.txt"というテキストファイルを定義して、オプション`"a"` でファイルに追加し行きます。
12. ファイルに書き込むにあたり、改行と******** を前後に付けてファイル名を代入しています。これでどのファイルをテキスト化したかが容易に判別できます・


>
`[ここがポイント！＜その２＞]`{:style="color: blue; font-size: 1.3em"} 
1. For ループを二つ入れ子（いわゆる多重ループ）で回しています。Glob でファイルの順次読み込みをしたら、そのファイルに対して各ページも順に読み込みテキスト化します
2. 多重ループなのか、単純にFor ループは二つそれぞれあるかを区別させるため、Python ではインデントで識別しています
3. 今回は多重ループなので、インデントが二つ奥に入り込んでいます
3. 一方、ファイルの書き込みはfor file in files 単位で行うので、最初のインデントで実行しています。 
4. 書き込みオプション`'a'` で追記するようにして、ファイル書き込みで複数のファイルの書き込みを実現しています。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}



### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [PyPDF2](https://pypi.org/project/PyPDF2/3.0.1/){:target="_blank"}<br>
2) [KH Coder で複合語をコントロールしてWordCloudを作成する](https://www.so-wi.com/2022/05/15/khcoder_wordcloud_make.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}