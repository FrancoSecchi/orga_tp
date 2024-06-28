# Makefile para compilar y enlazar archivos .asm con nasm y gcc

# Nombre del ejecutable final
EXEC = tp

NASM = nasm
NASM_FLAGS = -f elf64

GCC = gcc
GCC_FLAGS = -no-pie

SRCS = $(wildcard *.asm)
VALIDACIONES_SRCS = $(wildcard validaciones/*.asm)
OBJS = $(SRCS:.asm=.o) $(VALIDACIONES_SRCS:.asm=.o)

all: $(EXEC)

$(EXEC): $(OBJS)
	$(GCC) $(GCC_FLAGS) -o $@ $^

%.o: %.asm
	$(NASM) $(NASM_FLAGS) $< -o $@

clean:
	rm -f $(OBJS) $(EXEC)

.PHONY: all clean
