####################################################
# Linux build

###############
# General info

BINFOLDER:=bin/linux
BUILDFOLDER:=build/linux
SOURCEFOLDER:=src

SOURCESC:=main.c
SOURCESCPP:=platforms/linux/render.cpp

CCPP:=g++
CC:=gcc
CFLAGS:=-std=gnu11 -Wall -Wextra -Werror
CPPFLAGS:=-std=c++17 -Wall -Wextra -Werror
LDFLAGS:=-lsfml-graphics -lsfml-window -lsfml-system -lstdc++
OBJECTSC:=$(addprefix $(BUILDFOLDER)/,$(patsubst %.c,%.o,$(SOURCESC)))
OBJECTSCPP:=$(addprefix $(BUILDFOLDER)/,$(patsubst %.cpp,%.o,$(SOURCESCPP)))
EXECUTABLE:=$(BINFOLDER)/microtetris

###############
# SFML location
# if your SFML library isn't in os default location
# set this path to your sfml lib
# example
#SFMLPATH:=../SFML-2.5.1
SFMLPATH:=
SFMLLIB:=-L"$(SFMLPATH)/lib"
SFMLINCLUDE:=-I"$(SFMLPATH)/include"

LIBDIR:=$(if $(SFMLPATH),$(SFMLLIB),)
INCLUDECPP:=$(if $(SFMLPATH),$(SFMLINCLUDE),)
INCLUDEC:=

all: build

build: $(SOURCEFOLDER)/$(SOURCESC) $(SOURCEFOLDER)/$(SOURCESCPP) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTSC) $(OBJECTSCPP)
	mkdir -p $(@D)
	$(CCPP) -o $@ $(OBJECTSC) $(OBJECTSCPP) $(LIBDIR) $(LDFLAGS)

$(BUILDFOLDER)/%.o: $(SOURCEFOLDER)/%.c
	mkdir -p $(@D)
	$(CC) $(INCLUDEC) $(CFLAGS) -c $< -o $@

$(BUILDFOLDER)/%.o: $(SOURCEFOLDER)/%.cpp
	mkdir -p $(@D)
	$(CCPP) $(INCLUDECPP) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILDFOLDER) $(EXECUTABLE)