####################################################
# Linux build

###############
# Targets folders

SUBTARGETSC:=src
SUBTARGETSCPP:=src/platforms/linux

###############
# Select all files in source folders

SOURCEFOLDER:=src
SOURCESC:=$(wildcard $(addsuffix /*.c,$(SUBTARGETSC)))
SOURCESCPP:=$(wildcard $(addsuffix /*.cpp,$(SUBTARGETSCPP)))
SOURCESC:=$(SOURCESC:$(SOURCEFOLDER)/%=%)
SOURCESCPP:=$(SOURCESCPP:$(SOURCEFOLDER)/%=%)

###############
# General info

BINFOLDER:=bin/linux
BUILDFOLDER:=build/linux

CCPP:=g++
CC:=gcc
LD:=$(CCPP)
CFLAGS:=-std=gnu11 -Wall -Wextra -Werror
CPPFLAGS:=-std=c++17 -Wall -Wextra -Werror
LDFLAGS:=-lsfml-graphics -lsfml-window -lsfml-system -lstdc++
DEPFLAGS:=-MMD
LIBDIR:=
INCLUDEC:=
INCLUDECPP:=
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

LIBDIR+=$(if $(SFMLPATH),$(SFMLLIB),)
INCLUDECPP+=$(if $(SFMLPATH),$(SFMLINCLUDE),)

###############
# Targets

build: $(SOURCEFOLDER)/$(SOURCESC) $(SOURCEFOLDER)/$(SOURCESCPP) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTSC) $(OBJECTSCPP)
	@mkdir -p $(@D)
	$(LD) -o $@ $(OBJECTSC) $(OBJECTSCPP) $(LIBDIR) $(LDFLAGS)

$(BUILDFOLDER)/%.o: $(SOURCEFOLDER)/%.c $(BUILDFOLDER)/%.d
	@mkdir -p $(@D)
	$(CC) $(INCLUDEC) $(CFLAGS) $(DEPFLAGS) -c $< -o $@

$(BUILDFOLDER)/%.o: $(SOURCEFOLDER)/%.cpp  $(BUILDFOLDER)/%.d
	@mkdir -p $(@D)
	$(CCPP) $(INCLUDECPP) $(CPPFLAGS) $(DEPFLAGS) -c $< -o $@

###############
# Dependencies

DEPFILES:=$(SOURCESC:%.c=$(BUILDFOLDER)/%.d)
DEPFILES+=$(SOURCESCPP:%.cpp=$(BUILDFOLDER)/%.d)
$(DEPFILES):

include $(wildcard	$(DEPFILES))