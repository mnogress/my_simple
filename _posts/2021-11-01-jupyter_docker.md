---
layout: post
title: Docker for Windows でJupyter Notebook コンテナを起動させる
feature-img: "assets/img/2020_08_15/ship-6271649_1280.jpg"
tags: [Docker, Jupyter Notebook, Windows]
excerpt_separator: <!--more-->
---

Docker 環境があると、ちょっとPythDon の勉強用の試しコード作成等や本来ならば個人のPCでやるべきようなことを仕事用などのPCを使う場合等、PCを汚したくない時にDocker環境の中にJupyter Notebook稼働環境を作ってPC環境から独立して使うことができます。

<!--more-->

この記事で扱うPC環境は以下のとおりです。

| 仕様     | 内容                                                        |
| -------- | ----------------------------------------------------------- |
| PCの仕様 | Windows 10 Pro バージョン21H1　16GB RAM                     |
| Docker   | Docker Desktop for Windows (version 20.10.8, build 3967b7d) |
| その他   | VS Code 1.62.2                                              |

Docker Dockerfile の中身は以下のとおりです。ファイルの設置先は、Jupyter Notebook のドキュメントルートとなるWORKDIR に設置します。

![docker_1]({{ "assets/img/2020_08_15/docker_1.png" | relative_url}})<br>

### チートシート

| **コマンド**               | **用途**                                                     |
| -------------------------- | ------------------------------------------------------------ |
| FROM                       | ベースとなるイメージを指定します。  この例ではpython3.8-slim バージョンとしています。 |
| WORKDIR                    | RUN, CMD等実行するコンテナプロセスのワークディレクトリを指定します。この例では、/docker_jupyter としています。 |
| RUN                        | docker build 時に実行するコマンド  この例ではnumpy, pandas, jupyter notebook をインストールを指定しています |
| EXPOSE                     | Listen するポート番号を指定する環境変数です。  この例ではjupyter notebook の一般的な8888 を指定しています |
| CMD                        | docker run 時に実行するコマンド  この例ではjupyter notebookの起動オプションとしてjupyter notebook  --no-browser --port=8888 --ip=0.0.0.0 --allow-root　としています。 |
| ノートブック起動オプション | --no-browser<br/>    起動後にブラウザでノートブックを開かない。ログとして吐き出されるトークン付きURLをブラウザに直接貼り付けて開く必要があります。<br/><br/>--allow-root<br/>    ノートブックをrootユーザーから実行できるようにします。<br/><br/>--ip=<Unicode><br/>    ノートブックサーバが待ち受ける IP アドレス。<br/>    Default: 'localhost‘<br/>　0.0.0.0 とするとすべてのインターフェースで待ち受けることとなります。<br/>　<br/>--port=<Int><br/>    ノートブックがリスンするポート番号(env: JUPYTER_PORT).<br/>    Default: 8888 |

### DockerイメージをDockerFileからビルドする

Dockerfile で指定したWORKDIR と同じディレクトリを作成します。このディレクトリの直下にDockerfile を設置します。

コマンドプロンプトより`docker build -t dev_jupyter . `{:style="background: #ffebf6"}と入力します。`dev_jupyter`{:style="background: #ffebf6"}という名前のDockerイメージが作られます。後述する`compose.yml`でもコンテナが無い場合は、Dockerイメージは作成されますが、Dockerfileで記述した内容どおりイメージファイルが作成されることを確認したいので、まずはDockerfille を起動します。

{% highlight python %}
PS C:\Users\xxxx\docker_jupyter> docker build -t dev_jupyter . 
[+] Building 62.5s (10/10) FINISHED
 => [internal] load build definition from Dockerfile
 => => transferring dockerfile: 524B 
 => [internal] load .dockerignore => transferring context:
 => [internal] load metadata for docker.io/library/python:3.8.3-slim                     
 => [auth] library/python:pull token for registry-1.docker.io                             
 => [internal] load build context                                                         
 => => transferring context: 2.53MB                      
 => CACHED [1/3] FROM docker.io/library/python:3.8.3
 slim@sha256:938fd440a888e9dbac3de374b8ba4
 => [2/3] WORKDIR /docker_jupyter                        
 => [3/3] RUN pip install numpy && pip install pandas && pip install jupyter
 => exporting to image                            
 => => exporting layers                                                                   
 => => writing image sha256:f88825ec2b01676addbdd482f8bb3b77bca6325d7efacf8f
 => => naming to docker.io/library/dev_jupyter 
{% endhighlight %}

入力した内容とその詳細は下図を参照してください。

![docker_2]({{ "assets/img/2020_08_15/docker_2.png" | relative_url}})<br>

`docker images`{:style="background: #ffebf6"}とコマンド入力し、作成されたDocker イメージを確認します。添付のスクリーンショットのとおり作成されました。赤枠が今回作成したDockerイメージに相当します。

![docker_3]({{ "assets/img/2020_08_15/docker_3.png" | relative_url}})<br>


### コンテナを作成する

イメージを作成しただけではノートブックは使えません。ノートブックを使えるようにするため、コンテナを作成します。コマンドプロンプトから`RUN`コマンドで作成する方法とdocker-composeを使う方法を紹介します。

>
>`[Point！]`{:style="color: blue; font-size: 1.3em"} <br>
>
>コンテナが消滅してもプログラムなどのユーザデータはWindows PC上に保存できるようでJupyter NotebookのファイルをコンテナとPC間で共有できるようにする。
>【方法1】Windows標準のコマンドプロンプト<br>
>【方法2】GitBashとdocker-composeを使う方法を紹介します。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}



### Windows標準のコマンドプロンプトの方法

コマンドプロンプトからRUNコマンドを入力して、コンテナをすぐ使える起動状態で作成します。Windows版のDocker を使っています。
共有できるようにするため、volumeを定義します。

`C:\Users\xxxx\docker_jupyter`{:style="background: #ffebf6"}をコンテナとPCの共有ディレクトリとし、Pythonコード等をPCからエキスプローラで直接共有できるようにします。コマンドの詳細は下図のとおりです。

![docker_6]({{ "assets/img/2020_08_15/docker_6.png" | relative_url}})<br>

Windows標準のコマンドプロンプトからコマンド投入することを前提にしたコマンドフォーマットを紹介します。　

`docker container run -p 8888:8888  -v "%cd%":/docker_jupyter  dev_jupyter`{:style="background: #ffebf6"}
<br>
以下が実際のコマンド投入後のログになります。

{% highlight python %}
C:\Users\xxxx\docker_jupyter>docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
dev_jupyter   latest    xxx93b79b3   20 hours ago   395MB

C:\Users\xxxx\docker_jupyter>docker container run -p 8888:8888  -v "%cd%":/docker_jupyter  dev_jupyter
[I 01:36:41.843 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret        
[I 01:36:44.472 NotebookApp] Serving notebooks from local directory: /docker_jupyter
[I 01:36:44.472 NotebookApp] Jupyter Notebook 6.4.5 is running at:
[I 01:36:44.472 NotebookApp] http://547aa9fcc555:8888/?token=ba2fadfa74b2779e84e2f52cd07296c5aexxxxxxxbe05fd5
[I 01:36:44.472 NotebookApp]  or http://127.0.0.1:8888/?token=ba2fadfa74b2779e84e2f52cd07296c5aexxxxxxxbe05fd5
[I 01:36:44.472 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 01:36:44.500 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
    Or copy and paste one of these URLs:
        http://547aa9fcc555:8888/?token=ba2fadfa74b2779e84e2f52cd07296c5aexxxxxxxbe05fd5
     or http://127.0.0.1:8888/?token=ba2fadfa74b2779e84e2f52cd07296c5aexxxxxxxbe05fd5
{% endhighlight %}

起動オプションで指定したとおり、ノートブックはブラウザから自動的に起動しません。`copy and paste one of these URLs:`とあるURLをブラウザのURL指定部分にコピペすると、下図のとおりノートブックがコンテナを起動した際のカレントディレクトリを共有ディレクトリ（コンテナの外のDirectory）上に起動します。これらのファイルはDocker コンテナーからアクセスしJupyter Notebook が起動するだけでなく、PCからもエキスプローラでアクセスできるようになります。


![docker_7]({{ "assets/img/2020_08_15/docker_7.png" | relative_url}})<br>




#### docker-compose を使う方法

`docker-compose.yml`というcompose ファイルをDockefile と同じディレクトリに配下に設置します。

![docker_9]({{ "assets/img/2020_08_15/docker_9.png" | relative_url}})<br>


docker-compose.ymlの中身は以下のとおりです。ここでは、volume の記述`${PWD}`が とlinux 用のbashで記述していますので、Windows コマンドプロンプトではなく、[Git Bash](https://gitforwindows.org/) から`docker-compose up`コマンドを打つ必要があります。

![docker_8]({{ "assets/img/2020_08_15/docker_8.png" | relative_url}})<br>


コンテナが無い場合は、Dockerfile を参照してキャッシュからイメージを再作成した上でコンテナを作成します。

{% highlight python %}
$ docker-compose up
[+] Building 7.4s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                  
 => => transferring dockerfile: 32B                                 
 => [internal] load .dockerignore                          
 => => transferring context: 2B                                                     
 => [internal] load metadata for docker.io/library/python:3.8-slim        
 => [auth] library/python:pull token for registry-1.docker.io                   
 => [1/3] FROM docker.io/library/python:3.8-slim@sha256:d31a1beb6ccddbf5b5c72904853f5c2c4d1f49bb8186b623db0b80f8c
 => CACHED [2/3] WORKDIR /docker_jupyter                      
 => CACHED [3/3] RUN pip install numpy && pip install pandas && pip install jupyter       
 => exporting to image                                                              
 => => exporting layers            
 => => writing image sha256:f5b900a3d468b201d9d9cac385a6272652c622dba8792050bd1c20eebc590e67                   
 => => naming to docker.io/library/docker_jupyter_dev_jupyter                             
[+] Running 2/2
 - Network docker_jupyter_default  Created                                   
 - Container dev_jupyter-notebook  Created        
Attaching to dev_jupyter-notebook
dev_jupyter-notebook  | [I 04:13:30.766 NotebookApp] Jupyter Notebook 6.4.5 is running at:
dev_jupyter-notebook  | [I 04:13:30.766 NotebookApp] http://251935dd8e24:8888/?token=92b70407a6d54ba14006911fcc5665bd4c51808d070deb15   b15                            eb15  
dev_jupyter-notebook  | [I 04:13:30.766 NotebookApp]  or http://127.0.0.1:8888/?token=92b70407a6d54ba14006911fcc5665bd4c51808d070dnfirmation).eb15
dev_jupyter-notebook  | [I 04:13:30.766 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
dev_jupyter-notebook  | [C 04:13:30.795 NotebookApp]
dev_jupyter-notebook  |
dev_jupyter-notebook  | To access the notebook, open this file in a browser:
dev_jupyter-notebook  | file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
dev_jupyter-notebook  | Or copy and paste one of these URLs:           000ms
dev_jupyter-notebook  | http://251935dd8e24:8888/?token=92b70407a6d54ba14006911fcc5665bd4c51808d070deb15                   0.940
dev_jupyter-notebook  |      or http://127.0.0.1:8888/?token=92b70407a6d54ba14006911fcc5665bd4c51808d070deb15
dev_jupyter-notebook  | [I 04:14:30.667 NotebookApp] 302 GET /?token=92b70407a6d54ba14006911fcc5665bd4c51808d070deb15 (172.18.0.1) 0.940000ms


$ docker-compose up
[+] Running 1/0
 - Container dev_jupyter-notebook  Created                                                   0.0s 
Attaching to dev_jupyter-notebook
dev_jupyter-notebook  | [I 04:24:12.044 NotebookApp] Serving notebooks from local directory: /docker_jupyter
dev_jupyter-notebook  | [I 04:24:12.044 NotebookApp] Jupyter Notebook 6.4.5 is running at:
dev_jupyter-notebook  | [I 04:24:12.044 NotebookApp] http://251935dd8e24:8888/?token=34a5c0bfbbe7359004b4ac759a5749a90b3853e205f7ba34
dev_jupyter-notebook  | [I 04:24:12.045 NotebookApp]  or http://127.0.0.1:8888/?token=34a5c0bfbbe7359004b4ac759a5749a90b3853e205f7ba34
dev_jupyter-notebook  | [I 04:24:12.045 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
dev_jupyter-notebook  | [C 04:24:12.056 NotebookApp]
dev_jupyter-notebook  |
dev_jupyter-notebook  |     To access the notebook, open this file in a browser:
dev_jupyter-notebook  |         file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
dev_jupyter-notebook  |     Or copy and paste one of these URLs:
dev_jupyter-notebook  |         http://251935dd8e24:8888/?token=34a5c0bfbbe7359004b4ac759a5749a90b3853e205f7ba34
dev_jupyter-notebook  |      or http://127.0.0.1:8888/?token=34a5c0bfbbe7359004b4ac759a5749a90b3853e205f7ba34
 {% endhighlight %}


