mkdir -p build\
cmake -G "Unix Makefiles" -B build .
make -C build
.\build\out.exe
