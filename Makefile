all: bin/chess

bin/chess: obj/src/chess/chess.cpp obj/src/libchess/libchess.a obj/src/chess/board_read.o
	gcc -Wall -Werror -o bin/chess obj/src/chess/chess.cpp obj/src/libchess/libchess.a obj/src/chess/board_read.o
	
obj/src/chess/chess.cpp: src/chess/chess.cpp
	gcc -I src -Wall -Werror -c -o obj/src/chess/chess.cpp src/chess/chess.cpp
	
obj/src/chess/board_read.o: src/chess/board_read.c
	gcc -I src -Wall -Werror -c -o obj/src/chess/board_read.o src/chess/board_read.c
	
obj/src/libchess/libchess.a: obj/src/libchess/board.o obj/src/libchess/board_print_plain.o obj/src/libchess/move.o
	ar rcs obj/src/libchess/libchess.a obj/src/libchess/board.o obj/src/libchess/board_print_plain.o obj/src/libchess/move.o
	
obj/src/libchess/board.o: src/libchess/board.c
	gcc -I src -Wall -Werror -c -o obj/src/libchess/board.o src/libchess/board.c
	
obj/src/libchess/board_print_plain.o: src/libchess/board_print_plain.c
	gcc -I src -Wall -Werror -c -o obj/src/libchess/board_print_plain.o src/libchess/board_print_plain.c
	
obj/src/libchess/move.o: src/libchess/move.c
	gcc -I src -Wall -Werror -c -o obj/src/libchess/move.o src/libchess/move.c
	

.PHONY: all install uninstall clean

clean:
	rm obj/src/*/*.o
	rm bin/chess
