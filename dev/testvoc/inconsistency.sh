TMPDIR=/tmp

DIR=$1

if [[ $DIR = "hin-eng" ]]; then

lt-expand ../../apertium-eng-hin.hin.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../hin-eng.autobil.bin |  tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        apertium-transfer -b ../../apertium-eng-hin.hin-eng.t1x  ../../hin-eng.t1x.bin |
        apertium-interchunk ../../apertium-eng-hin.hin-eng.t2x  ../../hin-eng.t2x.bin |
        apertium-interchunk ../../apertium-eng-hin.hin-eng.t3x  ../../hin-eng.t3x.bin |
        apertium-postchunk ../../apertium-eng-hin.hin-eng.t4x  ../../hin-eng.t4x.bin  | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        lt-proc -d ../../hin-eng.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'

elif [[ $DIR = "eng-hin" ]]; then

lt-expand ../../apertium-eng-hin.eng.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../eng-hin.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        apertium-transfer -b ../../apertium-eng-hin.eng-hin.t1x  ../../eng-hin.t1x.bin |
        apertium-interchunk ../../apertium-eng-hin.eng-hin.t2x  ../../eng-hin.t2x.bin |
        apertium-postchunk ../../apertium-eng-hin.eng-hin.t3x  ../../eng-hin.t3x.bin  | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        lt-proc -d ../../eng-hin.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt| sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'


else
	echo "bash inconsistency.sh <direction>";
fi
