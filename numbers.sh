#!/bin/bash

# Путь к папке с аудиофайлами
audio_folder="/Users/azabolotskikh/Downloads/Кинг Стивен - Тёмная Башня (Игорь Князев)/2   Извлечение троих"

# Переход в папку с аудиофайлами
cd "$audio_folder"

# Цикл для обработки всех файлов в папке
for file in *.mp3; do

  # Извлечение номера из начала имени файла с помощью регулярного выражения
  if [[ "$file" =~ ^0*([4-9][6-9]|[1-2][0-4][0-5]) ]]; then
    extracted_number="${BASH_REMATCH[1]}"
    
    # Вычитание 45 из извлеченного номера
    track_number=$((extracted_number - 45))
    
    # Вывод номера дорожки (для проверки)
    echo "Исходный номер: $extracted_number, Новый номер: $track_number"
  fi
  
  # Использование eyeD3 для установки номера дорожки в метаданных
  eyeD3 --track="$track_number" "$file"
done

echo "Готово!"