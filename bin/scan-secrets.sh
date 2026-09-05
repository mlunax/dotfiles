#!/bin/zsh
# Manual secret scan for the whole tree + full history.
# Uses gitleaks (git-aware) and trufflehog (content-aware).
# Exits nonzero if any potential secret is found.

set -e

msg() { printf '%s\n' "[scan-secrets] $*" >&2; }
die() { printf '%s\n' "[scan-secrets] ERROR: $*" >&2; exit 1; }

for tool in gitleaks trufflehog; do
    command -v "$tool" >/dev/null 2>&1 || die "'$tool' not found. Install it (brew install $tool) to scan."
done

fail=0

echo "[*] gitleaks: scanning working tree"
if ! gitleaks detect --source . --verbose --no-banner; then
    msg "gitleaks found a potential secret in the working tree."
    fail=1
fi

echo "[*] gitleaks: scanning git history"
if ! gitleaks git --log-opts="--all" --verbose --no-banner; then
    msg "gitleaks found a potential secret in git history."
    fail=1
fi

echo "[*] trufflehog: scanning working tree"
if ! trufflehog filesystem --no-update .; then
    msg "trufflehog found a potential secret in the working tree."
    fail=1
fi

if [ "$fail" -ne 0 ]; then
    die "potential secrets found. Review the findings above."
fi

echo "[+] no secrets found."
exit 0
