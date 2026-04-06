WARP Manager v2.3

Универсальный менеджер Cloudflare WARP для **3X-UI** и **AmneziaWG** с автоматическим определением режима.

Возможности

- Авто-определение режима — 3X-UI, AmneziaWG, оба или standalone
- Cloudflare WARP — установка и управление через warp-cli
- Telegram Bot — удалённое управление через Telegram
- Смена IP — автоматическая смена WARP IP
- Мониторинг — системная информация в Telegram
- Настройка порта — гибкая настройка SOCKS5 порта
- Полное удаление — чистка всех следов с сервера

Установка

```bash
curl -fsSL https://raw.githubusercontent.com/h4rd1ns0mn14/WARP-3X/main/install.sh | sudo bash
```

Запуск

```bash
warp
# или
warp-manager
```

Режимы работы

| Режим | Описание |
|-------|----------|
| `3xui` | WARP через SOCKS5 прокси для панели 3X-UI |
| `amnezia` | WARP через Docker контейнер AmneziaWG |
| `both` | Оба режима одновременно |
| `standalone` | Только WARP без панелей |

Структура

```
├── gowarp          # Основной скрипт (bash)
├── install.sh      # Установочный скрипт
└── README.md       # Документация
```

Требования

- Ubuntu / Debian
- Root доступ
- Docker (для AmneziaWG режима)
- 3X-UI (для 3X-UI режима)

Лицензия

MIT
