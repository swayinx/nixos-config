#!/usr/bin/env bash
FILE="$1"
FILENAME=$(basename "$FILE")
EXTENSION="${FILENAME##*.}"
BASENAME="${FILENAME%.*}"
DIR=$(dirname "$FILE")
cd "$DIR"

echo "Ejecutando: $FILENAME"

# Función para compilar según el lenguaje
compile_and_check() {
    case "$EXTENSION" in
        c)
            echo "Compilando C..."
            gcc -Wall -Wextra -g "$FILENAME" -o "$BASENAME" 2>&1
            return $?
            ;;
        cpp|cc|cxx)
            echo "Compilando C++..."
            g++ -Wall -Wextra -g "$FILENAME" -o "$BASENAME" 2>&1
            return $?
            ;;
        java)
            echo "Compilando Java..."
            javac "$FILENAME" 2>&1
            return $?
            ;;
        rs)
            echo "Compilando Rust..."
            rustc "$FILENAME" -o "$BASENAME" 2>&1
            return $?
            ;;
        py|js|sh|bash)
            return 0
            ;;
        *)
            echo "✗ Tipo no soportado: .$EXTENSION"
            return 1
            ;;
    esac
}

# Compilar si es necesario
compile_and_check
if [ $? -ne 0 ]; then
    echo ""
    echo "✗ Error en compilación"
    echo ""
    echo "Enter para cerrar..."
    read
    exit 1
fi

echo "✓ Listo para popear"
echo ""

# Loop para pedir archivos de input
while true; do
    echo -n "Archivo de input (o Ctrl+C para salir): "
    read INPUT_FILE
    
    if [ -f "$INPUT_FILE" ]; then
        echo ""
        echo "Ejecutando con $INPUT_FILE:"
        echo "========================================"
        
        case "$EXTENSION" in
            c|cpp|cc|cxx|rs)
                ./"$BASENAME" < "$INPUT_FILE"
                ;;
            java)
                java "$BASENAME" < "$INPUT_FILE"
                ;;
            py)
                python "$FILENAME" < "$INPUT_FILE"
                ;;
            js)
                node "$FILENAME" < "$INPUT_FILE"
                ;;
            sh|bash)
                bash "$FILENAME" < "$INPUT_FILE"
                ;;
        esac
        
        echo "========================================"
        echo ""
    else
        echo "✗ Archivo no encontrado: $INPUT_FILE"
        echo ""
    fi
done
