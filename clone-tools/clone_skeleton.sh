#!/bin/bash

# === 🔐 Verificar conexión SSH con GitHub ===
echo "🔐 Verificando conexión SSH con GitHub..."

ssh -T git@github.com -o BatchMode=yes -o ConnectTimeout=5 2>&1 | grep -q "successfully authenticated"

if [ $? -ne 0 ]; then
  echo "❌ ERROR: No se pudo autenticar con GitHub por SSH."
  echo "   Asegúrate de tener una clave SSH configurada y autorizada en:"
  echo "   👉 https://github.com/settings/keys"
  echo ""
  echo "   Puedes probarlo manualmente con:"
  echo "   ssh -T git@github.com"
  exit 1
fi

echo "✅ Autenticación SSH con GitHub verificada correctamente."

# === 🔧 CONFIGURACIÓN GLOBAL ===
ORG="${1:-Chic-Base}"              # Si no se pasa argumento, se usa Chic-Base
APP_FOLDER="./$ORG-skeleton"       # Carpeta de destino

# === 📁 Crear carpeta destino ===
echo ""
echo "📁 Creando carpeta del proyecto: $APP_FOLDER"
mkdir -p "$APP_FOLDER"
cd "$APP_FOLDER" || exit 1

# === 🔍 Función para verificar acceso a un repo Git por SSH ===
check_repo_access() {
  local repo="$1"
  if ! git ls-remote "$repo" &>/dev/null; then
    echo "❌ ERROR: No tienes acceso al repo: $repo"
    echo "   👉 Solicita acceso en: https://github.com/${repo#git@github.com:}"
    echo ""
    return 1
  fi
  return 0
}

# === 📦 Clonar skeleton desde ORG ===
REPO="git@github.com:$ORG/skeleton.git"
echo "🔍 Verificando acceso a $REPO..."
if check_repo_access "$REPO"; then
  echo "🔽 Clonando skeleton desde $ORG..."
  git clone "$REPO"
else
  echo "⚠️  Saltando skeleton por falta de permisos."
fi

# === 📦 Clonar metadata desde ORG ===
REPO="git@github.com:$ORG/metadata.git"
echo "🔍 Verificando acceso a $REPO..."
if check_repo_access "$REPO"; then
  echo "🔽 Clonando metadata desde $ORG..."
  git clone "$REPO"
else
  echo "⚠️  Saltando metadata por falta de permisos."
fi

# === 🔁 Clonar sharedkernel desde Chic-Base ===
REPO="git@github.com:Chic-Base/sharedkernel.git"
echo "🔍 Verificando acceso a $REPO..."
if check_repo_access "$REPO"; then
  echo "🔽 Clonando sharedkernel desde Chic-Base..."
  git clone "$REPO"
else
  echo "⚠️  Saltando sharedkernel por falta de permisos."
fi

# === 🧠 Crear archivo app.code-workspace ===
WORKSPACE_FILE="app.code-workspace"
echo ""
echo "📝 Generando $WORKSPACE_FILE..."

cat > "$WORKSPACE_FILE" <<EOL
{
  "folders": [
    { "path": "skeleton" },
    { "path": "sharedkernel" },
    { "path": "metadata" }
  ],
  "settings": {}
}
EOL

# === 🌈 Mostrar resumen final bonito ===
echo ""
echo "🎉 Skeleton-only '$ORG' clonado con éxito. Estructura:"
echo ""
printf "📁 %-15s 🔗 %-40s\n" "Carpeta" "Remote"
echo "────────────────────────────────────────────────────────────────────────────"

printf "🟢 %-15s git@github.com:%s/skeleton.git\n" "skeleton" "$ORG"
printf "🟢 %-15s git@github.com:%s/metadata.git\n" "metadata" "$ORG"
printf "🔵 %-15s git@github.com:Chic-Base/sharedkernel.git\n" "sharedkernel"

echo ""
echo "🚀 Ábrelo en VS Code con:"
echo "   code $WORKSPACE_FILE"
echo ""
