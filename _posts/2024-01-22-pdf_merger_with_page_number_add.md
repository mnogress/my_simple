---
layout: post
title: PyPDF2とpdfrwを利用して複数PDFファイルを連結してページ番号を付与する
feature-img: "assets/img/2020_08_15/blue-2721464_1280.jpg"
color: rgb(80,140,22)
tags: [Python, PyPDF2, pdfrw, ページ番号, PDF連結 ]
excerpt_separator: <!--more-->
---

PDF操作の定番であるPyPDF2のモジュールを利用してフォルダ配下のPDFを連結し、pdfrwでページ番号を付与する手順をまとめました。
pdf の連結には関数を定義することで、汎用性のあるコードです。ひとつにまとめたPDFにページ番号を付与し使いやすくしています。
PythonでのPDF操作の参考になれば幸いです。

<!--more-->


---

### PyPDF2とpdfrw をインストールする

 PDF 連結には[PyPDF2](https://pypi.org/project/PyPDF2/3.0.1/){:target="_blank"}を利用します。
 また、ページ番号の付番には[pdfrw](https://pypi.org/project/pdfrw/0.4/){:target="_blank"}を利用します。
いずれも、通常のPIPコマンド `pip install PyPDF2`{:style="background: #ffebf6"} 及び
`pip install pdfrw`{:style="background: #ffebf6"}でインストール可能です。<br>

ブログにまとめるにあたり、以下の環境で記事を書いています。

>
* PyPDF2 3.0.1
* pdfrw  0.4
* python 3.9.13
* Windows 11
>

<strong>PyCharm 2022.3.1 (Community Edition)</strong> を利用しています。

---

### 完成形のイメージ

このブログで作成するアウトプットの完成形のイメージは以下のとおりです。
2ステップで作成しています。

![3page_pdf_sample]({{ "assets/img/2020_08_15/0130_fig1.png" | relative_url}}){:height="80%" width="80%"}<br>

---

#### Input 及び Output file

サンプルコードで連結するpdfファイルは以下の`source`フォルダに存在します。

   <strong>C:/Users/usr/sample/data/source</strong>

連結、ページ番号が付与された`pdfファイル`は以下になります。

   <strong>C:/Users/usr/sample/data/output/concatenated.pdf</strong>


---
### サンプルコード

以下がサンプルコードになります。まず連結部分のサンプルコードをご紹介します。
[Python, pypdfでPDFを結合・分割（ファイル全体・個別ページ)](https://note.nkmk.me/python-pypdf2-pdf-merge-insert-split/){:target="_blank"}を参考に本コードでは本サイトで紹介した[PyPDF2を使ったPDFからのテキストファイルの抽出](https://www.so-wi.com/2023/02/10/pdf_extract_text_by_pypdf2.html){:target="_blank"}で利用した`PyPDF2`使っています。

連結するpdfが置いてあるpdfのフォルダと連結後のpdfの二つを引数とする関数(merge_pdf)は同様です。

{% highlight python linenos %}

from PyPDF2 import PdfWriter
from PyPDF2 import PdfReader
import glob
import os
merger = PdfWriter()
def merge_pdf(src_path, dst_file):
    lst = glob.glob(os.path.join(src_path, '*.pdf'))
    lst.sort()
    for p in lst:
        merger.append(p)
    merger.write(dst_file)
    merger.close()
merge_pdf('C://Users//usr//sample//data//source', 
          'C://Users//usr//sample//data//output//concatenated.pdf')

{% endhighlight %}


### 各ステップの説明

1. `PyPDF2` から`PdfWriter` をインポートします。
2. `PyPDF2` から`PdfReader` をインポートします。
3. `glob` をインポートします。
4. `os`をインポートします。
5. `PdfWriter()` を mergerというオブジェクト名で定義します。
6. 関数名 `merge_pdf`を定義します。引数は2つで `src_path` が入力となるpdfが格納されているフォルダ名(絶対パスを想定しています)とその出力となる pdf名が引数です。
7. リスト型式の変数`lst`に`src_path`配下の拡張子`pdf`のすべてのファイルを`glob`で代入します。
8. ファイル名を昇順でソートします　* 読み込むファイル名を管理しやすいように命名しておくといいですね。
9. `lst`の中身を一つずつ取り出します。取り出すファイルをそれぞれ`p`としています。 
10. `merger` オブジェクトで取り出した順に`append` （追加）します。
11. `dst_file`  という名前でWriteします。 
12. close して終了します。　ここまでが、関数の中身です。
13.  `'C://Users//usr//sample//data//source'`{:style="background: #1166AA; color: white"} と `'C://Users//usr//sample//data//output//concatenated.pdf'`{:style="background: #ff0044; color: white"}を引数とした`merge_pdf`関数を実行し、pdfファイルを連結します。

---

### ページ番号を追加する

ページ番号をフッターに追加するには、[pdfrw](https://pypi.org/project/pdfrw/0.4/){:target="_blank"}を利用します。

[reportlab-how-to-add-a-footer-to-a-pdf-file](https://stackoverflow.com/questions/28281108/reportlab-how-to-add-a-footer-to-a-pdf-file){:target="_blank"}を参考にしています。


アウトプットイメージは以下のとおりです。

![2page_pdf_sample]({{ "assets/img/2020_08_15/0130_fig2.png" | relative_url}})<br>

---

### サンプルコード

以下がサンプルコードになります。殆ど[reportlab-how-to-add-a-footer-to-a-pdf-file](https://stackoverflow.com/questions/28281108/reportlab-how-to-add-a-footer-to-a-pdf-file){:target="_blank"}のままを載せています。

ページ数を付与するファイルを置いているディレクトリをカレントディレクトリとしているため、ファイル名のみを指定しています。
ステップ１で連結した`concatenated.pdf`をinput_file にしています。


{% highlight python linenos %}

from reportlab.pdfgen.canvas import Canvas
from pdfrw import PdfReader
from pdfrw.toreportlab import makerl
from pdfrw.buildxobj import pagexobj
import sys
import os

input_file = "concatenated.pdf"
output_file = "concatenated_pgn.pdf"


# Get pages
reader = PdfReader(input_file)
pages = [pagexobj(p) for p in reader.pages]


# Compose new pdf
canvas = Canvas(output_file)

for page_num, page in enumerate(pages, start=1):

    # Add page
    canvas.setPageSize((page.BBox[2], page.BBox[3]))
    canvas.doForm(makerl(canvas, page))

    # Draw footer
    footer_text = "Page %s of %s" % (page_num, len(pages))
    x = 128
    canvas.saveState()
    canvas.setStrokeColorRGB(0.941, 0.694, 0.024) # line color : gold
    canvas.setFillColorRGB(0.02, 0.412, 0.58)  #  character color : blue
    canvas.setLineWidth(2.0)
    canvas.line(66, 78, page.BBox[2] - 66, 78)
    canvas.setFont('Helvetica', 10.5)
    #canvas.setFont('Times-Roman', 10.5)
    canvas.drawString(page.BBox[2]-x, 65, footer_text)
    canvas.restoreState()

    canvas.showPage()

canvas.save()

{% endhighlight %}



>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em; background-color: #ffe3e2"} 
1. ディレクトリの指定は`'C://Users//usr//sample//data//source'`{:style="background: #1166AA; color: white"} のとおり、本環境では`//`とスラッシュを重ねないと上手く稼働しませんでした。
2. 線の色と字の色の指定はRGB(各々0~1までの値)で行っています。
3. フォントは、'Helvetica'と'Times-Roman'のいずれかが指定可能です。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}


---


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にさせていただきました。併せてご覧ください。
>
1) [Python, pypdfでPDFを結合・分割（ファイル全体・個別ページ)](https://note.nkmk.me/python-pypdf2-pdf-merge-insert-split/){:target="_blank"}<br>
2) [reportlab-how-to-add-a-footer-to-a-pdf-file](https://stackoverflow.com/questions/28281108/reportlab-how-to-add-a-footer-to-a-pdf-file){:target="_blank"}<br>
3) [PyPDF2を使ったPDFからのテキストファイルの抽出](https://www.so-wi.com/2023/02/10/pdf_extract_text_by_pypdf2.html){:target="_blank"}<br>
{:style="border-color: #ff0044; border-top-color: #ff0044; font-size: 1.0em; background-color: #e0ffff;"}