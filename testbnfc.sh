#!/bin/sh

set -e
set -u
set -v

BNFC=${1:-bnfc}

TMPDIR=`mktemp -d`

trap 'echo "removing $TMPDIR"; rm -rf ${TMPDIR}' INT TERM EXIT

cd ${TMPDIR}

echo "EAdd. Exp  ::= Exp  \"+\" Exp1 ;" >  Calc.cf
echo "ESub. Exp  ::= Exp  \"-\" Exp1 ;" >> Calc.cf
echo "EMul. Exp1 ::= Exp1 \"*\" Exp2 ;" >> Calc.cf
echo "EDiv. Exp1 ::= Exp1 \"/\" Exp2 ;" >> Calc.cf
echo "EInt. Exp2 ::= Integer ;" >> Calc.cf
echo "coercions Exp 2 ;" >> Calc.cf

${BNFC} -m Calc.cf
make
