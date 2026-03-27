#!/bin/zsh

# Get the latest tag or use the first commit if no tags exist
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || git log --pretty=format:"%h" | tail -n 1)

# Get the commits since the latest tag
commitlog=$(git log --pretty=format:"- %s||" $latest_tag..HEAD)
commits=(${(@s:||:)commitlog})

# Check if there are any commits
if [[ -z "$commits" ]]; then
  echo "No new commits since $latest_tag"
  exit 0
fi

# Ask the user for the new version
read -r "new_version?Enter the new version (x.y.z): "

# Validate version format (basic check)
if [[ ! "$new_version" =~ [0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid version format. Semantic versioning required (x.y.z)."
    exit 1
fi

# Create the changelog entry, checking to make sure duplicate commit messages are ignored
changelog_entry="# $new_version\n"
changelog_tail="\n\n"
seen=()

for commit in $commits; do
  if [[ ${seen[(ie)$commit]} -gt ${#seen} ]]; then
    seen+=($commit)
    changelog_entry+="$commit"
  fi
done

changelog_entry+="$changelog_tail"

# Check if CHANGELOG.md exists
if [[ -f "CHANGELOG.md" ]]; then
  # Prepend the new entry to the existing changelog
  echo "$changelog_entry$(cat CHANGELOG.md)" > CHANGELOG.md_temp
  mv CHANGELOG.md_temp CHANGELOG.md
  echo "Changelog updated."
else
  # Create the changelog file
  echo "$changelog_entry" > CHANGELOG.md
  echo "Changelog created."
fi
