---
layout: post
title: EXCELの達人からPythonの達人へ：住民基本台帳年齢階級別人口から都道府県別人口を作成する
feature-img: "assets/img/2019_07_01/stones-770264_1280.jpg"   
tags: [offline, windows, security]
excerpt_separator: <!--more-->
---

都道府県別のワクチン接種率の計算の分母とする「住民基本台帳年齢階級別人口データ」は総務省が公表している[総務省の住民基本台帳に基づく人口、人口動態及び世帯数](https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/jinkou_jinkoudoutai-setaisuu.html){:target="_blank"} よりダウンロードできます。エクセルファイルで、6835 行x 26列 のサイズですのでEXCELでの操作でもさほどストレスはかかりませんが、エクセルからPythonへの一環として、フィルタリングや都道府県コードの生成から可視化までをPython で行い、その際のデータフレームと棒グラフの作成手順をまとめましたので、ご紹介いたします。

<!--more-->

このブログでは、以下の図を最終的に作画するまでの説明を目標にしています。

![img_0708_1]({{ "assets/img/2019_07_01/img_0708_1.png)" | relative_url}}<br>

元のエクセルファイルを図のようなエクセルでの操作をチートシートにあるPythonのコードによって行います。その結果データフレームを作成したいと思います。

#### ダウンロードした元ファイル

![japan_population_sheet]({{ "assets/img/2019_07_01/japan_population_sheet.png)" | relative_url}}<br>


#### このブログで作成するデータフレームのイメージ

![japan_population_sheet]({{ "assets/img/2019_07_01/japan_population_sheet_after.PNG)" | relative_url}}<br>




---

### チートシート

手順をサマリしました。Jupyter Notebook でのコードを想定しています。 表にする都合上、関数の定義等で必要なインデントが省略されています。

----


| やりたいこと                                                 | 方法                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| カレントディレクトリ配下のファイルエクステンションが<br/>`*.xls`のリストを取得する。<br/>該当ファイル(`000701583.xls`)は予めダウンロード、<br/>カレントディレクトリに移動させておきます。 | `import glob, os` # globとosモジュールをインポートする<br/># (インデントは省いています)<br>`FILE_NAME_EXTENSION= '*.xls'`     <br/>`for gb in glob.glob(FILE_NAME_EXTENSION, recursive=True):`<br/>`    print(gb)`<br/>`==> 000701583.xls` |
| 該当ファイル(`000701583.xls`)を<br>データフレーム(`df`)として読み込む<br> | `xls = pd.ExcelFile('000701583.xls')`<br/>`df = pd.read_excel(xls, '年齢別人口（市区町村別）【総計】', index_col=None, header=1)` |
| '都道府県名'の列内の<br>'合計'とされている行を除く<br>前後にデータフレームのシェイプ<br>をプリントし削減行数の変化を調べる | `print('Before df', df.shape)`<br/><br/>`df = df[df['都道府県名'] != '合計']`<br/><br/>`print('After df', df.shape)` |
| '市区町村名'の列内の<br/>NaNとされている行を残す<br/>前後にデータフレームのシェイプ<br/>をプリントし削減行数の変化を調べる | `print('Before df', df.shape)`<br/><br/>`df = df[df['市区町村名'].isnull() == True]`<br/><br/>`print('After df_follow', df.shape)` |
| '性別'の列内の<br/>'計'とされている行を残す<br/>前後にデータフレームのシェイプ<br/>をプリントし削減行数の変化を調べる | `print('Before df', df.shape)`<br><br>`df = df[df['性別'] == '計'`]<br><br>`print('After df_follow', df.shape)` |
| '団体コード'の列内の値を<br/>整数にして小数点以下を除く<br>'団体コード'の列内の値を文字列にする | `df['団体コード']= df['団体コード'].astype('int')`<br><br>`df['団体コード']=df['団体コード'].astype(str)` |
| '団体コード'の列内の値を<br/>6桁に統一する<br/>5桁しかない(エクセルが最初の0を省かれた)<br/>'団体コード'の列内の値に０を再度追加する | #関数を定義する　(インデントは省いています)<br/>`def zfill(z):`<br/>`    z = z.zfill(6)`<br/>`return z`<br/><br/>`df['団体コード'] = df['団体コード'].apply(zfill)` |
| '団体コード'の列内の値のうち、上二けたを残す。               | `df['団体コード'] = df['団体コード'].str[:2]`                |
| `seaborn`を使って、人口データフレーム(df)の<br>都道府県名をx軸、人口をy軸にした<br>棒グラフを作図する<br>日本語を表示させる | `import seaborn as sns`<br>`import matplotlib.pyplot as plt`<br>`import japanize_matplotlib`<br>`sns.set(font='IPAGothic')`<br>`plt.rcParams['font.family'] = 'IPAexGothic'`<br><br>`sns.barplot(x='都道府県名', y='人口', data = df)`<br/>`plt.xlabel('都道府県')`<br/>`plt.ylabel('人口（万人）')`<br/>`plt.xticks(rotation=90)`<br/>`plt.title('令和2年1月1日住民基本台帳による総人口（都道府県別）', pad=20, fontsize=20)`<br/>`plt.savefig("img_0708_1.png")` |



----

### 棒グラフのコードです。seabornとmatplotlib を使っています。

日本語化については、[日本語対応した_matplotlib_2軸グラフ]({{ "2021/02/02/japanize_matplotlib_two_axis.html" | relative_url}}){:target="_blank"}を参照してください。


{% highlight python linenos %}

# 前処理
# seabornモジュールをインポート
import seaborn as sns
# スタイルのセットをする
sns.set_style('whitegrid')
import matplotlib.pyplot as plt 
from pylab import rcParams
%matplotlib inline
rcParams['figure.figsize'] = 16,9
# 日本語タイトルのため、japanizeをインポートする
import japanize_matplotlib
# フォントをIPAGothicをセットする
sns.set(font='IPAGothic')
plt.rcParams['font.family'] = 'IPAexGothic'

# 作図部分
sns.barplot(x='都道府県名', y='人口', data = df)
plt.xlabel('都道府県')
plt.ylabel('人口（万人）')
plt.xticks(rotation=90)
plt.title('令和2年1月1日住民基本台帳による総人口（都道府県別）', pad=20, fontsize=20)
plt.savefig("img_0708_1.png")
{% endhighlight %}




---

### ひとこと

> 日常的にExcelで行う方が少なくないと思いますが、今回ご紹介したサンプルのように、基本Pythonを使ってデータの操作を行うよう心掛けるとが目指すPython の達人に一歩ずつ近づいていくと思います。後半ご紹介した`barplot`は直感的に作画できるExcel  の方がストレスも無く、かつ痒い所に手が届く使い勝手ですが、`Python(Seaborn, Matplotlib)` を使う心掛けは保ちたいですね。

