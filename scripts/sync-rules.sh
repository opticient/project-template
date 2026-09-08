#!/usr/bin/env bash
# Generates AI tool rule files from rules/*.md. Edit rules/, not the output.
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

rules_index() {
    echo "Standards live in \`rules/\`. Read the file that covers what you are changing."
    echo
    for f in rules/*.md; do
        name="$(basename "$f")"
        desc="$(grep -m1 '^# ' "$f" | sed 's/^# //')"
        echo "- \`rules/$name\` — $desc"
    done
    echo
    echo "Regenerate tool configs with \`./scripts/sync-rules.sh\` after editing them."
}

write_block() {
    local target="$1" mode="$2" tmp line
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
        if [ "$mode" = index ]; then rules_index; else rules_body; fi
        echo "$END"
    } >> "$tmp"
    mv "$tmp" "$target"
    echo "wrote $target"
}

mkdir -p .cursor/rules .github

write_block AGENTS.md index
write_block CLAUDE.md index
write_block .github/copilot-instructions.md full

rm -f .cursor/rules/generated-*.mdc
for f in rules/*.md; do
    name="$(basename "$f" .md)"
    {
        echo '---'
        echo "description: \"${name//-/ } standards\""
        echo 'alwaysApply: true'
        echo '---'
        echo
        cat "$f"
    } > ".cursor/rules/generated-${name}.mdc"
done
echo "wrote .cursor/rules/generated-*.mdc"

rules_body > .windsurfrules
echo "wrote .windsurfrules"
