#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for evod"

  set -- evod "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "evod" ]; then
  mkdir -p "$COINEVO_DATA"
  chmod 770 "$COINEVO_DATA" || echo "Could notchmod $COINEVO_DATA (may not have appropriate permissions)"
  chown -R evo "$COINEVO_DATA" || echo "Could notchown $COINEVO_DATA (may not have appropriate permissions)"

  echo "$0: setting data directory to $COINEVO_DATA"

  set -- "$@" -datadir="$COINEVO_DATA"
fi

if [ "$(id -u)" = "0" ] && ([ "$1" = "evod" ] || [ "$1" = "evo-cli" ] || [ "$1" = "evo-tx" ]); then
  set -- gosu evo "$@"
fi

exec "$@"
