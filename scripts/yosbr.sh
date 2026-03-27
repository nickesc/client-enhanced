#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

rsync -avi --stats --filter=':- ../.gitignore' --exclude-from="$(git config --get core.excludesfile)" --exclude='yosbr' config/ config/yosbr/config
rsync -avi options.txt config/yosbr/options.txt

# include.json
[ -d journeymap/config ] && mkdir -p config/yosbr/journeymap && rsync -avi journeymap/config/ config/yosbr/journeymap/config/

[ -d journeymap/server ] && mkdir -p config/yosbr/journeymap && rsync -avi journeymap/server/ config/yosbr/journeymap/server/

mkdir -p config/yosbr/mods
rsync -avi --include='*.md' --exclude='*' mods/ config/yosbr/mods/

mkdir -p config/yosbr/resourcepacks
rsync -avi --include='*.md' --include='*.rpo' --exclude='*' resourcepacks/ config/yosbr/resourcepacks/

mkdir -p config/yosbr/shaderpacks
rsync -avi --include='*.md' --include='*.txt' --exclude='*' shaderpacks/ config/yosbr/shaderpacks/

rsync -avi .gitignore modpack.json modpack.lock CHANGELOG.md README.md config/yosbr/
