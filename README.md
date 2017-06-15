# ReachabilitySample
Reachability.swiftのサンプルです。
なお、サンプルではクラス名をAMReachabilityに変更しています。理由はアプリ申請時のトラブルを避けるためです。[参考](http://scientre.hateblo.jp/entry/20150527/get_network_status_in_swift)

## 主な使い方
- `var reachability:AMReachability?`などとして、Reachabilityクラスのインスタンスの強参照を確保しておく。

```
self.reachability = AMReachability()
```

- 通信可能性を調べる.

```
//接続可能性を調べる
guard let reachability = reachability else {
    return
}

if reachability.isReachable == true {
    print("インターネット接続あり")
} else {
    print("インターネット接続なし")
}
```

- 通信可能性が変わった際の処理を記述して監視を開始する。クロージャ・ローカル通知が選べる。

```
//通信状況の監視を開始
do {
    try reachability.startNotifier()
} catch {
    print("Unable to start notifier")
}
```

- 監視を解除する

```
reachability?.stopNotifier()
```

## 主要プロパティ

| プロパティ名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| `isReachable` | 通信可能性を示す | `if reachability.isReachable == true {`<br>`print("インターネット接続あり")`<br>`}` |

## 主要メソッド

| メソッド名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| `startNotifier()` | 通信状況の監視を開始する| `do {`<br>`try reachability.startNotifier()`<br>`} catch {`<br>`print("Unable to start notifier")`<br>`}` |
| `stopNotifier()` | 通信状況の監視を終了する| `deinit {`<br>`reachability?.stopNotifier()`<br>`}`|

## 参考
https://github.com/ashleymills/Reachability.swift