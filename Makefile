KEYBOARDS = planck48 planck34 planckez48 planckez34 technik48 technik34 microdox sweep
USER34KEYS = brove
USER48KEYS = brianoverby

# keymap local path (relative to Makefile)
LOCALPATH_planck34 = keyboards/planck
LOCALPATH_planck48 = keyboards/planck
LOCALPATH_planckez34 = keyboards/planck
LOCALPATH_planckez48 = keyboards/planck
LOCALPATH_technik34 = keyboards/technik
LOCALPATH_technik48 = keyboards/technik
LOCALPATH_microdox = keyboards/microdox
LOCALPATH_sweep = keyboards/sweep

# keymap qmk path (qmk_firmware/keyboards/*)
QMKPATH_planck34 = planck
QMKPATH_planck48 = planck
QMKPATH_planckez34 = planck
QMKPATH_planckez48 = planck
QMKPATH_technik34 = boardsource/technik_o
QMKPATH_technik48 = boardsource/technik_o
QMKPATH_microdox = boardsource/microdox
QMKPATH_sweep = ferris

# keyboard name (QMK)
NAME_planck34 = planck/rev6
NAME_planck48 = planck/rev6
NAME_planckez34 = planck/ez
NAME_planckez48 = planck/ez
NAME_technik34 = boardsource/technik_o
NAME_technik48 = boardsource/technik_o
NAME_microdox = boardsource/microdox
NAME_sweep = ferris/sweep

# run:
# make planck34
# make technik48
# ...

.PHONY: $(KEYBOARDS)
planck34: QMKUSER = $(USER34KEYS)
planck48: QMKUSER = $(USER48KEYS)
planckez34: QMKUSER = $(USER34KEYS)
planckez48: QMKUSER = $(USER48KEYS)
technik34: QMKUSER = $(USER34KEYS)
technik48: QMKUSER = $(USER48KEYS)
microdox: QMKUSER = $(USER34KEYS)
sweep: QMKUSER = $(USER34KEYS)
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