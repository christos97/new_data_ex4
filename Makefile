SNIPER_BASE_DIR ?= /home/giorgosskourtsidis/sniper-7.3
SNIPER_INCLUDE_DIR = $(SNIPER_BASE_DIR)/include

CC = gcc

TARGET = DTTAS_TS

LFLAG ?= -DTTAS_TS ## or -DTAS_CAS or -DTAS_TS or -DTTAS_CAS or DTTAS_TS or -DMUTEX
IMPLFLAG ?= -DREAL ## or -DREAL 

CFLAGS ?= -Wall -O0 -lpthread $(IMPLFLAG) $(LFLAG) #-DDEBUG
CFLAGS += -I$(SNIPER_INCLUDE_DIR)
CFLAGS += -Wno-unused-variable

$(TARGET): locks_scalability.c
	$(CC) $^ $(HOOKS_LDFLAGS) $(CFLAGS) -o $@

clean :
	rm -f $(TARGET)
