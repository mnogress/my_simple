---
layout: post
title: Intel® Math Kernel Library (MKL) ErrorでKernel Deadの対処法
feature-img: "assets/img/2019_07_01/intel_mkl_error.png"
img: "assets/img/2019_07_01/intel_mkl_error.png"
date: Feburary, 23 2020
tags: [anaconda, Math Kernel Library ]
---

### ことの始まり

[scikit-learn_0.22.1](https://scikit-learn.org/stable/whats_new/v0.22.html#version-0-22-1){:target="_blank"}にanaconda on Mac Catalina を導入しましたが、いざJupyter Notebook でモジュールをインポートしよとすると、悲しいかな、最初のnumpy のimport でKernel Deadとなり、`[ ]`{:style="background: #ffebf6"}で数字も入らず、notebook が使えなくなりました。　

結局、nomkl のバージョンにリビルドしました。　MKLをインテルのサイトより導入するというのも考えましたが、他のSWの整合性もあるので、これ以上、MKLを入れてローカルの稼働環境の整備に時間を費やすのもと思い。　nomkl で稼働させる手順をメモしました。

ログのとおり、かなりのモジュールを入れ替えてしまいますので、自己責任でお願いいたします。　仕事のマシンへの適用は、フルバックアップするなど、十分慎重に対応が求められます。　

#### Kernel Dead のターミナル上のエラーメッセージ

import numpy as np の最初のモジュールを読み込もうとしたところ、以下のようなエラーメッセージを出力されました。

{% highlight python linenos %}
INTEL MKL ERROR: dlopen(/Users/so-wi/anaconda3/lib/libmkl_intel_thread.dylib, 9): Library not loaded: @rpath/libiomp5.dylib
  Referenced from: /Users/so-wi/anaconda3/lib/libmkl_intel_thread.dylib
  Reason: image not found.
Intel MKL FATAL ERROR: Cannot load libmkl_intel_thread.dylib.
[I 09:18:52.333 NotebookApp] KernelRestarter: restarting kernel (1/5), keep random ports
kernel 3d9ff618-8c1d-4c1e-9a54-301a5ab4b684 restarted
INTEL MKL ERROR: dlopen(/Users/so-wi/anaconda3/lib/libmkl_intel_thread.dylib, 9): Library not loaded: @rpath/libiomp5.dylib
  Referenced from: /Users/so-wi/anaconda3/lib/libmkl_intel_thread.dylib
  Reason: image not found.
Intel MKL FATAL ERROR: Cannot load libmkl_intel_thread.dylib.
[I 09:19:13.339 NotebookApp] KernelRestarter: restarting kernel (1/5), keep random ports
kernel 3d9ff618-8c1d-4c1e-9a54-301a5ab4b684 restarted
[I 09:19:46.289 NotebookApp] Saving file at /OneDrive/py_20-RFC_05_19-Copy1.ipynb
[W 09:19:46.291 NotebookApp] Notebook OneDrive/py_20-RFC_05_19-Copy1.ipynb is not trusted
[I 09:47:25.793 NotebookApp] Starting buffering for 3d9ff618-8c1d-4c1e-9a54-301a5ab4b684:d3cb421358c0497183df29029a423ee3
{% endhighlight %}

#### 参考にしたネットの記事

1. Intel MKL FATAL ERROR: Cannot load libmkl_core.dylib でググる
2. [参考にした記事](https://discuss.pytorch.org/t/intel-mkl-fatal-error-cannot-load-libmkl-core-dylib/67710){:target="_blank"}はまさしくエラーメッセージがタイトルです
3. mklでないnumpy、scipy等をインストールし、mklサービスを削除するという内容です

{% highlight python linenos %}
conda install nomkl numpy scipy scikit-learn numexpr
conda remove mkl mkl-service
{% endhighlight %}

#### オペレーションログ

以下が実際のログのポイント箇所です。ご覧のとおり、かなりのモジュールが削除されますので、要注意です。　モジュールを都度いれていけばいいんですけど。
いつも使うモジュールが何か把握しておくといいでしょう。

{% highlight python linenos %}
sudo conda remove mkl mkl-service
The following NEW packages will be INSTALLED:

  prompt-toolkit     pkgs/main/noarch::prompt-toolkit-3.0.4-py_0

The following packages will be REMOVED:

  alabaster-0.7.12-py37_0
  anaconda-2020.02-py37_0
  anaconda-project-0.8.4-py_0
  applaunchservices-0.2.1-py_0
  appscript-1.1.0-py37h1de35cc_0
  argh-0.26.2-py37_0
  asn1crypto-1.3.0-py37_0
  astroid-2.3.3-py37_0
  astropy-4.0-py37h1de35cc_0
  atomicwrites-1.3.0-py37_1
  autopep8-1.4.4-py_0
  babel-2.8.0-py_0
  backports.shutil_get_terminal_size-1.0.0-py37_2
  bitarray-1.2.1-py37h1de35cc_0
  bkcharts-0.2-py37_0
  blas-1.0-mkl
  blosc-1.16.3-hd9629dc_0
  bokeh-1.4.0-py37_0
  boto-2.49.0-py37_0
  bottleneck-1.3.2-py37h776bbcc_0
  cloudpickle-1.3.0-py_0
  colorama-0.4.3-py_0
  contextlib2-0.6.0.post1-py_0
  curl-7.68.0-ha441bb4_0
  cycler-0.10.0-py37_0
  cython-0.29.15-py37h0a44026_0
  cytoolz-0.10.1-py37h1de35cc_0
  dask-2.11.0-py_0
  dask-core-2.11.0-py_0
  diff-match-patch-20181111-py_0
  distributed-2.11.0-py37_0
  docutils-0.16-py37_0
  et_xmlfile-1.0.1-py37_0
  fastcache-1.1.0-py37h1de35cc_0
  flake8-3.7.9-py37_0
  flask-1.1.1-py_0
  fsspec-0.6.2-py_0
  get_terminal_size-1.0.0-h7520d66_0
  gevent-1.4.0-py37h1de35cc_0
  gmp-6.1.2-hb37e062_1
  gmpy2-2.0.8-py37h6ef4df4_2
  greenlet-0.4.15-py37h1de35cc_0
  h5py-2.10.0-py37h3134771_0
  hdf5-1.10.4-hfa1e0ec_0
  heapdict-1.0.1-py_0
  html5lib-1.0.1-py37_0
  hypothesis-5.5.4-py_0
  imageio-2.6.1-py37_0
  imagesize-1.2.0-py_0
  intel-openmp-2019.4-233
  intervaltree-3.0.2-py_0
  isort-4.3.21-py37_0
  itsdangerous-1.1.0-py37_0
  jbig-2.1-h4d881f8_0
  jdcal-1.4.1-py_0
  joblib-0.14.1-py_0
  jupyter-1.0.0-py37_7
  jupyter_console-6.1.0-py_0
  keyring-21.1.0-py37_0
  kiwisolver-1.1.0-py37h0a44026_0
  krb5-1.17.1-hddcf347_0
  lazy-object-proxy-1.4.3-py37h1de35cc_0
  libcurl-7.68.0-h051b688_0
  libcxxabi-4.0.1-hcfea43d_1
  libgfortran-3.0.1-h93005f0_2
  libspatialindex-1.9.3-h0a44026_0
  libssh2-1.9.0-ha12b0ac_1
  libxslt-1.1.33-h33a18ac_0
  llvm-openmp-4.0.1-hcfea43d_1
  llvmlite-0.31.0-py37h1341992_0
  locket-0.2.0-py37_1
  lxml-4.5.0-py37hef8c89e_0
  matplotlib-3.1.3-py37_0
  matplotlib-base-3.1.3-py37h9aa3819_0
  mccabe-0.6.1-py37_1
  mkl-2019.4-233
  mkl-service-2.3.0-py37hfbe908c_0
  mkl_fft-1.0.15-py37h5e564d8_0
  mkl_random-1.1.0-py37ha771720_0
  mock-4.0.1-py_0
  more-itertools-8.2.0-py_0
  mpc-1.1.0-h6ef4df4_1
  mpfr-4.0.1-h3018a27_3
  mpmath-1.1.0-py37_0
  msgpack-python-0.6.1-py37h04f5b5a_1
  multipledispatch-0.6.0-py37_0
  networkx-2.4-py_0
  nltk-3.4.5-py37_0
  nose-1.3.7-py37_2
  numba-0.48.0-py37h6c726b0_0
  numexpr-2.7.1-py37hce01a72_0
  numpy-1.18.1-py37h7241aed_0
  numpy-base-1.18.1-py37h6575580_1
  numpydoc-0.9.2-py_0
  openpyxl-3.0.3-py_0
  packaging-20.1-py_0
  pandas-1.0.1-py37h6c726b0_0
  partd-1.1.0-py_0
  path-13.1.0-py37_0
  path.py-12.4.0-0
  pathlib2-2.3.5-py37_0
  pathtools-0.1.2-py_1
  patsy-0.5.1-py37_0
  pep8-1.7.1-py37_0
  pluggy-0.13.1-py37_0
  ply-3.11-py37_0
  py-1.8.1-py_0
  pycodestyle-2.5.0-py37_0
  pycrypto-2.6.1-py37h1de35cc_9
  pycurl-7.43.0.5-py37ha12b0ac_0
  pydocstyle-4.0.1-py_0
  pyflakes-2.1.1-py37_0
  pylint-2.4.4-py37_0
  pyodbc-4.0.30-py37h0a44026_0
  pyparsing-2.4.6-py_0
  pytables-3.6.1-py37h5bccee9_0
  pytest-5.3.5-py37_0
  pytest-arraydiff-0.3-py37h39e3cac_0
  pytest-astropy-0.8.0-py_0
  pytest-astropy-header-0.1.2-py_0
  pytest-doctestplus-0.5.0-py_0
  pytest-openfiles-0.4.0-py_0
  pytest-remotedata-0.3.2-py37_0
  python-jsonrpc-server-0.3.4-py_0
  python-language-server-0.31.7-py37_0
  pywavelets-1.1.1-py37h1de35cc_0
  qdarkstyle-2.8-py_0
  qtawesome-0.6.1-py_0
  qtconsole-4.6.0-py_1
  rope-0.16.0-py_0
  rtree-0.9.3-py37_0
  scikit-image-0.16.2-py37h6c726b0_0
  scikit-learn-0.22.1-py37h27c97d8_0
  scipy-1.4.1-py37h9fa6033_0
  seaborn-0.10.0-py_0
  simplegeneric-0.8.1-py37_2
  singledispatch-3.4.0.3-py37_0
  snappy-1.1.7-he62c110_3
  snowballstemmer-2.0.0-py_0
  sortedcollections-1.1.2-py37_0
  sortedcontainers-2.1.0-py37_0
  sphinx-2.4.0-py_0
  sphinxcontrib-1.0-py37_1
  sphinxcontrib-applehelp-1.0.1-py_0
  sphinxcontrib-devhelp-1.0.1-py_0
  sphinxcontrib-htmlhelp-1.0.2-py_0
  sphinxcontrib-jsmath-1.0.1-py_0
  sphinxcontrib-qthelp-1.0.2-py_0
  sphinxcontrib-serializinghtml-1.1.3-py_0
  sphinxcontrib-websupport-1.2.0-py_0
  spyder-4.0.1-py37_0
  spyder-kernels-1.8.1-py37_0
  sqlalchemy-1.3.13-py37h1de35cc_0
  statsmodels-0.11.0-py37h1de35cc_0
  sympy-1.5.1-py37_0
  tbb-2020.0-h04f5b5a_0
  tblib-1.6.0-py_0
  toolz-0.10.0-py_0
  ujson-1.35-py37h1de35cc_0
  unicodecsv-0.14.1-py37_0
  unixodbc-2.3.7-h1de35cc_0
  watchdog-0.10.2-py37h1de35cc_0
  werkzeug-1.0.0-py_0
  wrapt-1.11.2-py37h1de35cc_0
  wurlitzer-2.0.0-py37_0
  xlrd-1.2.0-py37_0
  xlsxwriter-1.2.7-py_0
  xlwings-0.17.1-py37_0
  xlwt-1.3.0-py37_0
  yapf-0.28.0-py_0
  zict-1.0.0-py_0
{% endhighlight %}

更に、以下のモジュールが入れ替わります。ダウングレードされるものも出てきます。
そして、yest to go for it　もしくは、no to give up です。

{% highlight python linenos %}
The following packages will be UPDATED:

  beautifulsoup4                               4.8.2-py37_0 --> 4.9.0-py37_0
  bleach              pkgs/main/osx-64::bleach-3.1.0-py37_0 --> pkgs/main/noarch::bleach-3.1.4-py_0
  certifi                                 2019.11.28-py37_0 --> 2020.4.5.1-py37_0
  click                  pkgs/main/osx-64::click-7.0-py37_0 --> pkgs/main/noarch::click-7.1.2-py_0
  cryptography                           2.8-py37ha12b0ac_0 --> 2.9.2-py37ha12b0ac_0
  dbus                                   1.13.12-h90a0687_0 --> 1.13.14-h517e14e_0
  decorator                                      4.4.1-py_0 --> 4.4.2-py_0
  icu                                       58.2-h4b95b61_1 --> 58.2-h0a44026_3
  idna                    pkgs/main/osx-64::idna-2.8-py37_0 --> pkgs/main/noarch::idna-2.9-py_1
  ipython                             7.12.0-py37h5ca1d4c_0 --> 7.13.0-py37h5ca1d4c_0
  jedi                                        0.14.1-py37_0 --> 0.17.0-py37_0
  jinja2                                        2.11.1-py_0 --> 2.11.2-py_0
  json5                                          0.9.1-py_0 --> 0.9.4-py_0
  jupyter_client     pkgs/main/osx-64::jupyter_client-5.3.~ --> pkgs/main/noarch::jupyter_client-6.1.3-py_0
  jupyter_core                                 4.6.1-py37_0 --> 4.6.3-py37_0
  jupyterlab_server                              1.0.6-py_0 --> 1.1.1-py_0
  libcxx                                   4.0.1-hcfea43d_1 --> 10.0.0-1
  libffi                                   3.2.1-h475c297_4 --> 3.2.1-h0a44026_6
  libiconv                                  1.15-hdd342a3_7 --> 1.16-h1de35cc_0
  liblief                                  0.9.0-h2a1bed3_2 --> 0.10.1-h0a44026_0
  nbformat                                       5.0.4-py_0 --> 5.0.6-py_0
  ncurses                                    6.2-h0a44026_0 --> 6.2-h0a44026_1
  openssl                                 1.1.1d-h1de35cc_4 --> 1.1.1g-h1de35cc_0
  parso                                          0.5.2-py_0 --> 0.7.0-py_0
  pillow                               7.0.0-py37h4655f20_0 --> 7.1.2-py37h4655f20_0
  pip                                         20.0.2-py37_1 --> 20.0.2-py37_3
  prompt_toolkit                                 3.0.3-py_0 --> 3.0.4-0
  psutil                               5.6.7-py37h1de35cc_0 --> 5.7.0-py37h1de35cc_0
  py-lief                              0.9.0-py37h1413db1_2 --> 0.10.1-py37haf313ee_0
  pycparser          pkgs/main/osx-64::pycparser-2.19-py37~ --> pkgs/main/noarch::pycparser-2.20-py_0
  pygments                                       2.5.2-py_0 --> 2.6.1-py_0
  pyrsistent                          0.15.7-py37h1de35cc_0 --> 0.16.0-py37h1de35cc_0
  python-libarchive~ pkgs/main/osx-64::python-libarchive-c~ --> pkgs/main/noarch::python-libarchive-c-2.9-py_0
  pytz                                          2019.3-py_0 --> 2020.1-py_0
  pyyaml                                 5.3-py37h1de35cc_0 --> 5.3.1-py37h1de35cc_0
  requests                                    2.22.0-py37_1 --> 2.23.0-py37_0
  setuptools                                  46.0.0-py37_0 --> 46.4.0-py37_0
  soupsieve          pkgs/main/osx-64::soupsieve-1.9.5-py3~ --> pkgs/main/noarch::soupsieve-2.0-py_0
  sqlite                                  3.31.1-ha441bb4_0 --> 3.31.1-h5c1f38d_1
  tornado                              6.0.3-py37h1de35cc_3 --> 6.0.4-py37h1de35cc_1
  tqdm                                          4.42.1-py_0 --> 4.46.0-py_0
  wcwidth                                        0.1.8-py_0 --> 0.1.9-py_0
  xz                                       5.2.4-h1de35cc_4 --> 5.2.5-h1de35cc_0
  zipp                                           2.2.0-py_0 --> 3.1.0-py_0

The following packages will be DOWNGRADED:

  lzo                                       2.10-h362108e_2 --> 2.10-h1de35cc_2

Proceed ([y]/n)? y

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
{% endhighlight %}

### nonkl のscikit-learn, numpy, scipy を導入

{% highlight python linenos %}
sudo conda install nomkl numpy scipy scikit-learn numexpr
Collecting package metadata (current_repodata.json): done
Solving environment: done

-## Package Plan ##

  environment location: /Users/so-wi/anaconda3

  added / updated specs:
    - nomkl
    - numexpr
    - numpy
    - scikit-learn
    - scipy


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    blas-1.0                   |         openblas          45 KB
    joblib-0.14.1              |             py_0         201 KB
    libgfortran-3.0.1          |       h93005f0_2         426 KB
    libopenblas-0.3.6          |       hdc02c5d_2         4.7 MB
    nomkl-3.0                  |                0          45 KB
    numexpr-2.7.1              |   py37h9ff8ad3_0         120 KB
    numpy-1.18.1               |   py37h0c13f30_0           5 KB
    numpy-base-1.18.1          |   py37hc72aeb7_1         3.9 MB
    scikit-learn-0.22.1        |   py37hebd9d1a_0         4.7 MB
    scipy-1.4.1                |   py37hba666df_0        12.8 MB
    ------------------------------------------------------------
                                           Total:        26.9 MB

The following NEW packages will be INSTALLED:

  blas               pkgs/main/osx-64::blas-1.0-openblas
  joblib             pkgs/main/noarch::joblib-0.14.1-py_0
  libgfortran        pkgs/main/osx-64::libgfortran-3.0.1-h93005f0_2
  libopenblas        pkgs/main/osx-64::libopenblas-0.3.6-hdc02c5d_2
  llvm-openmp        pkgs/main/osx-64::llvm-openmp-10.0.0-h28b9765_0
  nomkl              pkgs/main/osx-64::nomkl-3.0-0
  numexpr            pkgs/main/osx-64::numexpr-2.7.1-py37h9ff8ad3_0
  numpy              pkgs/main/osx-64::numpy-1.18.1-py37h0c13f30_0
  numpy-base         pkgs/main/osx-64::numpy-base-1.18.1-py37hc72aeb7_1
  scikit-learn       pkgs/main/osx-64::scikit-learn-0.22.1-py37hebd9d1a_0
  scipy              pkgs/main/osx-64::scipy-1.4.1-py37hba666df_0


Proceed ([y]/n)? y
{% endhighlight %}
