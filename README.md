# Homebrew Tap for Avalan

Install Avalan with Homebrew:

```sh
brew tap avalan-ai/avalan
brew install avalan
```

Verify the CLI:

```sh
avalan --version
```

The formula installs Avalan with all published extras enabled. Platform-gated
extras, such as MLX on Apple Silicon and NVIDIA/vLLM packages on Linux, are
selected by Python package environment markers during installation.
