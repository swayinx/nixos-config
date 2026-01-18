#!/usr/bin/env bash
FILE="$1"
FILENAME=$(basename "$FILE")
EXTENSION="${FILENAME##*.}"
BASENAME="${FILENAME%.*}"
DIR=$(dirname "$FILE")
cd "$DIR"

echo "Ejecutando: $FILENAME"

case "$EXTENSION" in
    c)
        echo "Compilando C..."
        gcc -Wall -Wextra -g "$FILENAME" -o "$BASENAME" 2>&1
        if [ $? -eq 0 ]; then
            echo "✓ Compilación exitosa"
            echo "Ejecutando:"
            echo ""
            ./"$BASENAME"
        else
            echo ""
            echo "✗ Error en compilación"
        fi
        ;;
    cpp|cc|cxx)
        echo "Compilando C++..."
        g++ -Wall -Wextra -g "$FILENAME" -o "$BASENAME" 2>&1
        if [ $? -eq 0 ]; then
            echo "✓ Compilación exitosa"
            echo "Ejecutando:"
            echo ""
            ./"$BASENAME"
        else
            echo ""
            echo "✗ Error en compilación"
        fi
        ;;
    java)
        echo "Compilando Java..."
        javac "$FILENAME" 2>&1
        if [ $? -eq 0 ]; then
            echo "✓ Compilación exitosa"
            echo "Ejecutando:"
            echo ""
            java "$BASENAME"
        else
            echo ""
            echo "✗ Error en compilación"
        fi
        ;;
    py)
        echo "Ejecutando Python..."
        python "$FILENAME"
        ;;
    rs)
        echo "Compilando Rust..."
        rustc "$FILENAME" -o "$BASENAME" 2>&1
        if [ $? -eq 0 ]; then
            echo "✓ Compilación exitosa"
            echo "Ejecutando:"
            echo ""
            ./"$BASENAME"
        else
            echo ""
            echo "✗ Error en compilación"
        fi
        ;;
    sh|bash)
        echo "Ejecutando bash..."
        bash "$FILENAME"
        ;;
    js)
        echo "Ejecutando Node..."
        node "$FILENAME"
        ;;
    *)
        echo "✗ Tipo no soportado: .$EXTENSION"
        ;;
esac

echo ""
echo "Enter para cerrar..."
read
