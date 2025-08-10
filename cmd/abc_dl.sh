#! /bin/bash

### 引数は"abc123"のように指定する

# example
# ----------------------------------------------------------------
# ./cmd/abc_dl abc123
# >>>> abcディレクトリ配下にabc123のworkspaceが作成される
# ----------------------------------------------------------------



# 引数が「abc+数字3桁(abcXXX)」の形式でなければエラーを出力し、処理を終了する
if [[ ! "$1" =~ ^abc[0-9]{3}$ ]]; then
    echo "Invalid argument: expected format 'abcXXX' (e.g., abc123)"
    return 1
fi

WORKDIR="/app"
CONTEST_DIR="${WORKDIR}/src/atcoder/abc"
PROBLEM_DIR="${CONTEST_DIR}/$1"
CPP_TEMPLATE="${WORKDIR}/templates/atcoder.cpp"
PYTHON_TEMPLATE="${WORKDIR}/templates/atcoder.py"
INPUT_TEMPLATE="${WORKDIR}/templates/input.txt"
README_TEMPLATE="${WORKDIR}/templates/README.md"

# 該当コンテスト(例：abc123)のフォルダを作成し，テストデータをダウンロードする
mkdir -p $CONTEST_DIR
cd $CONTEST_DIR
acc new $1

# ダウンロードしたテストデータに対して，cpp,py,READMEファイルを作成する
PROBLEMS="${PROBLEM_DIR}/*"
for DIRPATH in $PROBLEMS; do
    if [ ! -d $DIRPATH ]; then
        continue
    fi

    cp -n $CPP_TEMPLATE "${DIRPATH}/$1_${DIRPATH##*/}.cpp"
    cp -n $PYTHON_TEMPLATE "${DIRPATH}/$1_${DIRPATH##*/}.py"
    cp -n $INPUT_TEMPLATE "${DIRPATH}/input.txt"
    cp -n $README_TEMPLATE "${DIRPATH}/README.md"
done