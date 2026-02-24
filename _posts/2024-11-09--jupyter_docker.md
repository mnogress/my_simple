---
layout: single
title:  Docker for Windows でJupyter Notebook コンテナを起動させる
header:
  overlay_image: images/header_A4.png
  overlay_filter: rgba(107, 74, 43, 0.20)
toc: true
toc_label: "目次"
toc_icon: "heart"
toc_sticky: True
excerpt_separator: <!--more-->
classes:
- landing
- dark-theme
#- wide
sidebar:
  nav: "docs"
tag: [Docker, Jupyter Notebook, Windows]
category: Python
date: 2024-11-09
last_modified_at : 2025-10-29 09:00:00
---



Docker 環境があると、ちょっとPythDon の勉強用の試しコード作成等や本来ならば個人のPCでやるべきようなことを仕事用などのPCを使う場合等、PCを汚したくない時にDocker環境の中にJupyter Notebook稼働環境を作ってPC環境から独立して使うことができます。

<!--more-->

<style type="text/css">

table {
  display: block;
  margin-bottom: 1em;
  width: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI", "Helvetica Neue", "Lucida Grande", Arial, sans-serif;
  font-size: 0.75em;
  border-collapse: collapse;
  overflow-x: auto;
}

table + table {
  margin-top: 1em;
}

thead {
  background-color: #e6e6fa;
  border-bottom: 2px solid #9b9b9d;
}

th {
  padding: 0.5em;
  font-weight: bold;
  text-align: start;
}

td {
  padding: 0.5em;
  border-bottom: 1px solid #9b9b9d;
}

tfoot {
  background-color: #afeeee;
  padding: 0.5em;
  border-top: 2px solid #9b9b9d;
  border-bottom: 2px solid #9b9b9d;
}

tr,
td,
th {
  vertical-align: middle;
}
_media screen and (max-width:1280px){
.p_table {width:100%;overflow:scroll;}
.p_table table {width:1153px;}
}
_media screen and (max-width:750px){
.resp_table {width:100% !important;}
.resp_table th ,.resp_table td{padding:10px !important;}
}
.rouge {
color: red;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.noir {
color: 1A818;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.bleu {
color: blue;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.petit {
font-size: 0.80em;
color: black;
font-family: inherit;
line-height: 1.1;
display: inline-block;
letter-spacing: inherit;
}

.custom-list-violet {
color: rgb(67, 31, 158);
font-size: 24px;
}

</style>

この記事で扱うPC環境は以下のとおりです。

| 仕様| 内容 |
| :----- | :----- |
| PCの仕様 | Windows 10 Pro バージョン21H1　16GB RAM                     |
| Docker   | Docker Desktop for Windows (version 20.10.8, build 3967b7d) |
| その他   | VS Code 1.62.2 |
{: class="table"} 

Docker Dockerfile の中身は以下のとおりです。ファイルの設置先は、Jupyter Notebook のドキュメントルートとなる<strong>WORKDIR</strong> に設置します。

![docker_1]({{ "/images/img/docker_1.png" | relative_url}}){:height="600px" width="600px"}<br>


### チートシート

| **コマンド**  | **用途**  |
| :----- | :----- |
| FROM  | ベースとなるイメージを指定します。  この例ではpython3.8-slim バージョンとしています。 |
| WORKDIR | RUN, CMD等実行するコンテナプロセスのワークディレクトリを指定します。この例では、/docker_jupyter としています。 |
| RUN | docker build 時に実行するコマンド  この例ではnumpy, pandas, jupyter notebook をインストールを指定しています |
| EXPOSE | Listen するポート番号を指定する環境変数です。  この例ではjupyter notebook の一般的な8888 を指定しています |
| CMD | docker run 時に実行するコマンド  この例ではjupyter notebookの起動オプションとしてjupyter notebook  --no-browser --port=8888 --ip=0.0.0.0 --allow-root　としています。 |
| ノートブック起動オプション | <span class="bleu">--no-browser</span><br/>    起動後にブラウザでノートブックを開かない。ログとして吐き出されるトークン付きURLをブラウザに直接貼り付けて開く必要があります。<br/><br/><span class="bleu">--allow-root</span><br/>    ノートブックをrootユーザーから実行できるようにします。<br/><br/><span class="bleu">--ip=</span><Unicode><br/>    ノートブックサーバが待ち受ける IP アドレス。<br/>    Default: 'localhost‘<br/>　0.0.0.0 とするとすべてのインターフェースで待ち受けることとなります。<br/>　<br/><span class="bleu">--port=</span><Int><br/>    ノートブックがリスンするポート番号(env: JUPYTER_PORT).<br/>    Default: 8888 |
{: style="font-size:0.70em;"}

### DockerイメージをDockerFileからビルドする

Dockerfile で指定した<strong>WORKDIR</strong>と同じディレクトリを作成します。このディレクトリの直下にDockerfile を設置します。

コマンドプロンプトより<strong>docker build -t dev_jupyter . </strong>と入力します。<strong>dev_jupyter</strong>という名前のDockerイメージが作られます。後述する<strong>compose.yml</strong>でもコンテナが無い場合は、Dockerイメージは作成されますが、Dockerfileで記述した内容どおりイメージファイルが作成されることを確認したいので、まずは以下のとおりDockerfille を起動します。

{% highlight python %}
PS C:\Users\xxxx\docker_jupyter> docker build -t dev_jupyter . 
[+] Building 62.5s (10/10) FINISHED
    省略
 => => naming to docker.io/library/dev_jupyter 
{% endhighlight %}


入力した内容とその詳細は下図を参照してください。

![docker_2]({{ "/images/img/docker_2.png" | relative_url}}){:height="600px" width="600px"}<br>


<strong>docker images</strong>とコマンド入力し、作成されたDocker イメージを確認します。添付のスクリーンショットのとおり作成されました。赤枠が今回作成したDockerイメージに相当します。


![docker_3]({{ "/images/img/docker_3.png" | relative_url}}){:height="600px" width="600px"}<br>


### コンテナを作成する

イメージを作成しただけではノートブックは使えません。ノートブックを使えるようにするため、コンテナを作成します。コマンドプロンプトから`RUN`コマンドで作成する方法とdocker-composeを使う方法を紹介します。


<div class="box33">
    <span class="box-title">Point！</span>
  <ol>  
<li>コンテナが消滅してもプログラムなどのユーザデータはWindows PC上に保存できるようでJupyter NotebookのファイルをコンテナとPC間で共有できる</li>
<li>Windows標準のコマンドプロンプト-【方法1】</li>
<li>GitBashとdocker-composeを使う方法-【方法2】</li>
 </ol>
</div>


### Windows標準のコマンドプロンプトの方法

コマンドプロンプトからRUNコマンドを入力して、コンテナをすぐ使える起動状態で作成します。Windows版のDocker を使っています。
共有できるようにするため、volumeを定義します。

<strong>C:\Users\xxxx\docker_jupyter</strong>をコンテナとPCの共有ディレクトリとし、Pythonコード等をPCからエキスプローラで直接共有できるようにします。コマンドの詳細は下図のとおりです。
Windows標準のコマンドプロンプトからコマンド投入することを前提にしたコマンドフォーマットを紹介します。　
{: .notice--info}

![docker_6]({{ "/images/img/docker_6.png" | relative_url}}){:height="600px" width="600px"}<br>


Windows標準のコマンドプロンプトからコマンド投入することを前提にしたコマンドフォーマットを紹介します。　
{: .notice--info}


<strong>docker container run -p 8888:8888  -v "%cd%":/docker_jupyter  dev_jupyter</strong>
<br>
以下が実際のコマンド投入後のログになります。

{% highlight python %}
C:\Users\xxxx\docker_jupyter>docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
dev_jupyter   latest    xxx93b79b3   20 hours ago   395MB

C:\Users\xxxx\docker_jupyter>docker container run -p 8888:8888  -v "%cd%":/docker_jupyter  dev_jupyter
   
  << 省略>>
    
    To access the notebook, open this file in a browser:

{% endhighlight %}

起動オプションで指定したとおり、ノートブックはブラウザから自動的に起動しません。<strong>copy and paste one of these URLs:</strong>とあるURLをブラウザのURL指定部分にコピペすると、下図のとおりノートブックがコンテナを起動した際のカレントディレクトリを共有ディレクトリ（コンテナの外のDirectory）上に起動します。これらのファイルはDocker コンテナーからアクセスしJupyter Notebook が起動するだけでなく、PCからもエキスプローラでアクセスできるようになります。


![docker_7]({{ "/images/img/docker_7.png" | relative_url}}){:height="600px" width="600px"}<br>




### docker-compose を使う方法

<strong>docker-compose.yml</strong>というcompose ファイルをDockefile と同じディレクトリに配下に設置します。

![docker_9]({{ "/images/img/docker_9.png" | relative_url}}){:height="600px" width="600px"}<br>


docker-compose.ymlの中身は以下のとおりです。ここでは、volume の記述<strong>${PWD}</strong>が とlinux 用のbashで記述していますので、Windows コマンドプロンプトではなく、[Git Bash](https://gitforwindows.org/) から<strong>docker-compose up</strong>コマンドを打つ必要があります。

![docker_8]({{ "/images/img/docker_8.png" | relative_url}}){:height="600px" width="600px"}<br>


コンテナが無い場合は、Dockerfile を参照してキャッシュからイメージを再作成した上でコンテナを作成します。
{: .notice--danger}

{% highlight python %}
$ docker-compose up
　　[+] Building 7.4s (8/8) FINISHED
 　　=> [internal] load build definition from Dockerfile 

 << 省略>>

{% endhighlight %}


