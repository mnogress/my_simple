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
date: 2025-02-04
last_modified_at : 2025-10-22 09:00:00
---

アピアランスパネルは、オブジェクトの実体は同じままで、見た目を変えるものです。修正に強く流用しやすいパーツを作るのに欠かせない機能を提供します。
同じ見た目を他のオブジェクトに展開して効率的にデザインの統一感を出すことができます。イラストレーターの数ある機能の中で押さえておくべアピアランス機能について深堀りします。<!--more-->

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
</style>
### アピアランスパネルとは見た目を変えるためのパネル

アピアランスパネルは、**ウインドウ→アピアランス**で出現します。

通常、一つのオブジェクトに対して
<span class="bleu">「塗り」</span>と<span class="bleu">「線」</span>
の設定をひとつずつ行うことができます。
アピアランスパネルを使うと、この一対の塗りと線の設定を複数設定し編集することができます。

アピアランスとは英語で外見とか見た目と訳されます。　すなわち、オブジェクトの実体（内面）は同じままで、見た目を変えるためのパネルということです。

イラストレーターでのアピアランスは 、<span class="bleu">「塗り」「線」,「効果」,「不透明度」</span>
の4つの属性から構成されています。アピアランスパネルでは４つすべての属性を操作できます。

以下の図では、

![appearance_panel]({{ "/images/img/appearance_intro_2.png" | relative_url}}){:height="600px" width="600px"}<br>


この図では、３層のアピアランスの構造になっています。上からパス、<span class="bleu">「線」,「塗」</span> りの順に重なっています。<br>

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

<span class="bleu">「塗り」、「線」、「効果」</span>の各属性は追加して複数の属性を持つことができます。
特に、効果を使うとオブジェクトの形状を変えることなく効果があたり、見た目の形状を変えることができます。<br>
以下の動画では、パス、線、塗りにそれぞれ、ジグザグの効果をあてて、<strong>円からばくだん</strong> に見た目の形状を変えています。　
パス、線、塗り、それぞれのジグザグの「あて方」で効果がパス、線、塗りのそれぞれにあたる、そしてそれらが合わさるとはどういうことか、この例で理解できると思います。

![アピアランスをかける]({{ "/images/img/ジグザグアピアランス0928_195e5c67ac.autosave1008.gif" | relative_url}}){:height="100%" width="100%"}<br>

見た目が複雑になっても、オブジェクトは元の図形のままです。試しに「表示」メニューで「アウトライン」をすれば一目瞭然です。
このことが、アピアランスパネルの活用は修正に強く、流用しやすいパーツ作成のための必須ツールと言われる理由です。

### アピアランスの当たり方はそれぞれの重なり順で決まります

新規線の追加とは実態となる線に対して、効果を重ねることです。　例えば、動画のケースで新規線を追加すると、線のアピアランスが複製され、黄色で2ptのアピアランスを２つ持つ線です。　複製されたアピアランスは一番上に追加されます。

二つアピアランスがあるこの線の下側のアピアランスの色を黄から青に変えても、
上のアピアランス（このケースでは黄色）が有効となり、青色とするアピアランスは見えません。

試しに、動画のように黄色のアピアランスの太さを2pt から 1pt に変えてみます。すると下の青色の線の半分が見えてきます。
重なりの半分が無くなり、下側のアピアランスが見えてきたということですね。

このように、アピアランスをかけた結果、どのように見えるかはアピアランスの重なり順で決まります。
したがって、アピアランスの順序によって同じ種類のアピアランスの集まりでも、見た目が変わります。

![アピアランスの順番]({{ "/images/img/ジグザグアピアランス0928_195e5c67ac.autosave2.gif" | relative_url}}){:height="600px" width="600px"}<br>


### グラフィックスタイルに登録すれば、アピアランスを別のオブジェクトに簡単に反映できます

アピアランスをコピーする場合には「ウィンドウ」メニューから「グラフィックスタイル」のパネルを開きます。
そしてアピアランスパネルから作成したこのアピアランスをグラフィックスタイルのパネルにドラッグしていきます。   
そうすることで、ここで設定したこのアピアランスを登録することができます。  

選択されている図形に対して再度、アピアランスを１から設定するのではなく
「グラフィックスタイル」から選択することで同じアピアランスを別のオブジェクトに反映することができます。 

![アピアランスの順番]({{ "/images/img/graphic_style.gif" | relative_url}}){:height="600px" width="600px"}<br>


### アピアランスの分割でオブジェクトの中身にも反映させます

「オブジェクト」メニューから「アピアランスを分割」を選択します。  すると、「アウトライン」で見ると
これまで、見た目だけのアピアランスが実際の図形として認識されています。 
ダイレクト選択ツールなどでこのオブジェクトを部分的に編集が可能になります。   

![アピアランスの順番]({{ "/images/img/アピアランス分割.gif" | relative_url}}){:height="600px" width="600px"}<br>



アピアランス分割前は、実体の図形への編集には限度がありました。 アピアランスを分割後には
今までのアピアランスは認識さないので、色を変える等のアピアランスの編集作業が簡単にできなくなってしまいます。
