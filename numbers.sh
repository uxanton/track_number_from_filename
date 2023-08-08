#!/bin/bash

# Путь к папке с аудиофайлами
audio_folder="/Users/azabolotskikh/Downloads/Кинг Стивен - Тёмная Башня (Игорь Князев)/3   Бесплодные земли"

# Переход в папку с аудиофайлами
cd "$audio_folder"

# Инициализация переменной для хранения сдвига
shift=0

# Получение номера первой композиции
first_track_number=0

# Цикл для обработки всех файлов в папке
for file in *.mp3; do

  # Извлечение номера из начала имени файла с помощью регулярного выражения
  if [[ "$file" =~ ([1-9][0-9]*)[^0-9] ]]; then
    extracted_number="${BASH_REMATCH[1]}"

    # Если это первая композиция, запомним её номер
    if [ $first_track_number -eq 0 ]; then
      first_track_number=$extracted_number
    fi
    
    # Убрать ведущие нули
    stripped_number="${extracted_number##+(0)}"

    # Вычисление сдвига на основе номера первой композиции
    shift=$((first_track_number - 1))
    
    # Вычисление номера композиции с учетом сдвига
    track_number=$((stripped_number - shift))
    
    # Вывод номера дорожки (для проверки)
    echo "Исходный номер: $extracted_number, Новый номер: $track_number, Сдвиг: $shift"

    # Обновление сдвига, если это первая композиция

  fi
  
  # Использование eyeD3 для установки номера дорожки в метаданных
  eyeD3 --track="$track_number" "$file"
done

echo "Готово!"