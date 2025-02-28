# Contributing to fnotes

Thank you for considering contributing to fnotes! This document outlines the process for contributing to this project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/inigochoa/fnotes.git`
3. Create a new branch for your feature: `git checkout -b feature/your-feature-name`

## Development Environment

Make sure you have the following tools installed:
- Bash (4.0+)
- fzf
- bat

## Making Changes

1. Make your changes to the codebase
2. Test your changes thoroughly
3. Ensure your code follows the style guidelines (use the provided .editorconfig)
4. Add or update documentation as needed

## Testing

Before submitting your changes, make sure to:
1. Test the script works correctly on your system
2. Run the test script: `./tests/test_fnotes.sh`
3. Verify the script works with different configurations

## Submitting Changes

1. Commit your changes with a clear commit message
2. Push to your fork: `git push origin feature/your-feature-name`
3. Submit a pull request

## Pull Request Guidelines

- Keep pull requests focused on a single feature or bug fix
- Include a description of what your changes do and why they should be included
- Update documentation if needed
- Update the CHANGELOG.md for notable changes

## Style Guidelines

- Follow the shell scripting style in the existing codebase
- Use 4-space indentation for shell scripts
- Use meaningful variable and function names
- Add comments for complex operations
- Follow the [Google Shell Style Guide] when possible

## Code of Conduct

Please be respectful and considerate of others when contributing to this project.

## License

By contributing to this project, you agree that your contributions will be licensed under the project's MIT license.

[Google Shell Style Guide]: https://google.github.io/styleguide/shellguide.html
