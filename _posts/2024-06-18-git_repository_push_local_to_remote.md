---
layout: single
title: error：remote origin already exists. の解決方法
header:
  overlay_image: images/header_L.png
  overlay_filter: rgba(107, 74, 43, 0.40)
toc: True
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
category: Reference
tag: ["Github"]
date: 2024-06-11
last_modified_at : 2024-08-21 15:00:00
---

新しくリモートリポジトリを追加するために投入したgit remote add でerror: remote origin already exists. の解決方法<!--more-->
についてまとめました。 

[**Adding a remote repository**](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories){:target="_blank"}
で紹介されているページの解説になります。


<div class="box33">
    <span class="box-title">前提</span>
    <ol>
      <li>新しくリモートリポジトリを追加するには、<strong>git remote add</strong>が必要です(以下、原文)</li>
      <li>To add a new remote, use the git remote add command on the terminal, in the directory your repository is stored at.</li>
    </ol> 
</div>



### error: remote origin already exists. のエラーログ

{% highlight diff linenos  %}

user@user MINGW64 ~/docker_xxx (main)
$ git remote add origin git@github.com:hoge/docker_xxx.git
error: remote origin already exists.

{% endhighlight %}

Line#3 のとおり、*error: remote origin already exists.* で怒られました。（#^ω^）
{: .notice--danger}

### 解決方法

[Removing a remote repository](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories#removing-a-remote-repository){:target="_blank"}のとおり以下の2ステップです。


STEP1. git remote rm origin を投入<br>
STEP2. 再度、git remote add originを投入
{: .notice--info}

{% highlight diff linenos  %}
user@user MINGW64 ~/docker_xxx (main)
$ git remote rm origin

user@user MINGW64 ~/docker_xxx (main)
$ git remote add origin git@github.com:hoge/docker_xxx.git

{% endhighlight %}


### git push origin main でリモートに追加

無事にGitHubへpushできました。

{% highlight diff linenos  %}

user@user MINGW64 ~/docker_xxx (main)
$ git push origin main
Enumerating objects: 592, done.
Counting objects: 100% (592/592), done.
Delta compression using up to 8 threads
Compressing objects: 100% (549/549), done.
Writing objects: 100% (592/592), 16.12 MiB | 674.00 KiB/s, done.
Total 592 (delta 313), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (313/313), done.
To github.com:hoge/docker_xxx.git
 * [new branch]      main -> main

user@user MINGW64 ~/docker_xxx (main)

{% endhighlight %}

### .git/config について

<div class="box33">
    <span class="box-title">解説</span>
    <ol>
      <li>git remote add origin ~は.git/configファイルに[remote "origin"]を設定するコマンドです。従って、これを一旦、削除すれば追加(add)できます。</li>
      <li>git remote rm はサーバーからリモート リポジトリを削除しません。リモートとその参照をローカル リポジトリから削除するだけです。</li>
    </ol> 
</div>


### .git/config の中身を見る

{% highlight diff linenos  %}

user@user MINGW64 ~/docker_xxx (main)
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
[remote "origin"]
        url = git@github.com:hoge/docker_xxx.git
        fetch = +refs/heads/*:refs/remotes/origin/*

{% endhighlight %}

