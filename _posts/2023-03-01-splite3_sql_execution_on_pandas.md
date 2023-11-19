---
layout: post
title: Pandasデータフレームをsqlite3のSQL文で操作する
feature-img: "assets/img/2020_08_15/cat-gf45769994_640.png"
tags: [Python, sqlite3, SQL ]
excerpt_separator: <!--more-->
---


この記事では、Jupyter Notebookを使用してデータ分析を行う際に、
sqlite3で提供されるSQL文を使用してデータの読み込みと抽出操作をまとめました。

[SQLite](https://www.sqlite.org/index.html){:target="_blank"}は、軽量なディスク上のデータベースを提供するCライブラリです。
サーバプロセスを別途用意する必要がなく、SQLクエリー言語（SQL文）を使用してデータベースにアクセスできます。
SQLiteを使用することで、アプリケーションのプロトタイプを作成し、
そのコードを後でPostgreSQLやOracleなどの大規模データベースに移行できるため、
アプリ開発においてSQLデータベースの必須ツールとなっています。

今回は、Jupyter Notebookを使用したデータ分析を前提に、
sqlite3で提供されるSQL文を使用してデータの読み込みおよび抽出の操作方法をまとめました。

<!--more-->

[DB Browser for SQLite](https://sqlitebrowser.org/){:target="_blank"}は、
SQLiteデータベースを管理するためのソフトウェアです。
SQLiteデータベースの作成、閲覧、編集が可能で、データベースの最適化によってファイルサイズを小さくすることもできます。
また、USBドライブから起動できるポータブル版も提供されており、
SQLiteをより身近に利用できるようになっています。
多くの人がこのソフトウェアを利用した経験があるかもしれません。

[sqlite3](https://docs.python.org/ja/3.5/library/sqlite3.html){:target="_blank"}モジュールは、
Python上でデータセットをSQLデータベースとして格納し、
SQL文を使用してアクセスするためのインターフェイスを提供します。
このモジュールを使用することで、PythonでSQLiteの操作を行うことができます。

このブログがPythonプログラムでSQLの統合を行う際に役立つことを願っています。




---

### サンプルデータセット

[サンプルデータセット](https://www.so-wi.com/2019/06/01/reference_data.html){:target="_blank"}で紹介した「データセット3: HR データ」を使います。他のデータセットでももちろん可能ですが、このデータセットに興味のある方は、[Kaggle_HR_attrition](https://www.kaggle.com/search?q=hr+attrition){:target="_blank"}で検索してデータセットをダウンロードしてください。

カレントディレクトリにダウンロードしたデータセットを配置して、Dataframeとして読み込みます。読み込むコードは以下のとおりです。

{% highlight python linenos %}
import codecs
with codecs.open("WA_Fn-UseC_-HR-Employee-Attrition.csv", mode ="r", encoding ="utf-8", errors="ignore") as file:
    df = pd.read_csv(file, delimiter =",", header=0)
{% endhighlight %}

今回は、データクリーニング前のRaw Data の読み込みを前提としているため、
[UnicodeDecodeErrorで csv ファイルが読み込みエラーになる](https://www.so-wi.com/portfolio/csv-read-error){:target="_blank"}でもご紹介している方法でCSV形式のファイルを読み込みます。
1. `mode ="r"`{:style="background: #ffebf6"} 読み込みモードを指定します。
2. `encoding ="utf-8"`{:style="background: #ffebf6"} インターネットからダウンロードした場合は、`utf-8`{:style="background: #ffebf6"} を指定します。Windows PC（Excel）で操作したデータを使う場合は、`shift-jis`{:style="background: #ffebf6"}を指定します。
3. `errors="ignore"`{:style="background: #ffebf6"}を指定してデコードできない文字が含まれていた場合に無視(ignore)するを指定します。
4. CSVファイルをデータフレームとして読み込むにあたり`delimiter =","`{:style="background: #ffebf6"} CSVファイルなのでカンマを区切り文字にします。　
5. `header=0`{:style="background: #ffebf6"}最初の行をヘッダーとして扱います。

### sqlite DB を定義する

SQliteDBを作成します。DB名は`HR_Employee_Attrition.db`{:style="background: #ffebf6"}としています。以下のCode でDBを作成します。
ここでは、コメントにもあるとおりHR_Employee_Attrition.db`という名前のDBがなければ作成し、接続して使えるようにします。
すでに存在する場合は接続して使えるようにします。

{% highlight python linenos %}

#モジュールをインポートします
import sqlite3

#HR_Employee_Attrition.db という名前のDBをなければ作成して接続する
dbname = 'HR_Employee_Attrition.db'

conn = sqlite3.connect(dbname)
cur = conn.cursor()

{% endhighlight %}


### SQlite DBにテーブルを定義し、データフレームの中身をテーブルに流し込む 

DB名はHR_Employee_Attrition.dbでその情報はconnectionオブジェクト `conn`{:style="background: #ffebf6"} で引き継がれます。
DB内のテーブル名は`HR_Employee_Attrition_tab`{:style="background: #ffebf6"}と定義します。

{% highlight python linenos %}
# tableのnameを"HR_Employee_Attrition_tab"とし、読み込んだcsvファイルをsqlに書き込む
# index=False としてindex は書き込まないようにする
df.to_sql('HR_Employee_Attrition_tab', conn, if_exists='replace', index=False)
{% endhighlight %}

1. `if_exists='replace`{:style="background: #ffebf6"}でテーブルが既に存在していた場合、上書きします。
2. データフレームが持つIndexはテーブルには書き込ませません。SQLite DB は独自にIndexを持ちますので、不要ですので、`index=False`{:style="background: #ffebf6"}を指定します。

ls コマンドでファイルを確認すると、217,088 バイトの大きさで`HR_Employee_Attrition.db`{:style="background: #ffebf6"}というDBが作成されています。

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

### SQLite DB にアクセスしてSQL文を実行する

作成したSQlite DBにJupyter Notebook からアクセス（接続）し、SELECT文を使ってテーブルの中身を抽出します。
抽出したデータは、Pandas データフレームとして取り込みます。
以下のSELECT文では、テーブル全体すなわち、DBのデータ全部をデータフレームとして読み込むこととなります。

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
 
![data_frame]({{ "assets/img/2020_08_15/fig31011.png" | relative_url}})<br>


---

### Here Document でSELECT文の見通しの良さをアップする

SELECT文等でクエリを組み込みますが、Pythonでは、区切り文字として引用符を3つ続ける「`"""`」文字列リテラル（いわゆる、ベタ打ち文字列）を持つことができます。　改行できるため、抜き出すカラム名で改行させかつ、Query として独立させ、全体を見通しを良くさせます。 

このQueryでは、抽出するカラムを`"Department", "Age", "Attrition", "BusinessTravel", "DailyRate"`{:style="background: #ffebf6"}のみを抽出しますが、それ毎に改行しています。
また、条件として、`"BusinessTravel"="Travel_Frequently"`{:style="background: #ffebf6"}　かつ、`"DailyRate" < 1350`{:style="background: #ffebf6"}　かつ `"Age" > 36`{:style="background: #ffebf6"}に絞りますが、これも見やすくするため改行しています。

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

このQuery を実行するコードは以下のとおりです。　すでに、DB名は`dbname = "HR_Employee_Attrition.db"`{:style="background: #ffebf6"}で定義していますので
その部分は省略していますので、注意してください。

{% highlight python linenos %}
conn = sqlite3.connect(dbname)
cur = conn.cursor()

# 変数Queryで定義したSQL 文を使ってpandas　Dataframeで読み出す。
df = pd.read_sql(query, conn)

{% endhighlight %}

内容を確認します。

![data_frame]({{ "assets/img/2020_08_15/fig31012.png" | relative_url}})<br>




>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em; background-color: #ffe3e2"} 
sqlite3 モジュールで作成したDBは、DB Browser for SQLiteから操作可能です。SQL文の練習には、Python 上のsqlite3を使うだけでなく、DB Browser for SQLiteを使ってみるのも、環境のセットアップ等を考えると効率的に行えます。sqlite3と一緒にDB Browser for SQLiteをPCにインストールして一緒に遊んでみるのも、いいかもしれません
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

---


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [サンプルデータセットの説明](https://www.so-wi.com/2019/06/01/reference_data.html){:target="_blank"}<br>
2) [UnicodeDecodeErrorで csv ファイルが読み込みエラーになる](https://www.so-wi.com/portfolio/csv-read-error){:target="_blank"}<br>
3) [DB Browser for SQLite](https://sqlitebrowser.org/){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}