#!/bin/bash

# update.sh - Script para actualizar fnotes a la última versión

# Colors for a clearer output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display error messages and exit
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Welcome message
echo -e "${GREEN}=== Updating fnotes ===${NC}"

# URL del script fnotes (reemplaza con la URL real)
FNOTES_URL="https://raw.githubusercontent.com/inigochoa/fnotes/main/src/fnotes.sh"

# Check if fnotes is installed
if [ ! -f ~/.local/bin/fnotes ]; then
    error_exit "fnotes does not seem to be installed. Please run the installation script first."
fi

# Create backup
echo "Creating backup of current version..."
cp ~/.local/bin/fnotes ~/.local/bin/fnotes.backup

# Descargar la última versión
echo "Descargando la última versión de fnotes..."
if ! curl -sSL "$FNOTES_URL" -o ~/.local/bin/fnotes.new; then
    echo "Error al descargar. Restaurando la versión anterior..."
    mv ~/.local/bin/fnotes.backup ~/.local/bin/fnotes
    error_exit "No se pudo descargar la última versión. Comprueba tu conexión a Internet."
fi

# Verificar que la descarga fue exitosa
if [ ! -s ~/.local/bin/fnotes.new ]; then
    echo "La descarga falló o el archivo está vacío. Restaurando la versión anterior..."
    mv ~/.local/bin/fnotes.backup ~/.local/bin/fnotes
    error_exit "La descarga de fnotes falló o el archivo está vacío."
fi

# Reemplazar la versión actual con la nueva
mv ~/.local/bin/fnotes.new ~/.local/bin/fnotes
chmod +x ~/.local/bin/fnotes

echo -e "${GREEN}¡fnotes ha sido actualizado correctamente!${NC}"
echo ""
echo "Para utilizar la nueva versión, reinicia tu terminal o ejecuta:"
echo -e "${YELLOW}source ~/.local/bin/fnotes${NC}"
echo ""
echo "Si encuentras algún problema con la nueva versión, puedes restaurar la versión anterior con:"
echo -e "${YELLOW}mv ~/.local/bin/fnotes.backup ~/.local/bin/fnotes${NC}"
