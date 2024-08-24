#!/bin/bash
# Update to the latest SQLite from sqlite.org

year=2024
version=3460100

scratch_dir=$(mktemp -d /tmp/XXXXXX)
curl -L -o "$scratch_dir/sqlite.zip" "https://sqlite.org/$year/sqlite-amalgamation-$version.zip"

(cd "$scratch_dir" && unzip "sqlite.zip")
cp "$scratch_dir/sqlite-amalgamation-$version/sqlite3.c" ./Sources/CSQLite/sqlite3.c
cp "$scratch_dir/sqlite-amalgamation-$version/shell.c" ./Sources/sqlite/shell.c
cp "$scratch_dir/sqlite-amalgamation-$version/sqlite3.h" ./Sources/CSQLite/include/sqlite3.h
cp "$scratch_dir/sqlite-amalgamation-$version/sqlite3ext.h" ./Sources/CSQLite/include/sqlite3ext.h

rm -rf "$scratch_dir"
