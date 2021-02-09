#!/usr/bin/env bash

## Connect a remote shell to a running node

set -e

require_cookie
require_live_node

# modified release_remote_ctl fn
release_remote_ctl_no_crash() {
    require_cookie

    command="$1"; shift
    name="${PEERNAME:-$NAME}"
    elixir -e "Distillery.Releases.Runtime.Control.main" \
           --erl "-kernel logger_level none" \
           --logger-sasl-reports false \
           -- \
           "$command" \
           --name="$name" \
           --cookie="$COOKIE" \
           "$@"
}

# Generate a unique id used to allow multiple remsh to the same node
# transparently
id="remsh$(gen_id)-${NAME}"

# Get the node's ticktime so that we use the same thing.
TICKTIME="$(release_remote_ctl_no_crash rpc ':net_kernel.get_net_ticktime()')"

iex --erl "-hidden -kernel logger_level none net_ticktime $TICKTIME" \
    --logger-sasl-reports false \
    -"$NAME_TYPE" "$id" \
    --cookie "$COOKIE" \
    --remsh "$NAME"
