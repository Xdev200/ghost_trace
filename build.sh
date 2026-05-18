#!/bin/bash

echo "Downloading Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

export PATH="$PATH:`pwd`/flutter/bin"

echo "Flutter version:"
flutter --version

echo "Getting dependencies..."
flutter pub get

echo "Building app..."
flutter build web --release

echo "Building info website..."
cd ../ghost_tracer_web
npm install
npm run build
cd ../ghost_tracer
