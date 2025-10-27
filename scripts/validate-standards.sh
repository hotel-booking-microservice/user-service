#!/bin/bash

set -e  # Exit immediately if any command fails

echo "🔍 Validating project standards..."

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    echo "❌ Dockerfile missing"
    exit 1
fi

# Check Dockerfile standards
echo "✅ Checking Dockerfile standards..."

# Check for Java 17 - CORRECTED
if ! grep -q "FROM openjdk:17" Dockerfile; then
    echo "❌ Dockerfile must use openjdk:17"
    exit 1
fi

# Check for non-root user - CORRECTED
if ! grep -q "USER spring" Dockerfile; then
    echo "❌ Dockerfile must use non-root user"
    exit 1
fi

# Check for health check
if ! grep -q "HEALTHCHECK" Dockerfile; then
    echo "❌ Dockerfile must have health check"
    exit 1
fi

# Check for .dockerignore
if [ ! -f ".dockerignore" ]; then
    echo "❌ .dockerignore file missing"
    exit 1
fi

# Check application properties
if [ -f "src/main/resources/application.yml" ]; then
    if ! grep -q "spring:" src/main/resources/application.yml; then
        echo "❌ application.yml missing spring configuration"
        exit 1
    fi
fi

echo "🎉 All standards validated successfully!"