#!/bin/bash
set -e

echo "Running Lease File Validation"
EXIT_CODE=0
TODAY=$(date +%Y-%m-%d)

# Get all changed files
ALL_CHANGED_FILES=$(git diff --name-only origin/$1 HEAD || true)

# Check for files outside lease/ directory
DISALLOWED_FILES=$(echo "$ALL_CHANGED_FILES" | grep -vE '^(lease/|\.github/workflows/validate-lease-folder-structure\.yaml|\.github/scripts/validate-lease\.sh)' || true)

if [ -n "$DISALLOWED_FILES" ]; then
  DISALLOWED_COUNT=$(echo "$DISALLOWED_FILES" | wc -l)
  echo "❌ Found $DISALLOWED_COUNT file(s) outside lease/ directory"
  echo "Only changes in lease/ are allowed (except workflow file)"
  echo ""
  echo "Disallowed files:"
  echo "$DISALLOWED_FILES" | head -20
  if [ "$DISALLOWED_COUNT" -gt 20 ]; then
    echo "... and $((DISALLOWED_COUNT - 20)) more files"
  fi
  echo ""
  EXIT_CODE=1
fi

# Get lease files
ALL_LEASE_FILES=$(git diff --name-only origin/$1 HEAD | grep '^lease/' | grep -v '\.md$' || true)

if [ -z "$ALL_LEASE_FILES" ]; then
  if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ No lease files to validate"
  fi
  exit $EXIT_CODE
fi

LEASE_COUNT=$(echo "$ALL_LEASE_FILES" | wc -l)
echo "Found $LEASE_COUNT lease file(s) to validate"

# Validation 1: Folder structure
INVALID_STRUCTURE=$(echo "$ALL_LEASE_FILES" | grep -vE '^lease/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/lease\.yaml$' || true)

if [ -n "$INVALID_STRUCTURE" ]; then
  INVALID_COUNT=$(echo "$INVALID_STRUCTURE" | wc -l)
  echo "❌ $INVALID_COUNT file(s) with invalid folder structure:"
  echo "$INVALID_STRUCTURE"
  echo "Expected: lease/<Namespace>/<Service>/lease.yaml"
  EXIT_CODE=1
fi

# Get valid lease files for content validation
VALID_LEASE_FILES=$(echo "$ALL_LEASE_FILES" | grep -E '^lease/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/lease\.yaml$' || true)

if [ -z "$VALID_LEASE_FILES" ]; then
  exit $EXIT_CODE
fi

# Validation : Content validation (only show failures)
CONTENT_ERRORS=""

for LEASE_FILE in $VALID_LEASE_FILES; do
  FOLDER_RP=$(echo "$LEASE_FILE" | cut -d'/' -f2)
  RP_NAME=$(yq eval '.lease.resource-provider' "$LEASE_FILE" 2>/dev/null || echo "")
  STARTDATE=$(yq eval '.lease.startdate' "$LEASE_FILE" 2>/dev/null || echo "")
  
  FILE_ERRORS=""
  
  # Check resource provider name
  if [ "$RP_NAME" != "$FOLDER_RP" ]; then
    FILE_ERRORS="${FILE_ERRORS}  - Resource provider mismatch: folder=$FOLDER_RP, yaml=$RP_NAME\n"
    EXIT_CODE=1
  fi
  
  # Check startdate format
  if ! echo "$STARTDATE" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
    FILE_ERRORS="${FILE_ERRORS}  - Invalid startdate format: $STARTDATE (expected: YYYY-MM-DD)\n"
    EXIT_CODE=1
  else
    # Check startdate is not in past
    if [[ "$STARTDATE" < "$TODAY" ]]; then
      FILE_ERRORS="${FILE_ERRORS}  - Startdate is in the past: $STARTDATE (today: $TODAY)\n"
      EXIT_CODE=1
    fi
  fi
  
  if [ -n "$FILE_ERRORS" ]; then
    CONTENT_ERRORS="${CONTENT_ERRORS}\n❌ $LEASE_FILE\n${FILE_ERRORS}"
  fi
done

# Summary
echo "========================================="
echo "Validation Summary"
echo "========================================="

if [ -n "$CONTENT_ERRORS" ]; then
  echo "Content validation errors in lease.yaml file:"
  echo -e "$CONTENT_ERRORS"
fi

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ All validations passed!"
else
  echo "❌ Validation failed - fix errors above"
fi

exit $EXIT_CODE
