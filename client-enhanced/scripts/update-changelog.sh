#!/bin/zsh

# Get the latest tag or use the first commit if no tags exist
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || git log --pretty=format:"%h" | tail -n 1)

# Get the commits since the latest tag
commits=$(git log --pretty=format:"- %s" $latest_tag..HEAD)

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

# Create the changelog entry
changelog_entry="# $new_version\n"
for commit in $commits; do
  changelog_entry+="$commit\n\n"
done

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
