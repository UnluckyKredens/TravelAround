# TravelAround

TravelAround to aplikacja napisana w **Swift**, która umożliwia użytkownikom wyszukiwanie najlepszych atrakcji turystycznych i planów podróży przy użyciu **ChatGPT**. Dzięki integracji z API OpenAI, aplikacja generuje spersonalizowane rekomendacje na podstawie podanych przez użytkownika parametrów, takich jak lokalizacja początkowa, miejsce docelowe i budżet.

![image](https://github.com/user-attachments/assets/d02db65d-5fba-497f-89cd-aa1c98520937)


---

## 📱 Funkcjonalności

1. **Wyszukiwanie atrakcji turystycznych**:
   - Użytkownik podaje miejsce początkowe, miejsce docelowe oraz budżet.
   - ChatGPT generuje szczegółowy plan podróży, w tym atrakcje turystyczne i oszacowane koszty.

2. **Interfejs przyjazny użytkownikowi**:
   - Minimalistyczny design z prostym polem tekstowym do wprowadzania danych.
   - Rezultaty wyświetlane w formie tekstu i obrazów.

3. **Dynamiczne dostosowanie treści**:
   - Plany podróży są generowane na podstawie unikalnych preferencji użytkownika. //może kiedys

---

## ⚙️ Wymagania

- **iOS**: 15.0 lub nowszy.
- **Xcode**: 14.0 lub nowszy.
- **Konto OpenAI**: Aktywny klucz API.

---
### 🔧 Instalacja

1. Sklonuj repozytorium
   ```bash
   git clone https://github.com/UnluckyKredens/TravelAround.git
   cd TravelAround
   ```
2. Otwórz projekt w Xcode
   - Znajdź plik GPTService.swift
   - Uzupełnij linijke ```private let apiKey = "KEY_TO_OPENAI_API"``` zastępując swoim kluczem API który dostaniesz ze strony https://platform.openai.com/
3. Uruchom aplikacje z poziomu Xcode

---


