#!/usr/bin/env bash
# Generates every AI tool's rule file from rules/*.md.
# Edit rules/, never the generated files. Run: ./scripts/sync-rules.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

BEGIN='<!-- BEGIN GENERATED RULES -->'
END='<!-- END GENERATED RULES -->'

rules_body() {
    for f in rules/*.md; do
        cat "$f"
        echo
    done
}

write_block() {
    local target="$1"
    local tmp line
    tmp="$(mktemp)"
    if [ -f "$target" ]; then
        line="$(grep -nxF "$BEGIN" "$target" | head -1 | cut -d: -f1 || true)"
        if [ -n "$line" ]; then
            head -n "$((line - 1))" "$target" > "$tmp"
        else
            cat "$target" > "$tmp"
            echo >> "$tmp"
        fi
    fi
    {
        echo "$BEGIN"
        echo
        echo "Edit rules/ and run ./scripts/sync-rules.sh. Do not edit below this line."
        echo
        rules_body
        echo "$END"
    } >> "$tmp"
    mv "$tmp" "$target"
    echo "wrote $target"
}

mkdir -p .cursor/rules .github

write_block AGENTS.md
write_block CLAUDE.md
write_block .github/copilot-instructions.md

rm -f .cursor/rules/generated-*.mdc
for f in rules/*.md; do
    name="$(basename "$f" .md)"
    out=".cursor/rules/generated-${name}.mdc"
    {
        echo '---'
        echo "description: \"${name//-/ } standards\""
        echo 'alwaysApply: true'
        echo '---'
        echo
        echo '<!-- Generated from rules/. Run ./scripts/sync-rules.sh -->'
        echo
        cat "$f"
    } > "$out"
done
echo "wrote .cursor/rules/generated-*.mdc"

{
    echo '<!-- Generated from rules/. Run ./scripts/sync-rules.sh -->'
    echo
    rules_body
} > .windsurfrules
echo "wrote .windsurfrules"
