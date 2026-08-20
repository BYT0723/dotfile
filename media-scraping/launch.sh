#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"
COMPOSE_FILE="$SCRIPT_DIR/docker-compose.yml"

HUB_SERVICES=(metatube jellyfin)
SCRAPER_SERVICES=(sonarr radarr prowlarr bazarr qbittorrent flaresolverr)
ALL_SERVICES=("${HUB_SERVICES[@]}" "${SCRAPER_SERVICES[@]}")

usage() {
	cat <<EOF
Usage: $(basename "$0") <command> <target>

Commands:
  up      Start services
  down    Stop services
  status  Show service status

Targets:
  hub      Hub services (${HUB_SERVICES[*]})
  scraper  Scraper services (${SCRAPER_SERVICES[*]})
  all      All services
EOF
	exit 1
}

[[ $# -lt 2 ]] && usage

CMD="$1"
TARGET="$2"

case "$CMD" in
	up|down|status)
		;;
	*)
		echo "Error: unknown command '$CMD'"
		usage
		;;
esac

case "$TARGET" in
	hub)     SRVS=("${HUB_SERVICES[@]}") ;;
	scraper) SRVS=("${SCRAPER_SERVICES[@]}") ;;
	all)     SRVS=("${ALL_SERVICES[@]}") ;;
	*)
		echo "Error: unknown target '$TARGET'"
		usage
		;;
esac

case "$CMD" in
	up)
		echo "==> Starting $TARGET services..."
		docker compose -f "$COMPOSE_FILE" up -d "${SRVS[@]}"
		;;
	down)
		echo "==> Stopping $TARGET services..."
		docker compose -f "$COMPOSE_FILE" stop "${SRVS[@]}"
		;;
	status)
		docker compose -f "$COMPOSE_FILE" ps "${SRVS[@]}"
		;;
esac
