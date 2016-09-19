SOURCES=$(shell ls src/*.nim)

synth: $(SOURCES)
	nim c -d:release -o:$@ --threads:on src/main.nim

synth-osx: $(SOURCES)
	nim c -d:osx -d:release -o:$@ --threads:on --stackTrace:off --tlsEmulation:off src/main.nim

windows: $(SOURCES)
	nim c -d:windows -d:release -o:windows/nimsynth.exe --threads:on --stackTrace:off --tlsEmulation:off src/main.nim
.PHONY: windows

synth-debug: $(SOURCES)
	nim c -d:debug --lineTrace:on --stackTrace:on -x:on --debugger:native -o:$@ --threads:on src/main.nim

run: synth
	./synth

rund: synth-debug
	./synth-debug
