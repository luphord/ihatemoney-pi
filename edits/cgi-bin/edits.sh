#!/bin/sh

echo "Content-type: text/html"
echo ""

echo '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">'

echo "<TABLE>"
sqlite3 $SQLITE_DATABASE <<EOF
.header on
.mode html
SELECT * FROM bill_archive ORDER BY change_time DESC;
EOF
echo "</TABLE>"