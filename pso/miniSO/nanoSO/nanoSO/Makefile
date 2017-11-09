# Arquivo: Makefile
# Autor:   Roland Teodorowitsch
#


# ---- all ---------------------------------------
all:		nanoSO.img

# ---- nanoSO.img --------------------------------
nanoSO.img:	boot.bin nanoSO.bin
		@mkfpimg boot.bin nanoSO.bin nanoSO.img

# ---- boot.bin ----------------------------------
boot.asm:	boot.bl
		@bootlib -o boot.asm boot.bl

boot.obj:	boot.asm
		@tasm /zn boot

boot.exe:	boot.obj
                @tlink boot

boot.bin:	boot.exe
		@exe2bin boot boot.bin

# ---- nanoSO.bin --------------------------------
nanoSO.obj:	nanoSO.asm
		@tasm /zn nanoSO,,,

nanoSO.exe:	nanoSO.obj
		@tlink /s nanoSO,,,,

nanoSO.bin:	nanoSO.exe
		@exe2bin nanoSO nanoSO.bin

# ---- clean -------------------------------------
clean:
		@if exist bootlib.str del bootlib.str
		@if exist boot.asm del boot.asm
		@if exist *.obj del *.obj
		@if exist *.bin del *.bin
		@if exist *.exe del *.exe
		@if exist *.map del *.map
		@if exist *.xrf del *.xrf
		@if exist *.lst del *.lst
		@if exist *.img del *.img
		@if exist bochsout.txt del bochsout.txt

# ---- install ------------------------------------
install:	boot.bin nanoSO.bin
		@bootcopy boot.bin
		@if exist a:\nanoSO.bin del a:\nanoSO.bin
		@copy nanoSO.bin a:\ > nul

# ---- run ----------------------------------------
run:		all
		@-bochs -q -f nanoSO.bochsrc > nul
