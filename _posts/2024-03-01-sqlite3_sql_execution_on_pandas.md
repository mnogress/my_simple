---
layout: single
title: Pandasデータフレームをsqlite3のSQL文で操作する
header:
  overlay_image: images/header_U.png
  overlay_filter: rgba(107, 74, 43, 0.40)
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
tag: [Python]
category: [Python]
date: 2023-03-01
last_modified_at : 2026-04-02 09:00:00
excerpt: >
  SQLite の SQL を Pandas 上で実行する方法をまとめた実務向けの解説です。誕生から半世紀近く経つ SQL は、今もデータ分析に欠かせない言語です。Pandas と組み合わせることで、従来の SQL 的な思考と Python ベースの分析を自然につなぐ“架け橋”として活用できます。

---

この記事では、Jupyter NotebookのPandasを使用してデータ分析を行う際に、
sqlite3で提供されるSQL文を使用してデータの読み込みと抽出操作をまとめました。<br>

<!--more-->

---
<style type="text/css">
</style>

### SQlite とは

1. [SQLite](https://www.sqlite.org/index.html){:target="_blank"}は、Cライブラリで、軽量なディスク上のデータベースを提供します。
2. サーバプロセスを別途用意する必要がなく、SQLクエリー言語（SQL文）を使用してデータベースにアクセスできます。
3. SQLiteを使用することで、アプリケーションのプロトタイプを迅速に作成し、そのコードを後でPostgreSQLやOracleなどの大規模データベースに移行できます。
4. そのため、[SQLite](https://www.sqlite.org/index.html){:target="_blank"}は、SQLデータベースを使うアプリ開発においては必須のツールとなっています。

---

### DB Browser for SQLite とは

1. [DB Browser for SQLite](https://sqlitebrowser.org/){:target="_blank"}は、SQLiteデータベースを管理するためのソフトウェアです。
2. SQLiteデータベースの作成、閲覧、編集が可能で、データベースの最適化によってファイルサイズを小さくすることもできます。
3. また、USBドライブから起動できるポータブル版も提供されており、SQLiteをより身近に利用できるようになっています。

多くの人がこのソフトウェアを利用した経験があるかもしれません。

---

###  sqlite3　モジュールとは

1. [sqlite3](https://docs.python.org/ja/3.5/library/sqlite3.html){:target="_blank"}モジュールは、Python上でデータセットをSQLデータベースとして格納し、
2. SQL文を使用してアクセスするためのインターフェイスを提供します。

このモジュールを使用することで、PythonでSQLiteの操作を行うことができます。


---

### サンプルデータセットとその読み込み方法について

1. [Kaggle_HR_attrition](https://www.kaggle.com/search?q=hr+attrition){:target="_blank"}で検索してデータセットをダウンロードしてください。
2. カレントディレクトリにダウンロードしたデータセットを配置して、Dataframeとして読み込みます。読み込むコードは以下のとおりです。

{% highlight python linenos %}
import codecs
with codecs.open("WA_Fn-UseC_-HR-Employee-Attrition.csv", 
    mode ="r", encoding ="utf-8", errors="ignore") as file:
    df = pd.read_csv(file, delimiter =",", header=0)
{% endhighlight %}

今回は、データクリーニング前のRaw Data の読み込みを前提としているため、上記の方法でCSV形式のファイルを読み込みます。<br>

<div class="box33">
    <span class="box-title">ポイント</span>
    <ol>
<li> <strong>mode ="r"</strong> 読み込みモードを指定します</li>
<li><strong>encoding ="utf-8"</strong>インターネットからダウンロードした場合は、<strong>utf-8</strong> を指定します。<br>Windows PC（Excel）で操作したデータを使う場合は、<strong>shift-jis</strong>を指定します。</li>
<li><strong>errors="ignore"</strong>を指定してデコードできない文字が含まれていた場合に無視(ignore)するを指定します。</li>
<li>CSVファイルをデータフレームとして読み込むにあたり<strong>delimiter =","</strong> CSVファイルなのでカンマを区切り文字にします。　</li>
<li><strong>header=0</strong>最初の行をヘッダーとして扱います。</li>
   </ol>
</div>


### sqlite DB を定義する

SQliteDBを作成します。DB名は<span class="bleu">HR_Employee_Attrition.db</span>としています。

以下のCode でDBを作成します。
ここでは、コメントにもあるとおり<span class="bleu">HR_Employee_Attrition.db</span>という名前のDBがなければ作成し、接続して使えるようにします。
すでに存在する場合は接続して使えるようにします。

{% highlight python linenos %}

#モジュールをインポートします
import sqlite3

#HR_Employee_Attrition.db という名前のDBをなければ作成して接続する
dbname = 'HR_Employee_Attrition.db'

conn = sqlite3.connect(dbname)
cur = conn.cursor()

{% endhighlight %}

---

#### SQlite DBにテーブルを定義し、データフレームの中身をテーブルに流し込む 

DB名は<span class="bleu">HR_Employee_Attrition.db</span>でその情報はconnectionオブジェクト <span class="bleu">conn</span> で引き継がれます。
DB内のテーブル名は<span class="rouge">HR_Employee_Attrition_tab</span>と定義します。

{% highlight python linenos %}
# tableのnameを"HR_Employee_Attrition_tab"とし、読み込んだcsvファイルをsqlに書き込む
# index=False としてindex は書き込まないようにする
df.to_sql('HR_Employee_Attrition_tab', conn, if_exists='replace', index=False)
{% endhighlight %}

<div class="box33">
    <span class="box-title">ポイント2</span>
    <ol>
<li> <strong>if_exists='replace`</strong> でテーブルが既に存在していた場合、上書きします。</li>
<li>データフレームが持つIndexはテーブルには書き込ませません。SQLite DB は独自にIndexを持ちますので、不要ですので、<strong>index=False</strong>を指定します。</li>
<li>CSVファイルをデータフレームとして読み込むにあたり<strong>delimiter =","</strong> CSVファイルなのでカンマを区切り文字にします。　</li>
<li>ls コマンドでファイルを確認すると、217,088 バイトの大きさで<strong>HR_Employee_Attrition.db</strong>というDBが作成されています。</li>
   </ol>
</div>



{% highlight python linenos %}
 ドライブ D のボリューム ラベルは ボリューム です
 ボリューム シリアル番号は C64A-8xx です

 D:\jupyter\sqliteDB のディレクトリ

2023/03/0x  14:35    <DIR>          .
2023/03/0x  14:35    <DIR>          ..
2023/03/0x  14:35           217,088 HR_Employee_Attrition.db
               1 個のファイル             217,088 バイト
               2 個のディレクトリ  212,100,857,856 バイトの空き領域
{% endhighlight %}

---

#### SQLite DB にアクセスしてSQL文を実行する

- 作成したSQlite DBにJupyter Notebook からアクセス（接続）し、SELECT文を使ってテーブルの中身を抽出します。
- 抽出したデータは、Pandas データフレームとして取り込みます。
- 以下のSELECT文では、テーブル全体すなわち、DBのデータ全部をデータフレームとして読み込むこととなります。

{% highlight python linenos %}

dbname = "HR_Employee_Attrition.db"
conn = sqlite3.connect(dbname)
cur = conn.cursor()

# dbをpandasで読み出す。
df = pd.read_sql('SELECT * FROM HR_Employee_Attrition_tab', conn)

cur.close()
conn.close()

{% endhighlight %}

Jupyter Notebook から内容を確認します。
 
![data_frame]({{ "/images/img/fig31011.png" | relative_url}}){:height="600px" width="600px"}<br>


---

### Here Document でSELECT文の見通しの良さをアップする

SELECT文等でクエリを組み込みますが、Pythonでは、区切り文字として引用符を3つ続ける<strong>「"""」文字列リテラル</strong>（いわゆる、ベタ打ち文字列）を持つことができます。　

改行できるため、抜き出すカラム名で改行させかつ、Query として独立させ、全体を見通しを良くさせます。 

このQueryでは、特定のカラムのみを抽出しますが、それ毎に改行しています。

また、条件として、<strong>"BusinessTravel"="Travel_Frequently"</strong>　かつ、<strong>"DailyRate" < 1350</strong>　かつ <strong>"Age" > 36</strong>に絞りますが、これも見やすくするため改行しています。

{% highlight python linenos %}

query = """
    SELECT 
          "Department", 
          "Age", 
          "Attrition", 
          "BusinessTravel", 
          "DailyRate"
    FROM  "HR_Employee_Attrition_tab" 
    WHERE "BusinessTravel"="Travel_Frequently" 
    AND   "DailyRate" < 1350
    AND   "Age" > 36
  """

{% endhighlight %}

このQuery を実行するコードは以下のとおりです。　すでに、DB名は<strong>dbname = "HR_Employee_Attrition.db"</strong>で定義していますので
その部分は省略していますので、注意してください。

{% highlight python linenos %}
conn = sqlite3.connect(dbname)
cur = conn.cursor()

# 変数Queryで定義したSQL 文を使ってpandas　Dataframeで読み出す。
df = pd.read_sql(query, conn)

{% endhighlight %}

内容を確認します。

![data_frame]({{ "/images/img/fig31012.png" | relative_url}}){:height="600px" width="600px"}<br>


---
