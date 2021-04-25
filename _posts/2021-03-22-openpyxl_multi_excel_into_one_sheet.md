---
layout: post
title: PythonでExcel自動化：複数のexcelファイルの同じ場所のセルの値を一つのシートにまとめる
feature-img: "assets/img/2020_08_15/background-6171753_1280.jpg"   
tags: [excel, openpyxl, Python]
excerpt_separator: <!--more-->
---

Pythonを使って複数のexcelファイルの同じ場所のセルの値を一つのシートにまとめる作業の自動化の方法を解説します。

自動化の手段としてEXCEL マクロ(vba)で組むのも一つの方法ですが、[Openpyxl](https://openpyxl.readthedocs.io/en/stable/tutorial.html){:target="_blank"} のモジュールを使えば簡単に実現できる場合があります。複数のexcelファイルの内容を一つのシートにまとめる作業の時短について、Blogにまとめました。

<!--more-->

---


### 自動化のイメージ

自動化のイメージは下図になります。

![python_auto_fig1]({{ "assets/img/2020_08_15/automation_python_excel_file_1.png" | relative_url}})<br>

集計にあたり、以下のような一般的なEXCELを使った報告シートを想定してプログラムを組んでいます。

>１） 報告数分のEXCELファイルにそれぞれシートが一つ存在します（複数のシートがある場合最初のシートが対象になります）
>２） 入力シートのようにそれぞれのEXCELファイルのシート内の同じセルの位置に入力されています
>３） 集計するセルの場所（番地）は予め分かっているとします
>４） 集計するセルの場所以外に入力された内容は集計できません
>
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}


### Openpyxlとglob

[Openpyxl](https://openpyxl.readthedocs.io/en/stable/tutorial.html){:target="_blank"} とはPythonでExcel ファイルを読み書き等の操作するためのモジュールです。一旦、EXCELファイルをPythonのプログラムで読み込んでしまえば、値の挿入から書式の変更までPythonプログラムやJupyter Notebook上でEXCEL操作が可能になります。

複数のExcelファイルを読み込むために、[glob](https://docs.python.org/ja/3/library/glob.html){:target="_blank"} でフォルダ配下のExcel ファイルを順次読み込ませ、読み込んだエクセルのbookの最初のシートを `ws2`{:style="color: blue"}としています。

{% highlight python linenos %}

for gb in glob.glob(input_file_name, recursive=True):
     ws2 = xl.load_workbook(gb).worksheets[0]

{% endhighlight %}



`glob`{:style="color: blue"}はファイル操作のみならず色々なことができます。今回ご紹介するフォルダ配下のファイル（この場合はファイル属性xlsxのファイルすべて）を順次読み込ませるこのコードは、定番のコードサンプルとして覚えておくと便利です。



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

対応関係を図示します

![sh_values_list_format_1]({{ "assets/img/2020_08_15/sh_values_list_format_1.png" | relative_url}})<br>


### サンプルコード

{% highlight python linenos %}

# 必要なモジュールをインポートする
import openpyxl as xl
import glob

# 取りまとめるフォルダと配下のExcelファイルを指定 D:\excel_automation\
# 書き込みファイル名を指定 wb.xlsx  このファイルのロードし結果も書き込みます
# 別名で保存するので、そのファイルを指定　saved.xlsx
input_file_name= 'D:\excel_automation\*.xlsx' 
output_file_name = 'wb.xlsx'
saved_file_name = 'saved.xlsx'

# 書き込み用'wb.xlsx'=output_file_name を読み込み、book という名前にする
book = xl.load_workbook(output_file_name)
# アクティブシートを ws という名前で定義する
ws = book.active

# 最初の書き込み位置を2行目にセットする
line_num = 2  
# フォルダ内のファイルを取得
# 定数 'input_file_name'で指定したフォルダ配下の excelファイルがひとつづつ読み込まれる
for gb in glob.glob(input_file_name, recursive=True):
# 読み込まれるExcel bookの最初のシートをws2と定義する
​    ws2 = xl.load_workbook(gb).worksheets[0]
# ws2にある値を各行ごとのリスト形式です読み込む
​    sh_values=[[cell.value for cell in row] for row in ws2]
# wsの line_num行1列目にsh_valuesの(0,0)=>1行目の1列目の値（都道府県名）を代入する
​    ws.cell(row=line_num,column=1).value = sh_values[0][0]
# wsの line_num行2列目にsh_valuesの(3,3)=>4行目の4列目の値（代表者名）を代入する
​    ws.cell(row=line_num,column=2).value = sh_values[3][3]
# wsの line_num行3列目にsh_valuesの(2,1)=>3行目の2列目の値（Web参加人数）を代入する
​    ws.cell(row=line_num,column=3).value = sh_values[2][1]
# wsの line_num行4列目にsh_valuesの(3,2)=>4行目の3列目の値（都道府県番号）を代入する
​    ws.cell(row=line_num,column=4).value = sh_values[3][2]
# line_numを +1 する
​    line_num+=1
# bookをカレントディレクトリにセーブするファイル名はsaved_file_nameで定義される
​    book.save(saved_file_name)

{% endhighlight %}





---

### ひとこと

><p>メールでEXCELファイルを送信し、決められたフォームに必要事項を入力してもらって記入済のEXCELファイルを取りまとめるという作業はメールとEXCELがオフィスツールとして定着した30数年前から今日まで根強く蔓延ったルーチン作業の一つだと思います。<br>課内等の１０数件であれば、一時間もあれば手作業でも完了しますが、全国47都道府県分であるとか、全国営業店、支店から等で100件以上の三桁のオーダーとなると手作業では半日以上かかることも少なくありません。Pythonを駆使して時短に挑戦する価値があるルーチン作業だと思います。
