#!/usr/bin/env bash

TMPDIR=/tmp

DICT=$1
DIR=$2

SED=sed

if [[ $DIR = "hin-eng" ]]; then

# Run the bilingual dictionary before to make sure we are only checking things we have.
lt-expand $DICT | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | $SED 's/:>:/%/g' | $SED 's/:/%/g' | cut -f2 -d'%' |  $SED 's/^/^/g' | $SED 's/$/$ ^.<sent>$/g' | apertium-pretransfer | lt-proc -b ../../hin-eng.autobil.bin | grep -v '/@' | cut -f1 -d'/' | $SED 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |\
        apertium-pretransfer|\
	lt-proc -b ../../hin-eng.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |\
        apertium-transfer -b ../../apertium-eng-hin.hin-eng.t1x  ../../hin-eng.t1x.bin |\
	apertium-interchunk ../../apertium-eng-hin.hin-eng.t2x ../../hin-eng.t2x.bin |\
	apertium-interchunk ../../apertium-eng-hin.hin-eng.t3x ../../hin-eng.t3x.bin |\
	apertium-postchunk ../../apertium-eng-hin.hin-eng.t4x ../../hin-eng.t4x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |\
        lt-proc -d ../../hin-eng.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | $SED 's/\^.<sent>\$//g' | $SED 's/_/   --------->  /g'

else
	echo "bash inconsistency.sh <direction>";
fi
