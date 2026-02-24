---
layout: single
title: アピアランスパネルで座布団を作成する
header:
  overlay_image: images/header_R.png
  overlay_filter: rgba(107, 74, 43, 0.40)
toc: true
toc_label: "目次"
toc_icon: "heart"
toc_sticky: True
excerpt_separator: <!--more-->
classes:
- landing
- dark-theme
# wide
sidebar:
  nav: "docs"
tag: [illustrator, appearance_pannel, design]
category: illustrator
date: 2025-02-04
last_modified_at : 2025-10-22 09:00:00
---
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
.grand {
font-size: 1.20em;
color: black;
font-family: inherit;
line-height: 1.1;
display: inline-block;
letter-spacing: inherit;
}
</style>

テキストの背面に敷いた四角形や楕円形を「座布団」と呼んだりします。アピアランスとグラフィックスタイルで作成すると関単に文字に座布団を敷けます。
アピアランスパネルだけで作成する座布団の基本的な手順を覚え、それを応用すれば、文字に視覚的な効果のバリエーションが一気に広がります。<!--more-->

### アピアランスで作成、グラフィックスタイルで複製


アピアランスパネルだけで座布団を作成し、アピアランスパネルの内容をグラフィックスタイルに登録すれば、簡単に他のオブジェクトにアピアランス反映することができます。以下の動画のように、文字を装飾するアピアランスをグラフィックスタイルに登録すれば、後は文字を入力し、グラフィックスタイルを適用するだけで、簡単に対象の文字に対して座布団を敷いてみたり、囲みをいれたり、反射文字に変更することができます。　

動画では、イラストレーターがデフォルトで提供している、グラデーションやお化けの装飾に変えるグラフィックスタイルの適用例も入れています。

![グラフィックスタイル概要]({{ "/images/img/グラフィックスタイル概要.gif" | relative_url}}){:height="600px" width="600px"}<br>


### 可変長と固定長座布団

動画では、座布団の大きさも文字の長さ（文字数）によって座布団も長くなる **可変長** の例を示しています。また、文字数によらず決まった長さの **固定長** 座布団も可能です。 いずれも座布団の真ん中に文字が乗っかる配置になります。座布団と言われる所以でしょうか。

### 可変長座布団のアピアランスパネル

可変長座布団のアピアランスパネルを解説します。　**Hello World** の文字に対して黄色の角丸長方形の座布団を敷くアピアランスパネルです。

![可変長座布団]({{ "/images/img/appearance_zabuton1.png" | relative_url}}){:height="600px" width="600px"}<br>


### 字色と座布団のための2つの「塗り」を用意する

<div class="box33">
    <span class="box-title">塗りのキホン</span>
    <ol>
<li>「線」はなし、「塗り」は<span class="bleu">ブルー(#2E3192)</span>が元々の文字の基本アピアランスです。　ここでの「塗り」が文字の色になります。</li>
<li>座布団となる二つ目の「塗り」<span class="bleu">黄色(#FCEE21)</span>を追加しています。　この「塗り」で座布団の色を決めています。</li>
<li>オブジェクトのアウトライン化と角丸長方形の効果を追加して座布団の形状や、文字の位置を調整しています。</li>
   </ol>
</div>

角丸長方形の形状オプションを指定しています。**オプション** の項目の **サイズ**の **(R) サイズ可変** を指定して、
文字からどれだけ座布団の端を設けるかその値を指定しています。　各々サイズが実際の長方形の形状に該当するかは、図内のサイズで確認できます。

<div class="box44">
    <span class="box-title">Attention!</span>
    <ol>
<li>このサンプルのアピアランスパネルでは、バウンディングボックスを表示させないようにするため、オブジェクトを選択していません。</li>
<li>実際のアピアランスパネルの操作では、必ずオブジェクトを選択しておく必要があります。その場合は、<strong>「テキスト」</strong>とアピアランスパネルの上部で表示します。</li>
</ol>
</div>

![可変長座布団_2]({{ "/images/img/appearance_zabuton2.png" | relative_url}}){:height="600px" width="600px"}<br>


固定長の座布団の場合は、**オプション** の項目の **サイズ**で、**(A)値を指定**

### ドロップシャドウで座布団の立体感を出す

今回の座布団では、ごく薄く **ドロップシャドウ** の効果を与えて立体感を出すようにしています。　
その効果のあて具合は以下パネルのような内容です。

<div class="box33">
    <span class="box-title">ポイント</span>
    <ol>
<li>テキスト内のオブジェクトを指定すると、テキストがやや上付きに位置しています。そのままだと座布団の上でもやや上付きになります</li>
<li>真ん中に自動的に位置合わせをするには、文字と長方形二つのオブジェクトのアウトライン化します。</li>
<li>アピアランスパネルで最初にアウトライン化の効果を追加し、テキストをアウトライン化したことにします。</li>
<li>効果の重ね順も大切なポイントです。角丸長方形の効果を当てる前に<strong>パスのアウトライン化</strong>をします。</li>
   </ol>
</div>


### 字に囲みを入れるアピアランスパネル

黄色の「塗り」に太さの違う赤と青の「線」を二つ重ねて、黄色の文字に、赤い囲み（内側）と青い囲み（外側）をつけるアピアランスパネルの例を示します。

アピアランスのかかり方はパネルの上から下にかかりますので、内側に位置する赤い囲みの「線」**4pt**を上にしてその下に外側に位置する青い囲みの「線」
**10pt** の順にパネル上で効果をスタックしています。　

例えば、青の囲み線を赤の囲み線の上にパネル上で並べる（図中の**２**と**３**を逆にする）と、青が**10pt** と太いため、それに隠れて赤の囲みが見えなくなります。　パネルを重ねる順番で見え方が変わることがこのサンプルでよく理解できると思います。

![可変長座布団_4]({{ "/images/img/appearance_zabuton4.png" | relative_url}}){:height="600px" width="600px"}<br>



### 反射文字が入るアピアランスパネル

「塗り」がピンクに「線」がなしの文字をベースに、あたかもその文字を鏡面に置いたかのように、反射するさまをアピアランスパネルで表現します。
反射する文字のための「塗り」を追加し、その「塗り」に対して：

<div class="box33">
    <span class="box-title">How To</span>
    <ol>
<li>変形効果で反射を表現用に<strong>垂直方向に縮小</strong>、<strong>移動</strong>、<strong>リフレクト</strong>させます</li>
<li> <strong>パスの自由変形</strong>で右45度に反射画像を曲げます</li>
<li>「塗り」も<strong>グラデーション効果</strong>で先に行くほど薄くさせています</li></ol>
</div>

**垂直方向に縮小**、**移動**、**リフレクト**、**パスの自由変形**の効果をあてるアピアランスパネルの例

![可変長座布団_5]({{ "/images/img/appearance_zabuton5.png" | relative_url}}){:height="600px" width="600px"}<br>


**グラデーション効果** の効果をあてるアピアランスパネルの例

![可変長座布団_6]({{ "/images/img/appearance_zabuton6.png" | relative_url}}){:height="600px" width="600px"}<br>


### おまけ　リボンの形の座布団のアピアランスパネル

おまけとして、リボンの形にした座布団のアピアランスパネルを紹介します。　

![可変長座布団_7]({{ "/images/img/ribbon3_4x.png" | relative_url}}){:height="600px" width="600px"}<br>


**１**から**５**まで番号がふられている６つのパネルは、
リボンの先にあたる部分を表現する効果の詳細です。

![可変長座布団_7]({{ "/images/img/appearance_zabuton7.png" | relative_url}}){:height="600px" width="600px"}<br>


やや複雑なアピアランスパネルです。興味のある方はチャレンジしみてください。
