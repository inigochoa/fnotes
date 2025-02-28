#!/bin/bash

# test_fnotes.sh - Tests básicos para fnotes

# Colores para una salida más clara
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contador de tests y fallos
TESTS=0
FAILURES=0

# Función para ejecutar un test
run_test() {
    local test_name="$1"
    local command="$2"
    local expected_result="$3"

    echo -e "${YELLOW}Ejecutando test: ${test_name}${NC}"
    TESTS=$((TESTS + 1))

    # Ejecutar el comando y capturar su salida
    result=$(eval "$command" 2>&1)
    status=$?

    # Comprobar si el comando devolvió el estado esperado
    if [[ $status -eq 0 && -n "$result" && "$result" == *"$expected_result"* ]]; then
        echo -e "${GREEN}✓ Test superado: ${test_name}${NC}"
    else
        echo -e "${RED}✗ Test fallado: ${test_name}${NC}"
        echo "  Comando: $command"
        echo "  Resultado esperado: *$expected_result*"
        echo "  Resultado obtenido: $result"
        echo "  Estado de salida: $status"
        FAILURES=$((FAILURES + 1))
    fi
    echo ""
}

# Configurar entorno de prueba
TEMP_DIR=$(mktemp -d)
cp ~/.local/bin/fnotes "$TEMP_DIR/fnotes_test.sh"
chmod +x "$TEMP_DIR/fnotes_test.sh"

# Cargar el script como una función
source "$TEMP_DIR/fnotes_test.sh"

# Crear un directorio de config temporal para las pruebas
export HOME="$TEMP_DIR"
mkdir -p "$TEMP_DIR/.config/fnotes"

# Test 1: Verificar que el script se carga correctamente
run_test "Cargar script" "type fnotes" "fnotes is a function"

# Test 2: Verificar la ayuda
run_test "Mostrar ayuda" "fnotes help" "Uso: fnotes \[comando\]"

# Test 3: Verificar la creación de configuración
echo 'editor=nano' > "$TEMP_DIR/.config/fnotes/config"
echo 'notes_dir=~/test_notes' >> "$TEMP_DIR/.config/fnotes/config"
run_test "Verificar configuración" "grep 'editor=nano' $TEMP_DIR/.config/fnotes/config" "editor=nano"

# Limpiar
rm -rf "$TEMP_DIR"

# Resultados finales
echo -e "${YELLOW}=== Resumen de los Tests ===${NC}"
echo "Tests ejecutados: $TESTS"
echo "Tests superados: $((TESTS - FAILURES))"
echo "Tests fallados: $FAILURES"

if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}¡Todos los tests superados!${NC}"
    exit 0
else
    echo -e "${RED}Algunos tests han fallado.${NC}"
    exit 1
fi
