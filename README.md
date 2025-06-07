# Cloud_13

W ramach zadania 13 zmodyfikowałem plik `docker-compose.yml`, aby wszystkie dane wrażliwe były przechowywane za pomocą mechanizmu Docker Secrets.

## Co zrobiłem

- Utworzyłem katalog `secrets/`, a w nim trzy pliki:
  - `db_root_password` – zawiera hasło roota do bazy danych,
  - `db_user` – zawiera nazwę użytkownika bazy danych,
  - `db_password` – zawiera hasło tego użytkownika.

- Zastąpiłem dotychczasowe zmienne środowiskowe w usłudze `db` na ich wersje `*_FILE`, które odwołują się do plików z sekretami:
  ```yaml
  environment:
    MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
    MYSQL_USER_FILE: /run/secrets/db_user
    MYSQL_PASSWORD_FILE: /run/secrets/db_password

# Cloud_14

W ramach zadania 14 zmodyfikowałem konfigurację Docker Compose, dzieląc ją zgodnie z mechanizmem `merge` na plik bazowy oraz plik override.

## Co zrobiłem

- Rozdzieliłem pierwotny plik `docker-compose.yml` na dwa pliki:
  - `docker-compose.yml` – plik bazowy,
  - `docker-compose.override.yml` – plik środowiskowy.

### Plik `docker-compose.yml` (bazowy)

- Umieściłem w nim tylko te elementy, które są wspólne dla wszystkich środowisk (development, testowe, produkcyjne).
- Zostawiłem definicje podstawowych serwisów `db`, `backend`, `web`.
- Dodałem tylko te wolumeny i zależności (`depends_on`), które są niezbędne do uruchomienia aplikacji niezależnie od środowiska.
- Usunąłem z niego wszystkie porty, dane logowania i sekcje `secrets`.

### Plik `docker-compose.override.yml`

- Dodałem tu konfigurację zależną od środowiska, np.:
  - przekierowanie portów (`3306:3306`, `80:80`, `8080:80`),
  - odczyt danych wrażliwych z plików przez Docker secrets (`MYSQL_ROOT_PASSWORD_FILE`, itp.),
  - definicję sekcji `secrets` z lokalizacjami plików (`secrets/db_user`, `secrets/db_password`, itd.),
  - dodatkową usługę `phpmyadmin`, która pozwala testować bazę z przeglądarki.

Dzięki temu podziałowi mogę teraz łatwo:
- rozwijać aplikację lokalnie z pełnym dostępem do phpMyAdmin,
- przełączać konfigurację na środowisko produkcyjne bez ingerencji w plik bazowy,
- zarządzać środowiskami w sposób zgodny z dobrymi praktykami CI/CD oraz modelem 12 Factor App.

## Komendy których użyłem

- `docker-compose down -v` – zatrzymuje i usuwa wszystkie kontenery oraz wolumeny.
- `docker-compose up -d` – uruchamia wszystkie kontenery w tle.
- `docker-compose ps` – sprawdza status uruchomionych kontenerów.

## Działanie prezentują screeny

- Można je znaleźć w w main folderze projektowym, w podkatalogu `screenshots`.