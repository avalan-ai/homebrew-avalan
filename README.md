# Homebrew Tap for Avalan

Install Avalan with Homebrew:

```sh
brew install avalan-ai/avalan/avalan
```

Verify the CLI:

```sh
avalan --version
```

This automatically taps `avalan-ai/homebrew-avalan`.

Alternatively, you can tap first and then install:

```sh
brew tap avalan-ai/avalan
brew install avalan
```

## What this installs

This formula installs the Avalan CLI as a Homebrew formula.

The default Homebrew package intentionally avoids installing every optional Python extra. Hardware-specific and heavyweight extras such as `mlx`, `apple`, `nvidia`, `vllm`, `audio`, `vision`, and `quantization` should be packaged separately or installed with pip when needed.
