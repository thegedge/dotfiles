#!/usr/bin/env awk -f
# Parses `git blame -p` to produce a Github-like blame view, where consecutive lines affected
# by the same commit are collapsed.
#
# Doesn't work with OSX awk if there are accents and other interesting UTF-8 characters.
# Recommend using GNU awk.

BEGIN {
  # ensure lines is an array
  lines[0] = "test";
  delete lines[0];

  # First column width
  col_size = 32;
  if(ENVIRON["COLUMN_SIZE"]) {
    col_size = ENVIRON["COLUMN_SIZE"];
  }

  if(ENVIRON["COLORED"] != "0") {
    reset = "\033[0m";
    red = "\033[0;31m";
    green = "\033[0;32m";
    yellow = "\033[0;33m";
    blue = "\033[0;34m";
    gray = "\033[0;90m";
  }
}

$1 == "author" { author = $2 " " $3 }
$1 == "summary" { summary[sha] = substr($0, length($1) + 2) }
$1 ~ /[0-9a-f]{40}/ && $1 != sha {
  dump_lines();
  sha = $1;
}

substr($0, 1, 1) == "\t" {
  lines[length(lines) + 1] = substr($0, 2);
}

END { dump_lines() }

#-----------------------------------------------------------------------
# Supporting functions
#-----------------------------------------------------------------------
function max(a, b) {
  return a > b ? a : b;
}

function dump_lines() {
  if(length(lines) > 0) {
    for(idx = 1; idx <= max(4, length(lines)); ++idx) {
      initial = substr(summary[sha], 1 + col_size*(idx - 3));
      initial_color = green;
      if(idx == 1) {
        initial = sha;
        initial_color = yellow;
      } else if(idx == 2) {
        initial = author;
        initial_color = blue;
      }

      line_str = idx <= length(lines) ? ++curent_line : "";
      printf( \
        initial_color "%-*.*s" gray " │ %4s │ " reset "%s\n", \
        col_size, col_size, initial, line_str, lines[idx] \
      );
    }
    delete lines;
  }
}
