# El Zorro y Las Ocas - Juego en Assembler Intel 86_64

## Descripción del Proyecto

Este proyecto implementa el juego "El Zorro y Las Ocas" utilizando assembler Intel 86_64. El juego se desarrolla en un tablero con treinta y tres hendiduras dispuestas en forma de cruz. Un jugador controla una ficha, el zorro, mientras que el otro controla diecisiete fichas, las ocas. El objetivo del zorro es capturar al menos doce ocas, mientras que las ocas intentan evitarlo.

## Requisitos del Juego

### Requerimiento 1

- Implementar una partida para 2 jugadores, con visualización clara del tablero actualizado luego de cada movimiento.
- Permitir interrumpir la partida en cualquier momento.
- Identificar automáticamente cuando el juego llega a su fin (el zorro captura 12 ocas o queda acorralado).

### Requerimiento 2

- Permitir guardar y recuperar partidas.
- Mostrar estadísticas de movimiento del zorro al finalizar el juego.

### Requerimiento 3

- Ofrecer personalización de la partida:
  - Símbolo del zorro y de las ocas.
  - Orientación del tablero.
  - Configuración por defecto según la imagen proporcionada.

## Compilación e Instalación

### Prerrequisitos

Asegúrate de tener instalado un ensamblador compatible con Intel 86_64, como `nasm`, y un enlazador como `ld`.

### Instrucciones de Compilación

Para primero compilar los archivo `asm` hay que ejecutar 
```bash
    make 
```

Con eso se te va a generar un ejecutable llamado `tp`, para poder correr el programa hay que hacer: 

```bash
    ./tp
```

Para borrar los ejecutables se ejecuta: 
```bash
    make clean
```