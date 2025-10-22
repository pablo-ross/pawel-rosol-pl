#!/bin/bash

# Production build script for Jekyll Chirpy theme v7.4.0
# Updated: October 22, 2025

set -e  # Exit on error

echo "==> Switching to Ruby 3.2.2..."
source ~/.rvm/scripts/rvm
rvm use 3.2.2

echo "==> Building CSS and JavaScript assets..."
npm run build

echo "==> Building Jekyll site for production..."
JEKYLL_ENV=production bundle exec jekyll build

echo "==> Setting permissions..."
cd ./_site
find ./ -type d -exec chmod 755 {} \;
find ./ -type f -exec chmod 644 {} \;

echo "==> Deploying to production server..."
rsync -arvz -e 'ssh -p 62444' --progress --delete ./ mornel@185.41.68.221:/home/mornel/public_html/pawel.rosol.pl/html

cd -
echo "==> Production deployment completed successfully!"
