---
layout: post
title: PythonでExcel自動化：複数のexcelファイルの同じ場所のセルの値を一つのシートにまとめる
feature-img: "assets/img/2020_08_15/cubes-7340789_1280.jpg"   
tags: [excel, openpyxl, Python]
excerpt_separator: <!--more-->
---

Pythonを使って複数のexcelファイルの同じ場所のセルの値を一つのシートにまとめる入力作業機械化方法を解説します。

自動化の手段としてEXCEL マクロ(vba)で組むのも一つの方法ですが、[Openpyxl](https://openpyxl.readthedocs.io/en/stable/tutorial.html){:target="_blank"} のモジュールを使えば簡単に実現できる場合があります。複数のexcelファイルの内容を一つのシートにまとめる作業の時短について、Blogにまとめました。旧ページの紛らわしい記述を修正しています。

<!--more-->

---


### 自動化のイメージ

自動化のイメージは下図になります。

![python_auto_fig1]({{ "assets/img/2020_08_15/automation_python_excel_file_1.png" | relative_url}})<br>

集計にあたり、以下のような一般的なEXCELを使った報告シートを想定してプログラムを組んでいます。

>１） 報告数分のEXCELファイルにそれぞれシートが一つ存在します（複数のシートがある場合最初のシートが対象になります）<br>
>２） 入力シートのようにそれぞれのEXCELファイルのシート内の同じセルの位置に入力されています<br>
>３） ファイル名はそれぞれ異なり、一つのフォルダにまとめてあります<br>
>４） 集計するセルの場所（番地）は固定で予め決まっています<br>
>５） 集計するセルの場所以外に入力された内容は集計しません（できません）<br>
>
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}


### Openpyxl

[Openpyxl](https://openpyxl.readthedocs.io/en/stable/tutorial.html){:target="_blank"} とはPythonでExcel ファイルを読み書き等の操作するためのモジュールです。一旦、EXCELファイルをPythonのプログラムで読み込んでしまえば、値の挿入から書式の変更までPythonプログラムやJupyter Notebook上でEXCEL操作が可能になります。

### glob

複数のExcelファイルを読み込むために、[glob](https://docs.python.org/ja/3/library/glob.html){:target="_blank"} を利用します。　以下のサンプルでは、`D`ドライブの`jupyter`というフォルダ配下にある`xlsx`の拡張子がある`Excelファイル: workbook(gb)`を順次読み込ませ、読み込んだエクセルのbookの最初のシート`worksheets[0]`を `ws2`{:style="color: blue"}としています。

{% highlight python linenos %}

input_file_name= 'D:\jupyter\\*.xlsx'

for gb in glob.glob(input_file_name, recursive=True):
     ws2 = xl.load_workbook(gb).worksheets[0]

{% endhighlight %}

<div style="padding: 20px; margin-bottom: 10px; border: 3px solid #DB2E09; border-radius: 20px;">
<strong>glob</strong>はファイル操作のみならず色々なことができます。フォルダ配下のファイル（この場合はファイル拡張子<strong>xlsx</strong>のファイルすべて）を順次読み込むことが可能です。ファイル連続操作定番のコードサンプルとして覚えておくと便利です。
</div>


### リスト形式でシート内のデータを格納

`glob`{:style="color: blue"}を使ってフォルダ内のExcelファイルを順次読み込んでのち、それをリスト形式で変数に格納するもう一つテクニックがあります。一行で実現できます。これも覚えておくと便利なコードテクニックです。

{% highlight python linenos %}

　sh_values=[[cell.value for cell in row] for row in ws2]

{% endhighlight %}

読み込んだシート（この場合はws2ですね）の各行を変数 sh_values にリスト形式で格納してくれます。

{% highlight python %}

　[['東京都', None, None, None, None], 
[None, '代表者氏名', None, None, None], 
[None, '山田太郎', 'Ｗｅｂ参加人数', 'リージョンＩＤ', None], 
[None, None, 100, 13, '都道府県番号']]

{% endhighlight %}

### Excel シートデータとリスト配列の関係
Excel シートデータとリスト配列の対応関係を図示します

![sh_values_list_format_1]({{ "assets/img/2020_08_15/sh_values_list_format_1.png" | relative_url}})<br>


### 変数の定義
各変数の働きをまとめておきます。筆者も久しぶりに記事を参考にしてコーディングしようとしたところ、ハマりました。ページ修正にあたりまとめてました。

<div style="padding: 20px; margin-bottom: 10px; border: 3px solid #092CDB; border-radius: 5px;">
<dl>
<dt>ws</dt>
<dd>output(書き込み)用のworksheet</dd>

<dt>ws2</dt>
<dd>globで順次読み込まれるworksheet</dd>

<dt>sh_values</dt> <dd>ws2の全データをリスト形式で格納します</dd>

<dt>wb.xlsx</dt>
<dd>書き込み用の excel ファイル、load するため事前にファイルを用意する必要がある</dd>

<dt>saved.xlsx</dt> 
<dd>結果が保存される excel ファイル</dd>
</dl>
</div>

### サンプルコード
{% highlight python linenos %}
import openpyxl as xl
import glob
input_file_name= 'D:\\jupyter\\*.xlsx' 
output_file_name = 'D:\\work\\wb.xlsx'
saved_file_name = 'D:\\result\\saved.xlsx'
book = xl.load_workbook(output_file_name)
ws = book.active
line_num = 2  
for gb in glob.glob(input_file_name, recursive=True):
​    ws2 = xl.load_workbook(gb).worksheets[0]
​    sh_values=[[cell.value for cell in row] for row in ws2]
​    ws.cell(row=line_num,column=1).value = sh_values[0][0]
​    ws.cell(row=line_num,column=2).value = sh_values[3][3]
​    ws.cell(row=line_num,column=3).value = sh_values[2][1]
​    ws.cell(row=line_num,column=4).value = sh_values[3][2]
​    line_num+=1
​book.save(saved_file_name)

{% endhighlight %}

<div style="padding: 20px; margin-bottom: 10px; border: 3px solid #DF1452; border-radius: 8px;">

1. 必要なモジュールをロードする<br>
2. 同上<br>
3. 取りまとめるフォルダと配下のExcelファイルを指定 D:\\jupyter\<br>
4. 書き込みファイル名を指定 `wb.xlsx`  ファイルをロードし結果を書き込む<br>
5. `saved.xlsx`という別名で保存<br>
6. 書き込み用'wb.xlsx'(output_file_name) を読み込み、`book`というオブジェクトに格納<br>
7. アクティブシートを `ws` という名前で定義し、このシートに値を代入する<br>
8. 最初の書き込み位置を2行目`line_num = 2`にセットする<br>
9. 定数 'input_file_name'で指定したフォルダ配下の excelファイルがひとつづつ読み込まれる<br>
10. 読み込まれるExcel bookの最初シート`worksheets[0]`をws2と定義する<br>
11. ws2にある値を各行ごとのリスト形式です読み込む<br>
12. wsの line_num行1列目`column=1`にsh_valuesの(0,0)=>1行目の1列目の値（都道府県名）を代入する<br>
13. wsの line_num行2列目`column=2`にsh_valuesの(3,3)=>4行目の4列目の値（代表者名）を代入する<br>
14. wsの line_num行3列目`column=3`にsh_valuesの(2,1)=>3行目の2列目の値（Web参加人数）を代入する<br>
15. wsの line_num行4列目`column=3`にsh_valuesの(3,2)=>4行目の3列目の値（都道府県番号）を代入する<br>
16. line_numを +1 する<br>
17. bookをセーブするファイル名はsaved_file_nameで定義している<br>

</div>


---

### ひとこと

><p>メールでEXCELファイルを送信し、決められたフォームに必要事項を入力してもらって記入済のEXCELファイルを取りまとめるという作業はメールとEXCELがオフィスツールとして定着した30数年前から今日まで根強く蔓延ったルーチン作業の一つだと思います。<br>課内等の１０数件であれば、一時間もあれば手作業でも完了しますが、全国47都道府県分であるとか、全国営業店、支店から等で100件以上の三桁のオーダーとなると手作業では半日以上かかることも少なくありません。Pythonを駆使して時短に挑戦する価値があるルーチン作業だと思います。
