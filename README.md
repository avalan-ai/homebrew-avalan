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

This formula installs the Avalan CLI as a Homebrew formula using the same
default profile as the Ubuntu package: `agent`, `server`, `tool`, and
`vendors`.

The formula defaults to Homebrew's `python@3.14`, while CI verifies the source
install path across Avalan's supported Python range: 3.11, 3.12, 3.13, and
3.14.

The default Homebrew package intentionally avoids installing every optional
Python extra. Hardware-specific and heavyweight extras such as `mlx`, `apple`,
`nvidia`, `audio`, `vision`, `quantization`, and newer opt-in extras such as
`a2a`, `browser`, `code`, `litellm`, `memory`, `translation`, and `youtube`
should be installed in a dedicated Python environment when needed. The `vllm`
extra is reserved upstream while vLLM depends on vulnerable `diskcache`
releases without an upstream fix; install vLLM directly only if you accept
that dependency.
