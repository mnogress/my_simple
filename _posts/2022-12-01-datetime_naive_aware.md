---
layout: post
title: Teamsライブイベントを例にDatetimeオブジェクトnaiveとawareの使い方を説明します
feature-img: "assets/img/2020_08_15/background-g66e9c5633_640.png"
tags: [Python, datetime, naive, aware]
excerpt_separator: <!--more-->
---

datetime モジュールは、日付や時刻を操作するためのクラスで、これにより日付や時刻に対する四則演算が可能です。日時のオブジェクトは、それがタイムゾーンの情報を含むかどうかによって "aware"（タイムゾーン情報あり）または "naive"（情報なし）に分けることができます。

<!--more-->
このブログでは、"aware" と "naive" の特徴や相互変換などについて、Teamsライブイベントを例に取り上げて分かりやすく解説しました。


---

### datetimeオブジェクトは、 naive と　aware の２種類

time 型あるいは datetime 型のオブジェクトは aware か naive のどちらかです。
一方、date 型のオブジェクトは常に naive です。

### 通常 naive を使います

naiveはタイムゾーン情報を持ちません。　通常、こちらで四則演算等の操作します。例えば
 `2021年8月22日の午前7時7分30秒は、2021-08-22 07:07:30`{:style="background-color: #faf5d2; font-size: 1.0em"}  となります。

時刻表示は２４時間表示です。従って、午後4時33分17秒は 16:33:17 になります。

### 時差の調整のために aware に変換します

aware はタイムゾーン情報を持っています。
通常、時差（現地時刻と日本時刻変換等）の調整に使います。　

例えば、`日本時間の2021年8月22日16時7分30秒は、UTC(グリニッジ標準）より+9時間（早い）ので2021-08-22 16:07:30+09:00`{:style="background-color: #faf5d2; font-size: 1.0em"}　となります

>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em"} <br>
片方がNaive、もう一方がAware のdatetime オブジェクト間での四則演算はできません。
いずれかに合わせる必要があります。　
1. 計算（この場合は引き算）をしようとしましたが、以下の例外を返します
2. TypeError: DatetimeArray subtraction must have the same timezones or no timezones
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

### UTC時刻でログされたCSVデータをJST時刻に変換する

Teamsライブイベントの出席者エンゲージメントレポートを解析された方も少なくないかと思いますが
この時刻表示は[Teamsライブイベント出席者エンゲージメントレポート](https://support.microsoft.com/ja-jp/office/%E3%83%A9%E3%82%A4%E3%83%96-%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E3%81%AE%E5%87%BA%E5%B8%AD%E8%80%85%E3%82%A8%E3%83%B3%E3%82%B2%E3%83%BC%E3%82%B8%E3%83%A1%E3%83%B3%E3%83%88-%E3%83%AC%E3%83%9D%E3%83%BC%E3%83%88teams%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B-b3101733-2eda-48a6-aeb3-de2f2bfecb3a){:target="_blank"}にも詳しい説明がありますが
タイムスタンプはUTC時刻です。

日本時間(JST)に変換しないと、9時間遅れを理解して操作する必要がありますので、UTCからJSTに直すため、以下のようなタイムゾーンの操作が必須となります。

#### UTC to JST Datetime オブジェクトの操作

1. teams のAttendance Reportを例にCSVデータをデータフレームに取り込みます
2. Datetime オブジェクトに変換(この場合、naiveでUTC時刻でログされているとします）
3. naive から aware への変換
4. タイムゾーン（時差）の調整（UTC から JST等)
5. Aware から Naive に戻す 　

---
以下の図の通りになります。

![aware_naive]({{ "assets/img/2020_08_15/aware_naive.png" | relative_url}})<br>


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。
>
1) [時系列データのリサンプリングについて](https://www.so-wi.com/2021/06/30/time_series_resampling_pivot_vaccine.html){:target="_blank"}<br>
2) [EXCELシリアル値をDatetime に変換する](https://www.so-wi.com/2019/08/06/exceldate_serial_to_datetime_apply.html){:target="_blank"}<br>
3) [生年月日から年齢を計算する](https://www.so-wi.com/2019/07/31/dob_to_age_lambda.html){:target="_blank"}<br>
4) [文字列を日付に変換する](https://www.so-wi.com/portfolio/datetime-strptime){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}