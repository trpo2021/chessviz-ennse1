CFLAGS = -Wall -Wextra -Werror
APP_NAME = chessviz
LIB_NAME = libchessviz
TEST_APP_NAME = chessviz-test

CC = gcc
RM = rm -rf

CFLAGS = -Wall -Wextra -Werror -std=c11
CPPFLAGS = -I src -MP -MMD
CPPFLAGS_TEST = -I src -I thirdparty -MP -MMD
LDFLAGS =
LDLIBS =

BIN_DIR = bin
OBJ_DIR = obj
SRC_DIR = src
TEST_DIR = test

APP_PATH = $(BIN_DIR)/$(APP_NAME)
LIB_PATH = $(OBJ_DIR)/$(SRC_DIR)/$(LIB_NAME)/$(LIB_NAME).a
TEST_APP_PATH = $(BIN_DIR)/$(TEST_APP_NAME)

SRC_EXT = c

APP_SOURCES = $(shell find $(SRC_DIR)/$(APP_NAME) -name '*.$(SRC_EXT)')
APP_OBJECTS = $(APP_SOURCES:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/$(SRC_DIR)/%.o)

.PHONY:	all
LIB_SOURCES = $(shell find $(SRC_DIR)/$(LIB_NAME) -name '*.$(SRC_EXT)')
LIB_OBJECTS = $(LIB_SOURCES:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/$(SRC_DIR)/%.o)

all:	bin/Chess.exe Run clean
TEST_APP_SOURCES = $(shell find $(TEST_DIR) -name '*.$(SRC_EXT)')
TEST_APP_OBJECTS = $(TEST_APP_SOURCES:$(TEST_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/$(TEST_DIR)/%.o)

bin/Chess.exe:  obj/src/Chess/Chess.o obj/src/libChess/libChessHelper.a
	g++ $(CFLAGS) -o $@ $^
DEPS = $(APP_OBJECTS:.o=.d) $(LIB_OBJECTS:.o=.d)
TEST_DEPS = $(TEST_APP_OBJECTS:.o=.d) $(LIB_OBJECTS:.o=.d)

obj/src/Chess/Chess.o: src/Chess/Chess.cpp
	g++ -c $(CFLAGS) $(CPPFLAGS) -o $@ $<
.PHONY: all
all: $(APP_PATH)

obj/src/libChess/libChessHelper.a: obj/src/Chess/ChessHelper.o
-include $(DEPS)

$(APP_PATH): $(APP_OBJECTS) $(LIB_PATH)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

$(LIB_PATH): $(LIB_OBJECTS)
	ar rcs $@ $^

obj/src/Chess/ChessHelper.o: src/libChess/ChessHelper.cpp
	g++ -c $(CFLAGS) $(CPPFLAGS) -o $@ $<
$(OBJ_DIR)/$(SRC_DIR)/$(APP_NAME)/%.o: $(SRC_DIR)/$(APP_NAME)/%.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

$(OBJ_DIR)/$(SRC_DIR)/$(LIB_NAME)/%.o: $(SRC_DIR)/$(LIB_NAME)/%.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

.PHONY: test
test: $(TEST_APP_PATH)
	./$(TEST_APP_PATH)

-include $(TEST_DEPS)

Run:
	bin/Chess.exe
$(TEST_APP_PATH): $(TEST_APP_OBJECTS) $(LIB_PATH)
	$(CC) $(CFLAGS) $(CPPFLAGS_TEST) $^ -o $@ $(LDFLAGS) $(LDLIBS)

-include obj/src/Chess/Chess.d obj/src/Chess/ChessHelper.d
$(OBJ_DIR)/$(TEST_DIR)/%.o: $(TEST_DIR)/%.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS_TEST) $< -o $@

.PHONY: clean
clean:
	rm -f obj/src/Chess/ChessHelper.o obj/src/libChess/libChessHelper.a obj/src/Chess/Chess.o obj/src/Chess/ChessHelper.d obj/src/Chess/Chess.d 
	$(RM) $(APP_PATH) $(LIB_PATH) $(TEST_APP_PATH)
	find $(OBJ_DIR) -name '*.o' -exec $(RM) '{}' \;
	find $(OBJ_DIR) -name '*.d' -exec $(RM) '{}' \;
