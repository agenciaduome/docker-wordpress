#!/bin/bash
set -euo pipefail

/usr/local/bin/wp-cli.phar cli update --yes

exec "$@"
