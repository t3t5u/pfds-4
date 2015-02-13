# PFDS#4

## 4 Lazy Evaluation

### 要点

- 遅延評価の戦略には2つの重要な特性がある。

1. 与えられた式の評価を結果が必要になるまで遅延もしくは保留させる。
2. 保留させた式が初めて評価されたときの結果を、次に必要になったときに再計算しなくても済むように、メモ化(キャッシュ)する。

### 実装例(Erlang)

- [susp](https://github.com/t3t5u/pfds-4/blob/master/susp.erl)
- [stream](https://github.com/t3t5u/pfds-4/blob/master/stream.erl)
- [stream_tests](https://github.com/t3t5u/pfds-4/blob/master/stream_tests.erl)

### 参考資料

- https://github.com/kamicut/streams
- http://www.smlnj.org/doc/SMLofNJ/pages/susp.html
- http://www.cs.cmu.edu/~rwh/introsml/techniques/memoization.htm
