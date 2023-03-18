#!/bin/bash

# Define text color constants
# 文字色の定数を定義する
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'
GRAY='\033[90m'
LIGHT_RED='\033[91m'
LIGHT_GREEN='\033[92m'
LIGHT_YELLOW='\033[93m'
LIGHT_BLUE='\033[94m'
LIGHT_MAGENTA='\033[95m'
LIGHT_CYAN='\033[96m'
LIGHT_WHITE='\033[97m'

# Define exit code constants
# 終了コードの定数を定義する
END='\033[0m'

# Get the directory path of a running shell script.
# 実行中のシェルスクリプトのディレクトリパスを取得する
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Check OS.
# OSをチェックする
OS="$(uname)"

if [[ "${OS}" == "Linux" ]] || [[ "${OS}" == "Darwin" ]]; then
  FILE_COPY_COMMAND=cp
else
  FILE_COPY_COMMAND=copy
fi

# Define available options for package managers, programming languages, frameworks, formatters, linters, bundlers and tests.
# パッケージマネージャー、プログラミング言語、フレームワーク、フォーマッター、リンター、バンドラー, テストの使用可能なオプションを定義する
package_managers=("npm" "yarn" "pnpm")
languages=("typescript" "javascript")
frameworks=("none" "react" "vue")
formatters=("none" "prettier")
linters=("none" "eslint" "stylelint")
bundlers=("none" "webpack")
tests=("none", "jest", "playwright")

# Define default values for each option.
# 各オプションのデフォルト値を設定する
default_package_manager=${package_managers[2]}
default_language=${languages[0]}
default_framework=${frameworks[0]}
default_formatter=${formatters[1]}
default_linter=(${linters[1]})
default_bundler=${bundlers[1]}
default_test=${tests[2]}

# Get values from command line arguments.
# コマンドラインの引数から値を取得する
for arg in "$@"
do
  case $arg in
    --package_manager=*)
    package_manager="${arg#*=}"
    shift
    ;;
    --language=*)
    language="${arg#*=}"
    shift
    ;;
    --framework=*)
    framework="${arg#*=}"
    shift
    ;;
    --formatter=*)
    formatter="${arg#*=}"
    shift
    ;;
    --linter=*)
    linter="${arg#*=}"
    shift
    ;;
    --bundler=*)
    bundler="${arg#*=}"
    shift
    ;;
    --test=*)
    test="${arg#*=}"
    shift
    ;;
    *)
    shift
    ;;
  esac
done

# Set default values if no values are provided.
# 入力値がない場合はデフォルトの値を設定する
linter_list=(${linter//,/ })
package_manager=${package_manager:-$default_package_manager}
language=${language:-$default_language}
framework=${framework:-$default_framework}
formatter=${formatter:-$default_formatter}
linter=("${linter_list[@]:-$default_linter}")
bundler=${bundler:-$default_bundler}
test=${test:-$default_test}

# Function to check if an array contains a value.
# 配列内に値が存在するかチェックする関数
array_contains() {
  local array="$1[@]" # $1 is the name of the array passed / $1は渡された配列の名前
  local seeking=$2    # $2 is the value to look for / $2は探す値
  local in=1
  for element in "${!array}"; do
    if [[ $element == $seeking ]]; then
      in=0
      break
    fi
  done
  return $in
}

# Check if the package manager option is valid.
# パッケージマネージャーオプションが有効かどうかチェックする
if ! array_contains package_managers "$package_manager"; then
  echo "${RED}The specified package manager, $package_manager, is not included in the available options: ${package_managers[*]}${END}"
  exit
fi

# Check if the language option is valid.
# 言語オプションが有効かどうかチェックする
if ! array_contains languages "$language"; then
  echo "${RED}The specified language, $language, is not included in the available options: ${languages[*]}${END}"
  exit
fi

# Check if the framework option is valid, if it's specified.
# フレームワークオプションが有効かどうかチェックする（フレームワークが指定された場合）
if ! array_contains frameworks "$framework"; then
  echo "${RED}The specified framework, $framework, is not included in the available options: ${frameworks[*]}${END}"
  exit
fi

# Check if the formatter option is valid, if it's specified.
# フォーマッターオプションが有効かどうかチェックする（フォーマッターが指定された場合）
if ! array_contains formatters "$formatter"; then
  echo "${RED}The specified formatter, $formatter, is not included in the available options: ${formatters[*]}${END}"
  exit
fi

# Check if the linter options are valid.
# リンターオプションが有効かどうかチェックする
for value in "${linter[@]}"
do
  value=${value[0]}
  if ! array_contains linters "$value"; then
    echo "${RED}The specified linter, $value, is not included in the available options: ${linters[*]}${END}"
    exit
  fi
done

# Check if the bundler option is valid, if it's specified.
# バンドラーオプションが有効かどうかチェックする（バンドラーが指定された場合）
if ! array_contains bundlers "$bundler"; then
  echo "${RED}The specified bundler, $bundler, is not included in the available options: ${bundlers[*]}${END}"
  exit
fi

# Check if the test option is valid, if it's specified.
# テストオプションが有効かどうかチェックする（テストが指定された場合）
if ! array_contains tests "$test"; then
  echo "${RED}The specified test, $test, is not included in the available options: ${tests[*]}${END}"
  exit
fi

# Check if the test option is valid, if it's specified.
# テストオプションが有効かどうかチェックする（テストが指定された場合）
if ! array_contains tests "$test"; then
  echo "The specified test, $test, is not included in the available options: ${tests[*]}"
  exit
fi

# Display the selected options.
# 選択されたオプションを表示する
echo "package manager: $package_manager"
echo "language:        $language"
echo "framework:       $framework"
echo "formatter:       $formatter"
echo "linter:          ${linter[@]}"
echo "bundler:         $bundler"
echo "test:            $test"

# Verify that the path is correct before building the environment.
# 環境構築の実行前にパスが正しいか確認する
confirm=""
while [[ "$confirm" != "y" && "$confirm" != "Y" ]]; do
  # Display the current directory.
  # 現在のディレクトリを表示する
  echo "\nCurrent directory: $(pwd)"
  read -p "Do you want to build the environment in this directory? [y/N] " confirm

  # Branch processing according to input.
  # ユーザーの入力の応じて処理を分岐する
  case "$confirm" in
    [yY])
      # If the user enters 'y' or 'Y'.
      # 'y' または 'Y' が入力された場合
      echo "\n"
      echo "Building the environment..."
      ;;
    [nN])
      # If the user enters 'n' or 'N', ask for a new path and change the directory.
      # 'n' または 'N' が入力された場合、新しいパスを聞き、ディレクトリを移動する
      read -p $'Enter the new path:\n' path
      cd "$path"
      ;;
    *)
      # If the user enters anything else, exit the script.
      # ユーザーがそれ以外を入力した場合、スクリプトを終了する
      echo "${RED}Aborting the process.${END}"
      exit
      ;;
  esac
done

# Add the user-specified dependencies to an array.
# ユーザーが設定した依存関係を配列に追加する
dependencies=()
dependencies_dev=()

# Add dependencies from the specified files to the appropriate arrays.
# 指定されたファイルから依存関係を読み取り、適切な配列に追加する関数
readline_and_add_dependencies() {
  local file=$1

  while read line; do
    dependencies+=($line)
  done < $file
}

readline_and_add_dependencies_dev() {
  local file=$1

  while read line; do
    dependencies_dev+=($line)
  done < $file
}

# Add dependencies for TypeScript.
# TypeScriptの場合に依存関係を追加する
if [[ $language == "typescript" ]]; then
  readline_and_add_dependencies_dev "AutoEnvSetter/configs/typescript_configs/typescript-dev"
  if [[ $framework == "react" ]]; then
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/typescript_configs/typescript-react-dev"
  fi
  if array_contains linter eslint; then
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/typescript_configs/typescript-eslint-dev"
  fi
fi

# Add dependencies for React.
# Reactの場合に依存関係を追加する
if [[ $framework == "react" ]]; then
  readline_and_add_dependencies "AutoEnvSetter/configs/react_configs/react"
  if array_contains linter eslint; then
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/react_configs/react-eslint-dev"
  fi
fi

# Add dependencies for Prettier.
# Prettierの場合に依存関係を追加する
readline_and_add_dependencies_dev "AutoEnvSetter/configs/prettier_configs/prettier-dev"

# Add dependencies for ESLint.
# ESLintの場合に依存関係を追加する
if array_contains linter eslint; then
  readline_and_add_dependencies_dev "AutoEnvSetter/configs/eslint_configs/eslint-dev"
  if [[ $formatter == "prettier" ]]; then
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/eslint_configs/eslint-prettier-dev"
  fi
fi

# Add dependencies for Stylelint.
# Stylelintの場合に依存関係を追加する
if array_contains linter stylelint; then
  readline_and_add_dependencies_dev "AutoEnvSetter/configs/stylelint_configs/stylelint-dev"
  if [[ $formatter == "prettier" ]]; then
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/stylelint_configs/stylelint-prettier-dev"
  fi
fi

# Add dependencies for Webpack.
# Webpackの場合に依存関係を追加する
if [[ $bundler == "webpack" ]]; then
  readline_and_add_dependencies_dev "AutoEnvSetter/configs/webpack_configs/webpack-dev"
  if [[ $language == "typescript" ]]; then
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/webpack_configs/webpack-typescript-dev"
  else
    readline_and_add_dependencies_dev "AutoEnvSetter/configs/webpack_configs/webpack-javascript-dev"
  fi
fi

# Display the dependencies and development dependencies that will be installed.
# インストールされる依存関係と開発用の依存関係を表示する。
echo ""
echo "${GREEN}Dependencies:${END}"
echo "  ${dependencies[*]}"
echo ""
echo "${GREEN}Development Dependencies:${END}"
echo "  ${dependencies_dev[*]}"
echo ""
echo "After the above packages are installed, the test library will be installed."
echo ""

# Add the dependencies.
# 依存関係を追加する。

npm init -y

case $package_manager in
  "npm")
    npm i ${dependencies[*]}
    npm i -D ${dependencies_dev[*]}
    ;;
  "yarn")
    yarn add ${dependencies[*]}
    yarn add -D ${dependencies_dev[*]}
    ;;
  "pnpm")
    pnpm i ${dependencies[*]}
    pnpm i -D ${dependencies_dev[*]}
    ;;
esac

echo ""

if [[ $test == "playwright" ]]; then
  case $package_manager in
    "npm")
      if [[ $language == "typescript" ]]; then
        npm init playwright@latest --yes -- --quiet --browser=chromium --browser=firefox --browser=webkit --gha
      else
        npm init playwright@latest --yes -- --quiet --browser=chromium --browser=firefox --browser=webkit --lang=js --gha
      fi
      node AutoEnvSetter/scripts/playwright_scripts/playwright.js "npx playwright test"
      ;;
    "yarn")
      if [[ $language == "typescript" ]]; then
        yarn create playwright --yes -- --quiet --browser=chromium --browser=firefox --browser=webkit --gha
      else
        yarn create playwright --yes -- --quiet --browser=chromium --browser=firefox --browser=webkit --lang=js --gha
      fi
      node AutoEnvSetter/scripts/playwright_scripts/playwright.js "yarn playwright test"
      ;;
    "pnpm")
      if [[ $language == "typescript" ]]; then
        pnpm dlx create-playwright --yes -- --quiet --browser=chromium --browser=firefox --browser=webkit --gha
      else
        pnpm dlx create-playwright --yes -- --quiet --browser=chromium --browser=firefox --browser=webkit --lang=js --gha
      fi
      node AutoEnvSetter/scripts/playwright_scripts/playwright.js "pnpm exec playwright test"
      ;;
  esac
  echo ""
  prettier --write package.json
fi

# If TypeScript is the language, create the tsconfig.json file using the appropriate package manager.
# TypeScriptが使用されている場合、適切なパッケージマネージャーを使用して、tsconfig.jsonファイルを作成する。
if [[ $language == "typescript" ]]; then
  # if [[ $package_manager == "npm" ]]; then
  #   npx tsc --init
  # fi
  # if [[ $package_manager == "yarn" ]]; then
  #   yarn tsc --init
  # fi
  # if [[ $package_manager == "pnpm" ]]; then
  #   pnpm tsc --init
  # fi
  case $package_manager in
    "npm")
      npx tsc --init
      ;;
    "yarn")
      yarn tsc --init
      ;;
    "pnpm")
      pnpm tsc --init
      ;;
  esac
  if [[ $framework == "react" ]]; then
    node AutoEnvSetter/scripts/typescript_scripts/typescript-react.js
    prettier --write tsconfig.json
  fi
fi

# If the formatter is Prettier, copy the .prettierignore and .prettierrc.js files to the current directory.
# フォーマッターがPrettierの場合、.prettierignoreと.prettierrc.jsファイルを現在のディレクトリにコピーする。
if [[ $formatter == "prettier" ]]; then
  $FILE_COPY_COMMAND AutoEnvSetter/configs/prettier_configs/.prettierignore .prettierignore
  $FILE_COPY_COMMAND AutoEnvSetter/configs/prettier_configs/.prettierrc.js .prettierrc.js
fi

# If the linter is ESLint, create the appropriate .eslintrc.js file and .eslintignore file.
# リンターがESLintの場合、適切な .eslintrc.jsファイルと .eslintignoreファイルを作成する。
if array_contains linter eslint; then
  if [[ $language == "typescript" ]]; then
    if [[ $framework == "react" ]]; then
      $FILE_COPY_COMMAND AutoEnvSetter/configs/eslint_configs/.eslintrc-typescript-react.js .eslintrc.js
    else
      $FILE_COPY_COMMAND AutoEnvSetter/configs/eslint_configs/.eslintrc-typescript.js .eslintrc.js
    fi
  else
    if [[ $framework == "react" ]]; then
      $FILE_COPY_COMMAND AutoEnvSetter/configs/eslint_configs/.eslintrc-react.js .eslintrc.js
    else
      $FILE_COPY_COMMAND AutoEnvSetter/configs/eslint_configs/.eslintrc.js .eslintrc.js
    fi
  fi
  $FILE_COPY_COMMAND AutoEnvSetter/configs/eslint_configs/.eslintignore .eslintignore

  if [[ $formatter == "prettier" ]]; then
    node AutoEnvSetter/scripts/eslint_scripts/eslint-prettier.js
    prettier --write .eslintrc.js
  fi
fi

# If the linter is Stylelint, create the appropriate .stylelintrc.js file and .stylelintignore file.
# リンターがStylelintの場合、適切な .stylelintrc.jsファイルと .stylelintignoreファイルを作成する。
if array_contains linter stylelint; then
  $FILE_COPY_COMMAND AutoEnvSetter/configs/stylelint_configs/.stylelintignore .stylelintignore
  $FILE_COPY_COMMAND AutoEnvSetter/configs/stylelint_configs/.stylelintrc.js .stylelintrc.js
  if [[ $formatter == "prettier" ]]; then
    node AutoEnvSetter/scripts/eslint_scripts/eslint-prettier.js
    prettier --write .stylelintrc.js
  fi
fi

# If the bundler is webpack, create the appropriate webpack.config.js file.
# バンドラーがwebpackの場合、適切な webpack.config.jsファイルを作成する。
if [[ $bundler == "webpack" ]]; then
  # Create directories for source and build.
  # ソースとビルド用のディレクトリを作成する。
  mkdir src
  mkdir dist

  # Create initial index.html and styles.scss files.
  # 初期のindex.htmlおよびstyles.scssファイルを作成する。
  touch src/index.html
  touch src/index.scss
  touch src/App.scss

  $FILE_COPY_COMMAND AutoEnvSetter/configs/webpack_configs/postcss.config.js postcss.config.js
  if [[ $language == "typescript" ]]; then
    if [[ $framework == "react" ]]; then
      # For TypeScript + React
      # TypeScript + Reactの場合
      $FILE_COPY_COMMAND AutoEnvSetter/configs/webpack_configs/webpack.config-typescript-react.js webpack.config.js
      $FILE_COPY_COMMAND AutoEnvSetter/configs/react_configs/react-typescript-index.tsx src/index.tsx
    else
      # For TypeScript
      # TypeScriptの場合
      $FILE_COPY_COMMAND AutoEnvSetter/configs/webpack_configs/webpack.config-typescript.js webpack.config.js
      echo 'import "./index.scss";' > src/index.ts
    fi
  else
    if [[ $framework == "react" ]]; then
    # For JavaScript + React
    # JavaScript + Reactの場合
     $FILE_COPY_COMMAND AutoEnvSetter/configs/webpack_configs/webpack.config-javascript-react.js webpack.config.js
     $FILE_COPY_COMMAND AutoEnvSetter/configs/react_configs/react-javascript-index.jsx src/index.jsx
    else
      # For JavaScript
      # JavaScript
      $FILE_COPY_COMMAND AutoEnvSetter/configs/webpack_configs/webpack.config-javascript.js webpack.config.js
      echo 'import "./index.scss";' > src/index.js
    fi
  fi
  node AutoEnvSetter/scripts/webpack_scripts/_webpack.js
  prettier --write package.json
fi

echo ""
echo "${LIGHT_CYAN}TODO: Please edit webServer in the playwright.config.ts file as follows.${END}"
echo ""
case $package_manager in
  "npm")
    echo "webServer: {command: 'npm run dev', port: 8080, reuseExistingServer: !process.env.CI},"
    ;;
  "yarn")
    echo "webServer: {command: 'yarn dev', port: 8080, reuseExistingServer: !process.env.CI},"
    ;;
  "pnpm")
    echo "webServer: {command: 'pnpm dev', port: 8080, reuseExistingServer: !process.env.CI},"
    ;;
esac
