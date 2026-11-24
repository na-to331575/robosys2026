#!/bin/bash
# SPDX-FileCopyrightText: 2026 Nitta Nanato
# SPDX-License-Identifier: BSD-3-Clause

ng () {
        echo ${1}行目のテスト失敗
        res=1
}

res=0

out=$(seq 5 | ./plus)
[ "$?" = 0 ]      || ng "$LINENO"
[ "${out}" = 15 ] || ng "$LINENO"


out=$(echo "60 10" | ./rmcalc)
[ "$?" = 0 ]          || ng "$LINENO"
[ "${out}" = "75.0" ] || ng "$LINENO"

out=$(echo "80 1" | ./rmcalc)
[ "$?" = 0 ]          || ng "$LINENO"
[ "${out}" = "80.0" ] || ng "$LINENO"

out=$(printf "60 10\n80 5\n" | ./rmcalc)
[ "$?" = 0 ]                 || ng "$LINENO"
[ "${out}" = $'75.0\n90.0' ] || ng "$LINENO"


out=$(echo "あ 10" | ./rmcalc)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo "60" | ./rmcalc)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo "60 -5" | ./rmcalc)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "" | ./rmcalc)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res

