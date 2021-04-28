<<<<<<< HEAD
CFLAGS = -Wall -Wextra -Werror
CPPFLAGS = -I src -MP -MMD

.PHONY:	all

all:	bin/Chess.exe Run clean

bin/Chess.exe:  obj/src/Chess/Chess.o obj/src/libChess/libChessHelper.a
	g++ $(CFLAGS) -o $@ $^

obj/src/Chess/Chess.o: src/Chess/Chess.cpp
	g++ -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

obj/src/libChess/libChessHelper.a: obj/src/Chess/ChessHelper.o
	ar rcs $@ $^

obj/src/Chess/ChessHelper.o: src/libChess/ChessHelper.cpp
	g++ -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

Run:
	bin/Chess.exe

-include obj/src/Chess/Chess.d obj/src/Chess/ChessHelper.d

clean:
	rm -f obj/src/Chess/ChessHelper.o obj/src/libChess/libChessHelper.a obj/src/Chess/Chess.o obj/src/Chess/ChessHelper.d obj/src/Chess/Chess.d
=======
<<<<<<< HEAD
bin/chess: obj/src/chessviz/main.o obj/src/libchessviz/libchessviz.a obj/src/chessviz/board_read.o
	gcc -Wall -Werror -o bin/chess obj/src/chessviz/main.o obj/src/libchessviz/libchessviz.a obj/src/chessviz/board_read.o
	
obj/src/chessviz/main.o: src/chessviz/main.c
	gcc -I src -Wall -Werror -c -o obj/src/chessviz/main.o src/chessviz/main.c
	
obj/src/chessviz/board_read.o: src/chessviz/board_read.c
	gcc -I src -Wall -Werror -c -o obj/src/chessviz/board_read.o src/chessviz/board_read.c
	
obj/src/libchessviz/libchessviz.a: obj/src/libchessviz/board.o obj/src/libchessviz/board_print_plain.o obj/src/libchessviz/move.o
	ar rcs obj/src/libchessviz/libchessviz.a obj/src/libchessviz/board.o obj/src/libchessviz/board_print_plain.o obj/src/libchessviz/move.o
	
obj/src/libchessviz/board.o: src/libchessviz/board.c
	gcc -I src -Wall -Werror -c -o obj/src/libchessviz/board.o src/libchessviz/board.c
	
obj/src/libchessviz/board_print_plain.o: src/libchessviz/board_print_plain.c
	gcc -I src -Wall -Werror -c -o obj/src/libchessviz/board_print_plain.o src/libchessviz/board_print_plain.c
	
obj/src/libchessviz/move.o: src/libchessviz/move.c
	gcc -I src -Wall -Werror -c -o obj/src/libchessviz/move.o src/libchessviz/move.c
	
.PHONY: all
all: bin/chess
.PHONY: clean
clean:
	rm obj/src/*/*.o
	rm bin/chess
	rm obj/src/libchessviz/libchessviz.a
>>>>>>> 6d31b0c8b67c749cff7dd2fec0a8519f59d1a5a0
