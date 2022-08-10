KEYBOARDS = planck48 planck34 planckez48 planckez34 technik48 technik34 microdox sweep
USER34KEYS = brove
USER48KEYS = brianoverby

# keymap local path
LOCALPATH_planck34 = planck
LOCALPATH_planck48 = planck
LOCALPATH_planckez34 = planck
LOCALPATH_planckez48 = planck
LOCALPATH_technik34 = technik
LOCALPATH_technik48 = technik
LOCALPATH_microdox = microdox
LOCALPATH_sweep = sweep

# keymap qmk path
QMKPATH_planck34 = planck
QMKPATH_planck48 = planck
QMKPATH_planckez34 = planck
QMKPATH_planckez48 = planck
QMKPATH_technik34 = boardsource/technik_o
QMKPATH_technik48 = boardsource/technik_o
QMKPATH_microdox = boardsource/microdox
QMKPATH_sweep = ferris

# keyboard name
NAME_planck34 = planck/rev6
NAME_planck48 = planck/rev6
NAME_planckez34 = planck/ez
NAME_planckez48 = planck/ez
NAME_technik34 = boardsource/technik_o
NAME_technik48 = boardsource/technik_o
NAME_microdox = boardsource/microdox
NAME_sweep = ferris/sweep


# run:
# make all (to build all keymaps)
# make planck34
# make technik48
# ...

#all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
planck34: QMKUSER = brove
planck48: QMKUSER = brianoverby
planckez34: QMKUSER = brove
planckez48: QMKUSER = brianoverby
technik34: QMKUSER = brove
technik48: QMKUSER = brianoverby
microdox: QMKUSER = brove
sweep: QMKUSER = brove
$(KEYBOARDS):
	# init submodule
	git submodule update --init --recursive
	git submodule foreach git pull origin master
	git submodule foreach make git-submodule 

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(QMKUSER)
	rm -rf qmk_firmware/users/$(QMKUSER)

	# add new symlinks
	ln -s $(shell pwd)/users/$(QMKUSER) qmk_firmware/users/$(QMKUSER)
	ln -s $(shell pwd)/$(LOCALPATH_$@) qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(QMKUSER)

	## run lint check
	##cd qmk_firmware; qmk lint -km $(QMKUSER) -kb $(NAME_$@) --strict

	# run build
	make BUILD_DIR=$(shell pwd)/build -j1 -C qmk_firmware $(NAME_$@):$(QMKUSER)

	# cleanup symlinks
	rm -rf qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(QMKUSER)
	rm -rf qmk_firmware/users/$(QMKUSER)

clean:
	rm -rf ./qmk_firmware/
	rm -rf ./build/