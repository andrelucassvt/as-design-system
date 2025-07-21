#!/bin/bash

# Script para formatar código Dart com quebras de linha após vírgulas
# Este script aplica o dart format com configurações específicas

echo "Formatando código Dart..."

# Aplica o dart format em todos os arquivos .dart
find . -name "*.dart" -not -path "./build/*" -not -path "./.dart_tool/*" | while read file; do
    echo "Formatando: $file"
    dart format --line-length=80 --set-exit-if-changed "$file"
done

echo "Formatação concluída!"
