CXX = g++

CXXFLAGS = -Wall -Wextra -Werror

SRC_DIR = ./src
BUILD_DIR = ./build

SRC_FILES = $(shell find $(SRC_DIR) -name '*.cpp')
H_FILES = $(shell find $(SRC_DIR) -name '*.h')
OBJ_FILES = $(subst $(SRC_DIR),$(BUILD_DIR),$(SRC_FILES:%.cpp=%.o))

NAME = libmfrc522.a

# Set output directory
ifeq ($(PREFIX),)
	PREFIX = /usr/local
endif

all: $(BUILD_DIR)/$(NAME) clean

$(BUILD_DIR)/$(NAME): $(OBJ_FILES)
	mkdir -p $(dir $@)
	ar rcs $(BUILD_DIR)/$(NAME) $(OBJ_FILES)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean: 
	rm -f $(BUILD_DIR)/*.o

fclean:
	rm -rf $(BUILD_DIR)

re: fclean $(BUILD_DIR)/$(NAME)

install: $(BUILD_DIR)/$(NAME) clean
	install -D -m 644 $(BUILD_DIR)/$(NAME) $(DESTDIR)$(PREFIX)/lib
	install -D -m 644 $(H_FILES) $(DESTDIR)$(PREFIX)/include

.PHONY: all clean fclean re install