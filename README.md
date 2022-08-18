# keymaps

Work in progress - setup inspired by [Patrick Elmquist @ medium.com](https://medium.com/@patrick.elmquist/separate-keymap-repo-for-qmk-136ff5a419bd)

## Quick setup steps
- Create new repo on github

- Clone to computer

- Add qmk as submodule:  

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

- Build your keymaps:  
  `make keyboardname` (build keyboardname)  

