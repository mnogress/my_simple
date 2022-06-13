---
layout: post
title: KH Coder で複合語をコントロールしてWordCloudを作成する
feature-img: "assets/img/2020_08_15/lemon-5703655_1280.jpg"
tags: [KH Coder, WordCloud, Python]
excerpt_separator: <!--more-->
---

テキストマイニングの定番であるKH Coder に頻出語の抽出、排除等のコントロールをさせて。そのリストから分かち書きのテキストを再作成してWordCloudを作成するまでの手順をBlogにまとめました。　　

<!--more-->

### KHCoder を使った理由

日本語のWordCloud作成方法を丁寧に説明した
Blog [Qiita: WordCloudで岸田首相の所信表明演説のキーワードを可視化する](https://qiita.com/growsic/items/0663299ff8ed07ba9d30){:target="_blank"}がネットにあり、簡単にWordCloud が作成できます。
私も、Qiita記事を参考にほとんどそのままのコードでWordCloudが作成できました。
作成自体は簡単なのですが、WordCloudで可視化された大きな文字で印象に残るキーワードから何かしらのまとめメッセージや、
文書全体の示唆を導こうとすると、複合語の抽出と排除の問題にぶつかりました。

1. MeCabでの分かち書きは、漢字二文字の単語の抽出がメインとなる。
2. 専門用語等の複合語（例えば、「資本」と「主義」から「資本主義」）を抽出し、その出現をカウントするが難しい
3. 文字操作で分かち書きされたテキスト内の「一字」、「ひらがなのみの語句」は除外できるが、「高齢者」が「高齢」と「者」と別れてしまい、「者」が抜け落ちる
4. 複合語の拾い出しには、結局、複合語を登録した辞書の手助けが必要となり、辞書そのものをどこからか手当する必要がある。


### WordCloudのための入力テキストにはKHCoder を使うこととした

結局、MeCab単体と文字操作だけでは複合語の抽出、取捨選択が難しく、その部分（複合語の抽出と取捨選択）にはテキストマイニングのソフトウエアを利用するのが現実的という結論に至りました。




### KH Coderで作成した頻出語リストから分かち書きテキストを作成する

KH Coder を使って頻出語リストを作成する際、以下のKH Coder の画面より抽出する頻出語の品詞によってコントロールできます。

![KHCoder_frequent_df]({{ "assets/img/2020_08_15/khcoder_pic3.png" | relative_url}})<br>


前半部分では列名‘col2’ に出現語句を出現回数分、半角スペースを空けて格納しています。

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

以下のようなデータフレームを作成しました。
![KHCoder_frequent_df]({{ "assets/img/2020_08_15/khcoder_pic1.png" | relative_url}})<br>

図でお分かりのように、分かち書きにするため、半角スペースを足して、出現回数分掛け合わせているだけです。
しかし、この方法だと各要素の最後に余分な半角スペースが入ってしまうので、これを削除する必要があります。
この処理は、後半のコードで対応しています。


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

![WordCloud＿KHCoder]({{ "assets/img/2020_08_15/wordcloud_kishida.png" | relative_url}})<br>




### 参照ページ一覧
本ブログは、以下のネットの記事等を参考に作成しました。　
>
1) [Qiita: WordCloudで岸田首相の所信表明演説のキーワードを可視化する](https://qiita.com/growsic/items/0663299ff8ed07ba9d30){:target="_blank"}<br>
2) [GitHub Docker環境](https://github.com/growsic/word_cloud_japanese/tree/feature/english-only){:target="_blank"}<br>
3) [KH Coder](https://khcoder.net){:target="_blank"}<br>
4) [第二百七回国会における岸田内閣総理大臣所信表明演説](https://www.kantei.go.jp/jp/101_kishida/statement/2021/1206shoshinhyomei.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}


