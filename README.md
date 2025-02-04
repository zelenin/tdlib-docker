# tdlib-docker

## CI/CD Information

This project uses GitHub's hosted runners for multi-architecture builds:
- AMD64: Standard Ubuntu runner
- ARM64: Ubuntu 24.04 ARM runner (public preview)

Note: ARM64 builds are only available for public repositories using GitHub's hosted runners.

## Development

### Build Caching for CI Debugging

The GitHub Actions workflow (in .github/workflows/main.yml) has commented lines for build caching to increase speed if needed for development or CI debugging purposes, uncomment these lines if needed.