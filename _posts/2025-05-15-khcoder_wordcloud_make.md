---
layout: single
title: KH Coder で複合語をコントロールしてWordCloudを作成する
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
tag: ["KHCoder", "wordcloud"]
category: python
date: 2024-05-15
last_modified_at : 2025-10-20 09:00:00
excerpt: >
  日本語テキストを WordCloud で正しく可視化するために、MeCab が分割してしまう複合語を KH Coder で抽出し、Python で扱いやすく整える手順をまとめたページです。「資本主義」のように文脈で一語として扱いたい語を適切にカウントするためのヒント＆チップスを紹介し、より意味のある可視化につなげる実務的な方法を解説しています。

---

テキストマイニングの定番である[KH Coder](https://khcoder.net){:target="_blank"} に頻出語及び複合語の抽出、排除等のコントロールをさせて。そのリストから分かち書きのテキストを再作成してWordCloudを作成するまでの手順をBlogにまとめました。　　

<!--more-->

### KHCoder を使った理由

日本語のWordCloud作成方法を丁寧に説明した
Blog [Qiita: WordCloudで岸田首相の所信表明演説のキーワードを可視化する](https://qiita.com/growsic/items/0663299ff8ed07ba9d30){:target="_blank"}がネットにあり、簡単にWordCloud が作成できます。
私も、Qiita記事を参考にほとんどそのままのコードでWordCloudが作成できました。このような懇切丁寧なBlogのおかげもあり、
作成自体は簡単ですが、WordCloudで可視化された大きな文字で印象に残るキーワードから何かしらのまとめメッセージや、
文書全体の示唆を導こうとすると、複合語の抽出と排除の問題にぶつかりました。

<div class="box33">
    <span class="box-title">複合語の抽出と排除の問題</span>
    <ul>
<li> MeCabで作成される「分かち書き」は、漢字二文字の単語の抽出がメインとなる。</li>
<li>専門用語等の複合語（例えば、「資本」と「主義」に分割せず、文脈から「資本主義」）を抽出し、その出現をカウントするには複合語を抽出する必要がある</li>
<li>文字操作で分かち書きされたテキスト内の「一字」、「ひらがなのみの語句」は除外できるが、「高齢者」と一括りにしないと、「高齢」と「者」と別れてしまい、「者」が抜け落ちる</li>
<li>複合語の拾い出しには、結局、複合語を登録した辞書の手助けが必要となり、辞書そのものをどこからか手当する必要がある。</li>
   </ul>
</div>

<style>
.box33 {
    position: relative;
    margin: 2em 0;
    padding: 15px 10px 7px;
    border: solid 2px #0366fc;
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
    background: #0366fc;
    color: #ffffff;
    font-weight: bold;
    border-radius: 6px;
}
.box33 p {
    margin: 0; 
    padding: 1em;
}
</style>


### WordCloudのための入力テキストにはKHCoder を使うこととした

MeCab単体と文字操作だけでは複合語の抽出、取捨選択が難しく、テキストマイニングのソフトウエアを利用して複合語を管理するのが現実的という結論に至りました。




### KH Coderで作成した頻出語リストから分かち書きテキストを作成する

KH Coder を使って頻出語リストを作成すれば、以下のKH Coder の画面より抽出する頻出語の品詞によって取捨選択が容易にできます。この例では、「動詞」を排除しています。品詞名にBがつくのは，平仮名のみからなる語を集めた品詞のことです。今回、これらの語句もWordCloudに含めないため、チェックを外しています。

![KHCoder_frequent_df]({{ "/images/img/khcoder_pic3.png" | relative_url}}){:height="600px" width="600px"}<br>


### Python 前半部分

前半部分では列名‘col2’ に出現語句を出現回数分、半角スペースを空けて格納しています。
`khc6_kishida_frequent.xlsx`{:style="background: #cbe8f5"}というExcelファイルにKH Coderから作成した頻出単語リストが
Excel形式で格納されています。　また、入力テキストは[第二百七回国会における岸田内閣総理大臣所信表明演説](https://www.kantei.go.jp/jp/101_kishida/statement/2021/1206shoshinhyomei.html){:target="_blank"}としています。

{% highlight python linenos %}
#使用するモジュールをimport
import numpy as np
import pandas as pd
import wordcloud

#KHCoderで作成した頻出単語リスト(Excel形式)を読み込む
xlsx = pd.ExcelFile('khc6_kishida_frequent.xlsx')
df = pd.read_excel(xlsx, 'Sheet2', index_col=None, header=0)

#抽出語列からNaN を取り除く（念のため）
print(df.shape)
df = df[df['抽出語'].isnull() == False]
print(df.shape)

#col1 の語句を半角スペースを追加して数分繰り返し、col2 に格納する
df['col2']=(df['抽出語'] + ' ') * df['出現回数']
{% endhighlight %}

以下のようなデータフレームを作成しました。<br>
![KHCoder_frequent_df]({{ "/images/img/khcoder_pic1.png" | relative_url}}){:height="600px" width="600px"}<br>

図でお分かりのように、分かち書きを作成するため、各語句に半角スペースを足して、出現回数分掛け合わせています。
しかし、この方法だと各要素の最後に余分な半角スペースが入ってしまうので、最後の半角のみ削除する必要があります。
この処理は、後半のコードで対応しています。

### Python 後半部分 WordCloud 作成

実際のWordCloud作成環境は、[Qiita: WordCloudで岸田首相の所信表明演説のキーワードを可視化する](https://qiita.com/growsic/items/0663299ff8ed07ba9d30){:target="_blank"}を参考にDocker for Windows のコンテナ内に構築しました。


{% highlight python linenos %}
#col2 の中身を一旦、リスト化する
string = df['col2'].values
string = string.tolist()

len = len(df)
#各リストの最後についていた半角スペースを削除する python3.9より可能なメソッドを利用
for i in range(0, len):
    string[i] = string[i].removesuffix(' ')
#print(string)
#リストの内容をひとまとめの文字列（分かち書きテキスト）にし、これをWordCloudのインプットとする
string = ' '.join(string)
print(string)

#WordCloud のstop_words機能で以下の言葉はWordCloud で使わないようにする
stop_words =['ない', '行う','対応']

#テキストからwordcloudを生成
fpath = "/usr/share/fonts/opentype/ipaexfont-gothic/ipaexg.ttf"
wordc = wordcloud.WordCloud(
    font_path=fpath,
    background_color='white',
    stopwords = set(stop_words),
    collocations = False,
    width=800, 
    height=600)

#画像ファイルとして保存
wordc.generate(string).to_file('wordcloud_kishida.png')
{% endhighlight %}

結果は以下のようになりました。　品詞として`タグ`{:style="background: #cbe8f5"}となっているのが、複合語になります。

![WordCloud＿KHCoder]({{ "/images/img/wordcloud_kishida.png" | relative_url}}){:height="600px" width="600px"}<br>


---


