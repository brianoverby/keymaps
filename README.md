# keymaps

Work in progress - setup inspired by [Patrick Elmquist @ medium.com](https://medium.com/@patrick.elmquist/separate-keymap-repo-for-qmk-136ff5a419bd)

## Quick setup steps
- Create new repo on github
  Let's call it `keymaps` for this README

- Clone to computer

        git clone https://github.com/brianoverby/keymaps.git
        cd keymaps
  

- Add QMK as submodule:  

        git submodule add https://github.com/qmk/qmk_firmware.git
        git submodule update --init --recursive

- Create .gitignore file:  

        obj_*  
        *.hex  
        *.elf  
        *.map   
        build/  

- Create your file structure:  

        keyboards/planck/
        keyboards/sweep/
        keyboards/technik/
        keyboards/microdox/
        users/

- Creat a [Makefile](https://github.com/brianoverby/keymaps/blob/main/Makefile)
  This `Makefile` should update the QMK submodule and create links to the correct keyboard and user files.

- Build your keymaps:  
  `make keyboardname` (build keyboardname)  

