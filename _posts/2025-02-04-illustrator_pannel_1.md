---
layout: single
title: イラレのアピアランスパネルを理解する
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
# wide
sidebar:
  nav: "docs"
tag: [illustrator, appearance_pannel, design]
category: illustrator
date: 2026-03-01
last_modified_at : 2026-03-18 09:00:00
---

アピアランスパネルは、オブジェクトの実体は同じままで、見た目を変えるものです。イラストレーターの数ある機能の中で押さえておくべアピアランス機能にいて説明します。<!--more-->

### このページの目的

アピアランスパネルは、Illustrator の中でも特に「デザインの自由度」と「修正のしやすさ」を両立させるための重要な機能です。

「塗り」・「線」・「効果」を重ねて見た目だけを変えられるため、同じオブジェクトから複数のバリエーションを作ったり、後から簡単に調整したりできます。

この記事では、アピアランスの仕組みと活用方法を整理し、**文字装飾や図形デザインを効率的に行うための基本をまとめます。**


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
.violet {
color: #cb23d1;
font-size: 1.0em;
font-weight: 500;
font-style: italic;
font-family: inherit;
letter-spacing: 0.02em;
}
.rouge {
color: #d9180eff;
font-size: 1.14em;
font-weight: 500;
font-style: italic;
font-family: inherit;
letter-spacing: 0.02em;
}
.noir {
color: #090c0cff;
font-size: 0.850em;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.bleu {
color: #0053a6;
font-size: 1.10em;
font-weight: 500;
font-style: italic;
font-family: inherit;
letter-spacing: 0.02em;
}
.gris_p {
color: rgb(45, 43, 42);
font-size: 0.7em;
font-weight: 500;
font-style: normal;
font-family: inherit;
letter-spacing: 0.02em;
}
.petit {
font-size: 0.80em;
color: black;
font-family: inherit;
line-height: 1.1;
display: inline-block;
letter-spacing: inherit;
}
  /* このページだけのULを調整（スコープ＝.page-ul-fix） */
  .page-ul-fix ul {
    font-size: 1rem;       /* 任意のサイズに */
    line-height: 1.3;      /* 読みやすさ調整（任意） */
  }

  /* このページだけのOLを調整（スコープ＝.page-ul-fix） */
  .page-ul-fix ol {
    font-size: 1rem;       /* 任意のサイズに */
    line-height: 1.6;      /* 読みやすさ調整（任意） */
  }
</style>

### アピアランスパネルとは見た目を変えるためのパネル

アピアランスパネルは、**ウインドウ→アピアランス**で出現します。

通常、一つのオブジェクトに対して
**「塗り」**と　**「線」**
の設定をひとつずつ行うことができます。
アピアランスパネルを使うと、この一対の塗りと線の設定を複数設定し編集することができます。

アピアランスとは英語で外見とか見た目と訳されます。　すなわち、オブジェクトの実体（内面）は同じままで、見た目を変えるためのパネルということです。

イラストレーターでのアピアランスは 、**「塗り」「線」,「効果」,「不透明度」**
の4つの属性から構成されています。アピアランスパネルでは４つすべての属性を操作できます。

以下の図では、

![appearance_panel]({{ "/images/img/appearance_intro_2.png" | relative_url}}){:height="600px" width="600px"}<br>


この図では、３層のアピアランスの構造になっています。上からパス、**「線」,「塗」** りの順に重なっています。<br>

<div class="box33">
    <span class="box-title">概要</span>
    <ol>
<li> パス＝オブジェクトに対してのアピアランスです。実際のオブジェクトは左の円です。</li>
<li>線には、<strong>イエロー(#FFFF00)</strong>で太さは<span class="bleu">3pt</span>のアピアランスがあたっています。　この部分だけ色が変わっていますが、線のアピアランスを選択しています。</li>
<li>塗りは、<strong>オレンジ(#C1272D)</strong>のアピアランスがかかっています</li>
<li>アピアランスは、パス、線、塗それぞれにかけることが可能です。さらにグループ、サブレイヤー、レイヤのレベルまでアピアランスの
対象になることができます。</li>
   </ol>
</div>



最も一般的なパス、線、塗に対するアピアランスについて研究します。

---

### 見た目が違うだけで、図形は元のままだから修正に強い

アピアランスでは「塗り」「線」「効果」を複数重ねることができます。  
特に効果は、オブジェクトの形そのものを変えずに“見た目だけ”を変えられるのが特徴です。

下の動画では、**「パス」・「線」・「塗り」**のそれぞれにジグザグ効果をかけ、  元はただの円が「ばくだん」のような形に見えるようになっています。

ポイントは、同じジグザグでも  「パスにかけるのか」「線にかけるのか」「塗りにかけるのか」で  見た目がまったく変わるということです。  そして、それらが重なって最終的な見た目が作られます。

見た目がどれだけ複雑になっても、実体は元の円のままです。  **「表示 → アウトライン」**で確認すると一目瞭然です。

この“実体はそのまま・見た目だけ変える”という仕組みこそ、  アピアランスが修正に強く、流用しやすいデザインを作れる理由です。

  **「パス」、「線」、「塗り」**、それぞれのジグザグの「あて方」で効果が　**「パス」、「線」、「塗り」**のそれぞれにあたる、そしてそれらが合わさるとはどういうことか、この例で理解できると思います。

![アピアランスをかける]({{ "/images/img/ジグザグアピアランス0928_195e5c67ac.autosave1008.gif" | relative_url}}){:height="100%" width="100%"}<br>

見た目が複雑になっても、オブジェクトは元の図形のままです。試しに **「表示」メニュー**で **「アウトライン」**をすれば一目瞭然です。
このことが、アピアランスパネルの活用は修正に強く、流用しやすいパーツ作成のための必須ツールと言われる理由です。

### アピアランスの当たり方はそれぞれの重なり順で決まります

**「新規線の追加」**は、元の **「線」**に対してアピアランスをもう一つ重ねる操作です。  動画の例では、新規線を追加すると、黄色・2pt の線アピアランスが複製され、  同じ線が 2 枚重なった状態になります。複製された線は一番上に追加されます。

この状態で、下側の線の色を黄色から青に変えても、  上にある黄色の線が覆いかぶさっているため、青色は見えません。

試しに、上側の黄色の線の太さを 「2pt → 1pt」 に細くすると、  覆いかぶさる部分が減り、下の青い線が半分だけ見えてきます。

このように、アピアランスの見え方は  **「どのアピアランスが上にあるか」＝重なり順** で決まります。 

同じ種類のアピアランスを複数持っていても、  順序が変わるだけで見た目は大きく変わります。


![アピアランスの順番]({{ "/images/img/ジグザグアピアランス0928_195e5c67ac.autosave2.gif" | relative_url}}){:height="600px" width="600px"}<br>


### グラフィックスタイルに登録すれば、アピアランスを別のオブジェクトに簡単に反映できます

アピアランスを別のオブジェクトにも使いたい場合は、**「ウィンドウ」→「グラフィックスタイル」**を開きます。

アピアランスパネルで作成したスタイルを、そのままグラフィックスタイルパネルへドラッグすると登録できます。

こうして登録しておけば、別の図形を選択してグラフィックスタイルをクリックするだけで、同じアピアランスを一瞬で適用できます。

<span class="bleu">毎回アピアランスを一から設定する必要がなくなり、デザインの統一やバリエーション作成がとても効率的になります。</span>


![アピアランスの順番]({{ "/images/img/graphic_style.gif" | relative_url}}){:height="600px" width="600px"}<br>


### アピアランスの分割でオブジェクトの中身にも反映させます

**「オブジェクト」メニュー**から **「アピアランスを分割」**を選択します。  すると、**「アウトライン」**で見るとこれまで、見た目だけのアピアランスが実際の図形として認識されています。 ダイレクト選択ツールなどでこのオブジェクトを部分的に編集が可能になります。   

![アピアランスの順番]({{ "/images/img/アピアランス分割.gif" | relative_url}}){:height="600px" width="600px"}<br>


アピアランスを分割すると、これまで“見た目だけ”だった効果や線・塗りが、実際のパスとして確定します。

そのため、ダイレクト選択ツールなどで細かく形を編集できるようになりますが、同時にアピアランスとしての情報は失われます。

つまり、分割前のように「線の太さを変える」「効果の数値を調整する」といったアピアランス編集はできなくなります。

分割は“最終的な形を確定させたいとき”に使う操作であり、後から柔軟に調整したい場合は分割しない方が良い、という点がポイントです。
