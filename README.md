# Docker for [ptool](https://github.com/sagan/ptool)

## Instruction

### `./config/ptool.toml`

Refer to [example](https://github.com/sagan/ptool/blob/master/config/ptool.example.toml)

### `./config/brush.sh`

```bash
#!/bin/bash

# Example
ptool brush debian mteam --config /config/ptool.toml
```

### `docker-compose.yaml`

```yaml
services:
  ptool:
    image: ghcr.io/apocalypsor/ptool:latest
    container_name: ptool
    volumes:
      - ./config:/config
    environment:
      - TZ=America/New_York
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```
