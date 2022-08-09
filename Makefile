USER = brove
KEYBOARDS = planck planckez technik microdox

# keymap local path
LOCALPATH_planck = planck
LOCALPATH_planckez = planck
LOCALPATH_technik = technik
LOCALPATH_microdox = microdox

# keymap qmk path
QMKPATH_planck = planck
QMKPATH_planckez = planck
QMKPATH_technik = boardsource/technik_o
QMKPATH_microdox = boardsource/microdox

# keyboard name
NAME_planck = planck/rev6
NAME_planckez = planck/ez
NAME_technik = boardsource/technik_o
NAME_microdox = boardsource/microdox


# run:
# make all (to build all keymaps)
# make planck
# make technik
# ...

all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
$(KEYBOARDS):
	# init submodule
	git submodule update --init --recursive
	git submodule foreach git pull origin master
	git submodule foreach make git-submodule 


	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(USER)
	#rm -rf qmk_firmware/users/$(USER)

	# add new symlinks
	#ln -s $(shell pwd)/user qmk_firmware/users/$(USER)
	#ln -s $(shell pwd)/$@ qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(USER)
	ln -s $(shell pwd)/$(LOCALPATH_$@) qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(USER)

	# run lint check
	#cd qmk_firmware; qmk lint -km $(USER) -kb $(NAME_$@) --strict

	# run build
	make BUILD_DIR=$(shell pwd)/build -j1 -C qmk_firmware $(NAME_$@):$(USER)

	# cleanup symlinks
	rm -rf qmk_firmware/keyboards/$(QMKPATH_$@)/keymaps/$(USER)
	#rm -rf qmk_firmware/users/$(USER)

clean:
	rm -rf ./qmk_firmware/
	rm -rf ./build/
	#rm -rf qmk_firmware/keyboards/$(PATH_lily58)/keymaps/$(USER)
	#rm -rf qmk_firmware/keyboards/$(PATH_kyria)/keymaps/$(USER)
	#rm -rf qmk_firmware/keyboards/$(PATH_sweep)/keymaps/$(USER)
	#rm -rf qmk_firmware/users/$(USER)