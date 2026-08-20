#!/bin/bash
set -euo pipefail

COMPOSE_FILE="$(dirname "$0")/docker-compose.yml"

if [[ ! -f "$COMPOSE_FILE" ]]; then
	echo "Error: $COMPOSE_FILE not found"
	exit 1
fi

parse_services() {
	docker compose -f "$COMPOSE_FILE" config --format json 2>/dev/null | python3 <(
		cat <<'PYEOF'
import sys, json

args = set(sys.argv[1:])
conf = json.load(sys.stdin)

all_ports = {}
for name, svc in conf.get("services", {}).items():
    if name == "metatube":
        continue
    for p in svc.get("ports", []):
        pub = p.get("published")
        if pub:
            all_ports[name] = f"http://localhost:{pub}"
            break

if args:
    for name in sys.argv[1:]:
        if name in all_ports:
            print(f"{name} {all_ports[name]}")
else:
    order = ["jellyfin", "prowlarr", "radarr", "sonarr", "bazarr", "qbittorrent"]
    for name in order:
        if name in all_ports:
            print(f"{name} {all_ports[name]}")
PYEOF
	) "$@"
}

open_service() {
	local name="$1"
	local url="$2"
	echo "Opening $name -> $url"
	xdg-open "$url" &>/dev/null
}

if [[ $# -eq 0 ]]; then
	while IFS=" " read -r name url; do
		open_service "$name" "$url"
	done < <(parse_services)
else
	declare -A mapping
	while IFS=" " read -r name url; do
		mapping[$name]="$url"
	done < <(parse_services "$@")

	for name in "$@"; do
		if [[ -z "${mapping[$name]:-}" ]]; then
			echo "Unknown service: $name"
			echo "Available: ${!mapping[*]}"
			exit 1
		fi
		open_service "$name" "${mapping[$name]}"
	done
fi
