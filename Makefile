# Makefile para compilar y enlazar archivos .asm con nasm y gcc

# Nombre del ejecutable final
EXEC = tp

# Archivos fuente y objetos
ASM_SRCS = $(wildcard *.asm)
ASM_OBJS = $(ASM_SRCS:.asm=.o)

# Flags para nasm y gcc
NASM_FLAGS = -f elf64 -g -F dwarf
GCC_FLAGS = -no-pie

# Compilador y enlazador
NASM = nasm
GCC = gcc

# Regla por defecto
all: $(EXEC)

# Regla para compilar cada archivo .asm a un objeto .o
%.o: %.asm
	$(NASM) $(NASM_FLAGS) -l $*.lst $< -o $@

# Regla para enlazar los objetos y crear el ejecutable
$(EXEC): $(ASM_OBJS)
	$(GCC) $(GCC_FLAGS) -o $@ $^

# Regla para compilar y enlazar todos los archivos .asm
test: $(ASM_SRCS)
	$(NASM) $(NASM_FLAGS) $^
	$(GCC) $(GCC_FLAGS) -o $(EXEC) $(ASM_OBJS)

# Regla de limpieza
clean:
	rm -f $(ASM_OBJS) $(EXEC) *.lst

.PHONY: all test clean
