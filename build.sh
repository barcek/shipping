#!/bin/sh

set -eu

arg_base_tag="BASE_TAG"
arg_tool_vsn="TOOL_VSN"

# utils

log() {
  echo "[$0] $1" >&2
}
err() {
  log "Error: $1"
  exit 1
}
arg_parse() {
  grep -oP "(?<=^ARG $2=).*$" "./$1/Dockerfile" | sed 's/:\([[:digit:]]\)/\1/' | tr ":/" "-"
}

# input

tool_name="$1"
[ ! -d "$tool_name" ] && err "no directory for tool name '$tool_name'"

# parse

log "Parsing $tool_name Dockerfile for args..."

base_tag="$(arg_parse $tool_name ${arg_base_tag})"
tool_vsn="$(arg_parse $tool_name ${arg_tool_vsn})"
[ -z "$base_tag" ] && err "unable to parse arg '$arg_base_tag' from Dockerfile"
[ -z "$tool_vsn" ] && err "unable to parse arg '$arg_tool_vsn' from Dockerfile"

tag="$tool_name:$tool_vsn-$base_tag"

# build

log "Building image '$tag'..."

docker build --tag "$tag" "./$tool_name"
