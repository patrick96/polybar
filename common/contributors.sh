#!/usr/bin/env bash
# Writes a markdown table with all non-main contributors
# Requires curl and js52

# Github OAUTH token. Please set this when generating the list for production
# otherwise you will likely reach the query limit
OAUTH_TOKEN=""
cells_per_line=6
output="CONTRIBUTORS.md"

CURL=(curl -sS)

if [ -n "$OAUTH_TOKEN" ]; then
  CURL+=(-H "Authorization: token ${OAUTH_TOKEN}")
fi

function strip_quotes() {
  echo "$@" | sed -r 's/^"(.*)"$/\1/'
}

url="https://api.github.com/repos/jaagr/polybar/contributors?per_page=100"
data=$("${CURL[@]}" "$url")

contributors=$(js52 -f <(echo "var data = $data;") -f "$(dirname "$(realpath "$0")")/generate_contributors.js")

sed -i '/<!-- CONTRIBUTORS START -->/q' "$output" >/dev/null

{
  separator=$(yes "| :---: " | head -n $cells_per_line | tr -d '\n' && echo "|")

  i=1
  while read -r contr; do
    nick=$(echo "$contr" | cut -f 1)
    html_url=$(echo "$contr" | cut -f 2)
    commits=$(echo "$contr" | cut -f 3)
    url=$(echo "$contr" | cut -f 4)

    name="**@$nick**"

    user_data=$("${CURL[@]}" "$url" 2>/dev/null)

    real_name=$(jq ".name" <(echo "$user_data"))
    avatar_url=$(jq ".avatar_url" <(echo "$user_data"))

    if [ "$real_name" != "null" ]; then
      real_name=$(strip_quotes "$real_name")
      name="$real_name<br />$name"
    fi

    echo -n "| [<img src=$avatar_url width=\"100px\" /><br /><sub>$name ($commits)</sub>]($html_url) "

    if [ $((i % cells_per_line)) -eq 0 ]; then
      echo "|"

      if [ $i -eq $cells_per_line ]; then
        echo "$separator"
      fi
    fi

    i=$((i + 1))
  done <<< "$contributors"
} | tee -a "$output"
