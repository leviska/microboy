CXX=g++
CC=gcc
CFLAGS=-std=c++17 -Wall -Wextra -Werror
LDFLAGS=-lsfml-graphics -lsfml-window -lsfml-system
SOURCES=main.cpp render.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=microtetris

# for external lib
SFMLPATH=../SFML-2.5.1
SFMLLIB=-L"$(SFMLPATH)/lib"
SFMLINCLUDE=-I"$(SFMLPATH)/include"
LIBDIR=
INCLUDE=

all: build

externsfml: LIBDIR += $(SFMLLIB)
externsfml: INCLUDE += $(SFMLINCLUDE)
externsfml: build

build: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) 
	$(CC) -o $@ $(OBJECTS) $(LIBDIR) $(LDFLAGS)

.cpp.o:
	$(CC) $(INCLUDE) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(EXECUTABLE) *.o