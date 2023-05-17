BIN_DIR  := build
SRC_DIR  := src
OBJ_DIR  := obj
TARGET   := $(BIN_DIR)/cskel
SRC      := $(wildcard $(SRC_DIR)/*.c)
OBJ      := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC))
CC		 := /usr/bin/gcc
CPPFLAGS := -Iinclude -MMD -MP 
CFLAGS   := -Wall              
LDFLAGS  := -Llib              
LDLIBS   :=

$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

$(TARGET): $(OBJ) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

clean:
	@$(RM) -rv $(BIN_DIR) $(OBJ_DIR)

run:
	@$(TARGET)

.PHONY: \
	all \
	clean \
	run

.DEFAULT_GOAL := $(TARGET)

-include $(OBJ:.o=.d)
