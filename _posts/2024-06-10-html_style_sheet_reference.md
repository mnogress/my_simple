---
layout: single
title: HTML/Markdown style sheet reference
header:
  overlay_image: images/header_M.png
  overlay_filter: rgba(107, 74, 43, 0.18)
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
tag: ["HTML", "Markdown", "css"]
date: 2024-08-20
last_modified_at : 2024-08-21 16:00:00
---

HTML/Markdown のStyle sheet reference になります。 <!--more-->

### コメントBox28(#DF8914;)

<div class="box28">
    <span class="box-title">ここにタイトル</span>
    <p>ここに文章</p>
</div>

<style>
.box28 {
    position: relative;
    margin: 2em 0;
    padding: 15px 10px 7px;
    border: solid 2px #DF8914;
    border-radius: 6px;
}
.box28 .box-title {
    position: absolute;
    display: inline-block;
    top:  -15px;
    left:  15px;
    padding: 0 9px;
    height: 35px;
    line-height: 35px;
    font-size: 20px;
    background: #DF8914;
    color: #ffffff;
    font-weight: bold;
    border-radius: 6px;
}
.box28 p {
    margin: 0; 
    padding: 1em;
}
</style>

{% highlight python linenos %}

<div class="box28">
    <span class="box-title">ここにタイトル</span>
    <p>ここに文章</p>
</div>

<style>
.box28 {
    position: relative;
    margin: 2em 0;
    padding: 25px 10px 7px;
    border: solid 3px #DF8914;
}
.box28 .box-title {
    position: absolute;
    display: inline-block;
    top: -2px;
    left: -2px;
    padding: 0 9px;
    height: 35px;
    line-height: 35px;
    font-size: 20px;
    background: #DF8914;
    color: #ffffff;
    font-weight: bold;
}
.box28 p {
    margin: 0; 
    padding: 1em;
}
</style>
{% endhighlight %}


### コメントBox33(#0092ca;)

<div class="box33">
    <span class="box-title">ここにタイトル</span>
    <p>ここに文章</p>
</div>

<style>
.box33 {
    position: relative;
    margin: 2em 0;
    padding: 15px 10px 7px;
    border: solid 2px #0092ca;
    border-radius: 6px;
}
.box33 .box-title {
    position: absolute;
    display: inline-block;
    top:  -15px;
    left:  15px;
    padding: 0 9px;
    height: 35px;
    line-height: 35px;
    font-size: 20px;
    background: #0092ca;
    color: #ffffff;
    font-weight: bold;
    border-radius: 6px;
}
.box33 p {
    margin: 0; 
    padding: 1em;
}
</style>

{% highlight python linenos %}

<div class="box33">
    <span class="box-title">ここにタイトル</span>
    <p>ここに文章</p>
</div>

<style>
.box33 {
    position: relative;
    margin: 2em 0;
    padding: 15px 10px 7px;
    border: solid 2px #0092ca;
    border-radius: 6px;
}
.box33 .box-title {
    position: absolute;
    display: inline-block;
    top:  -15px;
    left:  15px;
    padding: 0 9px;
    height: 35px;
    line-height: 35px;
    font-size: 20px;
    background: #0092ca;
    color: #ffffff;
    font-weight: bold;
    border-radius: 6px;
}
.box33 p {
    margin: 0; 
    padding: 1em;
}
</style>

{% endhighlight %}


### Box11(#DF1452;)

<div class="box11">
    <span class="box-title">ここにタイトル</span>
    <p>ここに文章</p>
</div>

<style>
.box11 {
    position: relative;
    margin: 2em 0;
    padding: 25px 10px 7px;
    border: solid 3px #DF1452;
}
.box11 .box-title {
    position: absolute;
    display: inline-block;
    top: -2px;
    left: -2px;
    padding: 0 9px;
    height: 35px;
    line-height: 35px;
    font-size: 20px;
    background: #DF1452;
    color: #ffffff;
    font-weight: bold;
}
.box11 p {
    margin: 0; 
    padding: 1em;
}
</style>

{% highlight python linenos %}

<div class="box11">
    <span class="box-title">ここにタイトル</span>
    <p>ここに文章</p>
</div>

<style>
.box11 {
    position: relative;
    margin: 2em 0;
    padding: 25px 10px 7px;
    border: solid 3px #DF1452;
}
.box11 .box-title {
    position: absolute;
    display: inline-block;
    top: -2px;
    left: -2px;
    padding: 0 9px;
    height: 35px;
    line-height: 35px;
    font-size: 20px;
    background: #DF1452;
    color: #ffffff;
    font-weight: bold;
}
.box11 p {
    margin: 0; 
    padding: 1em;
}
</style>

{% endhighlight %}

### 枠で囲む

{% highlight python linenos %}
　<div style="font-size: 130%; padding: 20px; margin-bottom: 10px; border: 3px solid #DF1452; border-radius: 8px;">
   ここにテキストはいる
　</div>

{% endhighlight %}

<div style="font-size: 130%; padding: 20px; margin-bottom: 10px; border: 3px solid #DF1452; border-radius: 8px;">
   ここにテキストはいる　font-size: 130%; border: 3px solid #DF1452; border-radius: 8px;
</div>
<div style="font-size: 80%; padding: 20px; margin-bottom: 10px; border: 3px solid #0092ca; border-radius: 12px;">
   ここにテキストはいる　font-size: 80%; border: 3px solid #0092ca; border-radius: 12px;
</div>
<div style="padding: 20px; margin-bottom: 10px; border: 7px dashed #DF8914; border-radius: 5px;">
   ここにテキストはいる　 border: 7px dashed #DF8914; border-radius: 5px;
</div>
<div style="padding: 20px; margin-bottom: 10px; border: 3px double #14DF20; border-radius: 5px; border-width: thick;">
   ここにテキストはいる　 border: 3px double #14DF20; border-radius: 5px; border-width: thick;
</div>


### 文字の強調

{% highlight python linenos %}
　`ascending = False`{:style="background: #ff0044; color: white; font-size: 150%"}
{% endhighlight %}

150% で白抜き文字、赤背景

　`ascending = False`{:style="background: #ff0044; color: white; font-size: 150%"}

### 早見表

| 16進コード | rgbコード    |color name | サンプル|
| :-----    | :-----   |:---- | :----: |
|#ffd700     |  rgb(255, 215, 0)   |Gold| `　　`{:style="background: #ffd700"}　|
|#40e0d0     |  rgb(0, 255, 238)   |Turquoise|`　　`{:style="background: #40e0d0"}　|
|#696969     |  rgb(105, 105, 105)   |dimgray|`　　`{:style="background: #696969"}　|
|#e6e6fa     |  rgb(230, 230, 250)   |lavender|`　　`{:style="background: #e6e6fa"}　|
|#008080     |  rgb(0, 128, 128)   |teal|`　　`{:style="background: #008080"}　|
|#dc143c     |  rgb(220, 20, 60)   |crimson|`　　`{:style="background: #dc143c"}　|


{% highlight python linenos %}
`git@github.com:`{:style="background: #ffd700; font-size: 120%"} <br> 
`git@github.com:`{:style="background: #40e0d0; font-size: 120%"} <br> 
`git@github.com:`{:style="background: #696969; font-size: 120%"} <br> 
`git@github.com:`{:style="background: #e6e6fa; font-size: 120%"} <br> 
`git@github.com:`{:style="background: #008080; font-size: 120%; color: white"} <br> 
`git@github.com:`{:style="background: #dc143c; font-size: 120%; color: white"} <br>



{% endhighlight %}

  `git@github.com:`{:style="background: #ffd700; font-size: 120%"} <br>
  `git@github.com:`{:style="background: #40e0d0; font-size: 120%"} <br>
  `git@github.com:`{:style="background: #696969; font-size: 120%"} <br>
  `git@github.com:`{:style="background: #e6e6fa; font-size: 120%"} <br>
  `git@github.com:`{:style="background: #008080; font-size: 120%; color: white"} <br>
  `git@github.com:`{:style="background: #dc143c; font-size: 120%; color: white"} <br>




### Style  before擬似要素の使い方 h1 が"◆"から開始される。

{% highlight html linenos %}

<style>
h1:before {
content: "◆";
color: #326693;
}
/*p:before {
content: "★";
color: #b20000;
}*/
</style>

<h1>before擬似要素の使い方</h1>
<p>特定のセレクタにbefore擬似要素を追加します。</p>
<p></p>

{% endhighlight %}


<style>
h1:before {
content: "◆";
color: #326693;
}
/*p:before {
content: "★";
color: #b20000;
}*/
</style>

<h1>before擬似要素の使い方</h1>
<p>特定のセレクタにbefore擬似要素を追加します。</p>
<p></p>


### Box シャドー

{% highlight python linenos %}
<div style="padding: 20px; margin-bottom: 10px; border: 2px solid rgb(0, 146,202); 
 border-radius: 10px; text-align: center; background-color: rgb(0, 146,202);
 box-shadow: 6px 6px 6px rgba( 128, 128, 128, 1.0);">
 <strong style="color: rgb(255, 255, 255); 
 font-size: 24px;">東京の中心部に位置するこのレストランは、伝統的な日本料理とモダンなアレンジを融合させた独自のメニューで知られています。</strong>
</div>

{% endhighlight %}



<div style="padding: 20px; margin-bottom: 10px; border: 2px solid rgb(0, 146,202); 
 border-radius: 10px; text-align: center; background-color: rgb(0, 146,202);
 box-shadow: 6px 6px 6px rgba( 128, 128, 128, 1.0);">
 <strong style="color: rgb(255, 255, 255); 
 font-size: 24px;">東京の中心部に位置するこのレストランは、伝統的な日本料理とモダンなアレンジを融合させた独自のメニューで知られています。</strong>
</div>

### Point 枠の応用

{% highlight python html %}

<details>
    <summary>Point 枠の応用Coding結果</summary>
    <div class="box28">
    <span class="box-title">Point</span>
    <p style="font-size: 130%; color: blue;">df = df[df['メールアドレス'].str.contains('@example.org')]　<strong>含む</strong>で抽出<br>
    df = df[~df['メールアドレス'].str.contains('@example.org')]　<strong>含まない</strong>で抽出</p>
    </div>
</details>

<style>
.box28 {
    position: relative;
    margin: 2em 0;
    padding: 25px 10px 7px;
    border: solid 5px #FFC107;
}
.box28 .box-title {
    position: absolute;
    display: inline-block;
    top: -2px;
    left: -2px;
    padding: 0 9px;
    height: 25px;
    line-height: 25px;
    font-size: 17px;
    background: #FFC107;
    color: #ffffff;
    font-weight: bold;
}
.box28 p {
    margin: 0; 
    padding: 0;
}
</style>

{% endhighlight %}

<details>
    <summary>Point 枠の応用Coding結果</summary>
    <div class="box28">
    <span class="box-title">Point</span>
    <p style="font-size: 130%; color: blue;">df = df[df['メールアドレス'].str.contains('@example.org')]　<strong>含む</strong>で抽出<br>
    df = df[~df['メールアドレス'].str.contains('@example.org')]　<strong>含まない</strong>で抽出</p>
    </div>
</details>

<style>
.box28 {
    position: relative;
    margin: 2em 0;
    padding: 25px 10px 7px;
    border: solid 5px #FFC107;
}
.box28 .box-title {
    position: absolute;
    display: inline-block;
    top: -2px;
    left: -2px;
    padding: 0 9px;
    height: 25px;
    line-height: 25px;
    font-size: 17px;
    background: #FFC107;
    color: #ffffff;
    font-weight: bold;
}
.box28 p {
    margin: 0; 
    padding: 0;
}
</style>





### 画像の拡大

{% highlight python linenos %}

![image]({{ "/images/200by200.png" | relative_url}}){:height="500px" width="500px"}<br>

{% endhighlight %}

結果
![image]({{ "/images/200by200.png" | relative_url}}){:height="500px" width="500px"}<br>


{% highlight python linenos %}

![image]({{ "/images/200by200.png" | relative_url}})<br>

{% endhighlight %}

結果：原寸大
![image]({{ "/images/200by200.png" | relative_url}})<br>



{% highlight python linenos %}

<style type="text/css">

img.example0 { zoom: 1.0; }
img.example1 { zoom: 1.5; }
img.example2 { zoom: 70%; }

</style>

<p><img src="/images/200by200.png" alt="［写真］" class="example0"> 等倍200pxby200px</p>

<p><img src="/images/200by200.png" alt="［写真］" class="example1"> 1.5倍に拡大</p>

<p><img src="/images/200by200.png" alt="［写真］" class="example2"> 70%に縮小</p>

{% endhighlight %}


<style type="text/css">

img.example0 { zoom: 1.0; }
img.example1 { zoom: 1.5; }
img.example2 { zoom: 70%; }

</style>

<p><img src="/images/200by200.png" alt="［写真］" class="example0"> 等倍200pxby200px</p>

<p><img src="/images/200by200.png" alt="［写真］" class="example1"> 1.5倍に拡大</p>

<p><img src="/images/200by200.png" alt="［写真］" class="example2"> 70%に縮小</p>

