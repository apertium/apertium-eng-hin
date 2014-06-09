SUBDIRS=$(AP_SUBDIRS)

VERSION=0.1.0
LANG1=eng
LANG2=hin
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

##
##	BUILD TARGETS
##

TARGETS_COMMON =  \
     $(PREFIX1).automorf.bin $(PREFIX1).autobil.bin $(PREFIX1).autogen.bin \
     $(PREFIX2).automorf.bin $(PREFIX2).autobil.bin $(PREFIX2).autogen.bin $(PREFIX2).autolex.bin $(PREFIX2).autopgen.bin \
     $(PREFIX2).rlx.bin \
     $(PREFIX1).t1x.bin  $(PREFIX1).t2x.bin $(PREFIX1).t3x.bin \
     $(PREFIX2).t1x.bin  $(PREFIX2).t2x.bin $(PREFIX2).t3x.bin $(PREFIX2).t4x.bin


# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

##
## 	DICTIONARIES (ANALYSER / BILINGUAL / GENERATOR / POSTGEN)
##


$(PREFIX1).automorf.bin: $(BASENAME).$(LANG1).dix $(BASENAME).$(LANG1).acx
	apertium-validate-acx $(BASENAME).$(LANG1).acx
	apertium-validate-dictionary $(BASENAME).$(LANG1).dix
	lt-comp lr $(BASENAME).$(LANG1).dix $@ $(BASENAME).$(LANG1).acx

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
	lt-comp lr $(BASENAME).$(PREFIX1).dix $@

$(PREFIX1).autogen.bin: $(AP_SRC2)/$(LANG2).autogen.bin
	cp $< $@

$(PREFIX2).automorf.bin: $(AP_SRC2)/$(LANG2).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $^ $@

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
	lt-comp rl $(BASENAME).$(PREFIX1).dix $@

$(PREFIX2).autogen.bin: $(BASENAME).$(LANG1).dix $(BASENAME).$(LANG1).acx
	apertium-validate-acx $(BASENAME).$(LANG1).acx
	apertium-validate-dictionary $(BASENAME).$(LANG1).dix
	lt-comp rl $(BASENAME).$(LANG1).dix $@ $(BASENAME).$(LANG1).acx

$(PREFIX2).autopgen.bin: $(BASENAME).post-$(LANG1).dix
	apertium-validate-dictionary $(BASENAME).post-$(LANG1).dix
	lt-comp lr $(BASENAME).post-$(LANG1).dix $@ 


##
##	DISAMBIGUATION RULES
##

$(PREFIX2).rlx.bin: $(BASENAME).$(PREFIX2).rlx
	cg-comp $(BASENAME).$(PREFIX2).rlx $@

##
##	LEXICAL-SELECTION RULES
##

$(PREFIX2).autolex.bin: $(BASENAME).$(PREFIX2).lrx
	lrx-comp $(BASENAME).$(PREFIX2).lrx $@


##
##	TRANSFER RULES
##

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX1).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t2x $@

$(PREFIX1).t3x.bin: $(BASENAME).$(PREFIX1).t3x
	apertium-validate-postchunk $(BASENAME).$(PREFIX1).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t3x $@

$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX2).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t2x $@

$(PREFIX2).t3x.bin: $(BASENAME).$(PREFIX2).t3x
	apertium-validate-interchunk $(BASENAME).$(PREFIX2).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t3x $@

$(PREFIX2).t4x.bin: $(BASENAME).$(PREFIX2).t4x
	apertium-validate-postchunk $(BASENAME).$(PREFIX2).t4x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t4x $@



## 
##	FILES WHICH AREN'T BUILD BUT ARE DISTRIBUTED
## 

EXTRA_DIST=$(BASENAME).$(LANG1).dix $(BASENAME).$(PREFIX1).dix \
	   $(BASENAME).$(LANG2).dix \
           $(PREFIX1).prob  \
	   $(BASENAME).$(PREFIX1).t1x $(BASENAME).$(PREFIX1).t2x \
	   $(BASENAME).$(PREFIX1).t3x\
	   $(BASENAME).$(LANG1).tsx \
	   modes.xml


#           $(LANG1)-tagger-data/README $(LANG2)-tagger-data/README 

###############################################################################
## Installation
###############################################################################

apertium_eng_hindir=$(prefix)/share/apertium/apertium-$(PREFIX1)/

apertium_eng_hin_DATA=$(TARGETS_COMMON) \
                    $(PREFIX1).prob \
	$(BASENAME).$(PREFIX1).t1x \
	$(BASENAME).$(PREFIX1).t2x \
	$(BASENAME).$(PREFIX1).t3x 


# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1).mode


install-data-local: install-modes

###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local: 
	-rm -rf .deps modes
