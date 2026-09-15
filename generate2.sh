#!/bin/sh
INPUT="data.txt" 
OUTPUT="output.html"

# Read plain-text fields
TITLE=$(sed -n 's/^TITLE=//p' "$INPUT")
AUTHOR=$(sed -n 's/^AUTHOR=//p' "$INPUT")
COURSE=$(sed -n 's/^COURSE=//p' "$INPUT")
DESCRIPTION=$(sed -n 's/^DESCRIPTION=//p' "$INPUT")

# Generate a standalone HTML document
cat > "$OUTPUT" <<EOF
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>$TITLE</title>
</head>
<body>
<h1>$TITLE</h1>
<h2>$COURSE</h2>
<p><strong>Author:</strong> $AUTHOR</p>
<p>$DESCRIPTION</p>
</body>
</html>
EOF

# Report file size
SIZE=$(wc -c < "$OUTPUT")

echo "Generated: $OUTPUT"
echo "File size: $SIZE bytes"

if [ "$SIZE" -lt 5120 ]; then
    echo "PASS: output is under 5 KB."
else
    echo "FAIL: output is 5 KB or larger."
    exit 1
fi 