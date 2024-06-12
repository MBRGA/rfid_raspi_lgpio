CXX = g++

CXXFLAGS = -Wall -Wextra -Werror

SRC_DIR = ./src
BUILD_DIR = ./build

SRC_FILES = MFRC522.cpp MFRC522Extended.cpp 
OBJ_FILES = $(SRC_FILES:.cpp=.o)
H_FILES = $(SRC_FILES:.cpp=.h)

NAME = libmfrc522.a

# Set output directory
ifeq ($(PREFIX),)
	PREFIX = /usr/local
endif

all: $(BUILD_DIR)/$(NAME) clean

$(BUILD_DIR)/$(NAME): $(addprefix $(BUILD_DIR)/,$(OBJ_FILES))
	mkdir -p $(dir $@)
	ar rcs $(BUILD_DIR)/$(NAME) $(addprefix $(BUILD_DIR)/,$(OBJ_FILES))

$(addprefix $(BUILD_DIR)/,$(OBJ_FILES)): $(addprefix $(SRC_DIR)/,$(SRC_FILES))
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean: 
	rm -f $(BUILD_DIR)/*.o

fclean:
	rm -rf $(BUILD_DIR)

re: fclean $(BUILD_DIR)/$(NAME)

install: $(BUILD_DIR)/$(NAME) clean
	install -D -m 644 $(BUILD_DIR)/$(NAME) $(DESTDIR)$(PREFIX)/lib
	install -D -m 644 $(addprefix $(SRC_DIR)/,$(H_FILES)) $(DESTDIR)$(PREFIX)/include

.PHONY: all clean fclean re install