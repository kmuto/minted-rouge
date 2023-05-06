# minted-rouge

TeXのmintedスタイルはPythonのpygmentsパッケージを前提としていますが、Rubyのrougeパッケージでこれを代替できるようにします。

## セットアップ
1. `minted-rouge.rb`を適当なフォルダにコピーする。
2. TeXプリアンプルでmintedスタイルを読み込んだあとに`minted-rouge.rb`を使うよう設定する。
   ```
   \usepackage{minted}
   \renewcommand{\MintedPygmentize}{コピーしたフォルダパス/minted-rouge.rb}
   ```
3. pygmentsのときと異なりVerbatim環境で囲まれてはいない結果になるので、tcolorboxなどを使って範囲を囲むようにする。

## おまけ機能
- 環境変数`MINTED_ROUGE_COLOR`に`cmyk`を指定した状態で実行すると、RGB色をCMYK色に変更します。`grey`を指定すると白以外の色をすべて黒に変更します。

## 注意
- `\usemintedstyle`でスタイルセットを変更することはできますが、rougeのカラースタイルはpygmentsと互換性がなく、種類も不足しています。必要に応じて追加する必要があります。

## ライセンス
```
MIT License

Copyright (c) 2023 Kenshi Muto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
