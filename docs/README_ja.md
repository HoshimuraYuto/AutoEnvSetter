# AutoEnvSetter

- [English](../README.md)
- [日本語](README_ja.md)

AutoEnvSetter は Javascript/Typescript(+react 等)の開発環境を簡単に構築できるツールです。

## 使用方法

AutoEnvSetter を使用するには、以下の手順でローカ環境で実行します。

1. ご自身のプロジェクトディレクトリを作成し、プロジェクトディレクトリに移動します。

```sh
mkdir your/project/directory && cd your/project/directory
```

2. プロジェクトディレクトリのルートに ZIP ファイルを[こちら](https://github.com/HoshimuraYuto/AutoEnvSetter/archive/refs/heads/main.zip)からダウンロードします。

3. ファイルを解凍します。AutoEnvSetter フォルダが以下のように設置されているか確認してください。

```
🗂 (プロジェクトディレクトリ)
└── 🗂 AutoEnvSetter
    ├── 🗂 bin
    │   └── 📄 install.sh
    ├── ...
```

4. `sh AutoEnvSetter/bin/install.sh` を実行します。

```sh
sh AutoEnvSetter/bin/install.sh
```

5. もしテストに playwright を選んだ場合、`TODO: Please edit webServer in the playwright.config.ts file as follows.`という表示が出るのでその指示を守ってください。playwright によるテストが行いやすくなります。

### 引数

以下の引数を渡すことができます。

- `--package_manager=[package manager]`: 使用するパッケージマネージャーを指定します（例：`--package_manager=yarn`）。デフォルトは `pnpm` です。
- `--language=[language]`: 使用したい言語を指定する（例：`--language=javascript`）。デフォルト値は `typescript` です。
- `--framework=[framework]`: 使用したいフレームワークを指定する（例：`--framework=react`）。デフォルト値は `none` です。
- `--formatter=[formatter]`: 使用するコードフォーマッタを指定する（例：`--formatter=prettier`）。デフォルトは `prettier` です。
- `--linter=[linter]`: 使用したいリンターを指定する（例：`--linter=eslint`）。デフォルトは `eslint` です。
- `--bundler=[bundler]`: 使用したいモジュールバンドルラーを指定する (例: `--bundler=webpack`)。 デフォルトは `webpack` です。
- `--test=[test]`: 使用したいテストを指定する (例: `--test=playwright`)。 デフォルトは `playwright` です.

linter 引数は、`--linter=eslint,stylelint`のようにカンマで区切って複数の値を指定することができます。複数のリンターが指定された場合、スクリプトはそれぞれのリンターを適切に設定します。

### サポートされるオプション

AutoEnvSetter は現在、以下のオプションに対応しています。

- パッケージマネージャー: `npm`、`yarn`、`pnpm`。
- プログラミング言語: `javascript`, `typescript`
- フレームワーク: `none`, `react`
- リンター: `none`, `eslint`, `stylelint`
- フォーマッタ: `none`, `prettier`
- バンドラー: `none`, `webpack`
- テスト: `none`, `jest`, `playwright`

### 使用例

#### pnpm+typescript+eslint+prettier+webpack+playwright

```sh
sh AutoEnvSetter/bin/install.sh
```

#### pnpm+typescript+react+eslint+prettier+webpack+playwright

```sh
sh AutoEnvSetter/bin/install.sh --framework=react
```

#### pnpm+typescript+react+eslint+stylelint+prettier+webpack+playwright

```sh
sh AutoEnvSetter/bin/install.sh --framework=react --linter=eslint,stylelint
```

## 互換性

AutoEnvSetter は、macOS および Linux の OS に対応しています。Windows との互換性は現時点では確認されていません。

## 必要条件と依存関係

AutoEnvSetter を使用するには、以下のものが必要です。

- Bash
- Curl

## 今後の展開

今後も AutoEnvSetter の開発を続け、新機能の追加や、より多くの言語、フレームワーク、ツールへの対応を予定しています。追加を予定している機能は以下の通りです。

- [ ] 言語やフレームワークの追加サポート
- [x] テストフレームワークとの連携
- [ ] 自動デプロイメントスクリプト
- [ ] brew インストーラーのように（ダウンロードせずに）動作する。

アップデートにご期待ください。

## 貢献

AutoEnvSetter へのコントリビュートをお待ちしています。コントリビュートするには、以下の手順で行ってください。

1. GitHub でプロジェクトをフォークする。
2. 変更を加え、明確なコミットメッセージを添えてコミットする。
3. フォークしたリポジトリに変更をプッシュします。
4. プルリクエストを提出する。
5. 私たちはあなたの変更をレビューし、それがプロジェクトに適していればマージします。

## ライセンス

このプロジェクトは、MIT License のもとでライセンスされています。詳細は [LICENSE](LICENSE) ファイルを参照してください。

## 作者

- [Github](https://github.com/HoshimuraYuto)
- [ツイッター](https://twitter.com/HoshimuraYuto)
- [ブログ](https://sukiburo.jp/)
