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

release_head="The Client-Enhanced modpack is released on GitHub as a \`.mrpack\` file that can be imported into the Modrinth App to add the modpack configuration as a new instance.

<details><summary><h3>Changelog</h3></summary>"
release_tail="</details>

### Requirements:
- Minecraft 1.21.4
- the [Modrinth App](https://modrinth.com/app) installed
- macOS (untested on other platforms)

### Install:
1. Download the Main version or the Vulkan version of the Client-Enhanced \`.mrpack\` file from the latest release
    > Main Version: Sodium rendering engine; shaders enabled; requires more powerful hardware
    > Vulkan Version: Vulkan rendering engine, shaders not supported; very lightweight, should run well on any hardware
2. In the Modrinth App, click the \`+\` icon in the left sidebar to create a new instance and select \`From File\`
3. Select \`Import from file\` and open the \`.mrpack\` file you downloaded
4. Allow the modpack to download
5. Press \`Play\` to launch Minecraft"


to_copy="$release_head""\n\n""##$changelog_entry""$release_tail"

echo $to_copy | pbcopy && echo $to_copy
echo "\n    <Copied above release text to clipboard>"
echo "\nClient-Enhanced v$new_version\n"

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
