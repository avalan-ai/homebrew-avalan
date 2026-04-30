class Avalan < Formula
  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/1e/2a/a21ce9f3681222dbcabc14b09d5bb2dd25bc8c220d35e21fd7afb466248a/avalan-1.4.1-py3-none-any.whl"
  sha256 "d1b1b884cb03accba9eb5b5a7af51e26482440a958c75369c033cde423400c6b"
  license "MIT"

  depends_on "python@3.11"

  def install
    python = Formula["python@3.11"].opt_bin/"python3.11"
    system python, "-m", "venv", libexec

    constraints = buildpath/"constraints.txt"
    constraints.write <<~EOS
      a2a-sdk==0.3.26
      accelerate==1.13.0
      aioboto3==15.5.0
      aiobotocore==2.25.1
      aiofiles==25.1.0
      aiohappyeyeballs==2.6.1
      aiohttp==3.13.5
      aioitertools==0.13.0
      aiomysql==0.2.0
      aiosignal==1.4.0
      annotated-types==0.7.0
      anthropic==0.61.0
      anyio==4.13.0
      asyncpg==0.30.0
      attrs==26.1.0
      backports.tarfile==1.2.0
      beautifulsoup4==4.14.3
      boto3==1.40.61
      botocore==1.40.61
      certifi==2026.4.22
      cffi==2.0.0
      charset-normalizer==3.4.7
      click==8.3.3
      cryptography==47.0.0
      defusedxml==0.7.1
      diffusers==0.34.0
      distro==1.9.0
      elastic-transport==9.2.1
      elasticsearch==9.3.0
      faiss-cpu==1.13.2
      fastapi==0.116.2
      filelock==3.29.0
      flatbuffers==25.12.19
      frozenlist==1.8.0
      fsspec==2026.4.0
      google-api-core==2.30.3
      google-auth==2.49.2
      google-genai==1.74.0
      googleapis-common-protos==1.74.0
      greenlet==3.5.0
      h11==0.16.0
      hf-xet==1.4.3
      httpcore==1.0.9
      httpx==0.28.1
      httpx-sse==0.4.3
      huggingface-hub==0.36.2
      humanize==4.15.0
      idna==3.13
      imageio==2.37.3
      imageio-ffmpeg==0.6.0
      importlib-metadata==9.0.0
      jaraco.classes==3.4.0
      jaraco.context==6.1.2
      jaraco.functools==4.4.0
      jinja2==3.1.6
      jiter==0.14.0
      jmespath==1.1.0
      joblib==1.5.3
      jsonschema==4.26.0
      jsonschema-specifications==2025.9.1
      keyring==25.7.0
      litellm==1.75.3
      magika==0.6.3
      markdown-it-py==4.0.0
      markdownify==1.2.2
      markitdown==0.1.5
      markupsafe==3.0.3
      mcp==1.27.0
      mdurl==0.1.2
      mlx==0.28.0
      mlx-lm==0.26.4
      mlx-metal==0.28.0
      more-itertools==11.0.2
      mpmath==1.3.0
      multidict==6.7.1
      networkx==3.6.1
      numpy==2.4.4
      onnxruntime==1.25.1
      openai==1.90.0
      opencv-python==4.13.0.92
      packaging==25.0
      pandas==2.3.3
      pdfminer.six==20251230
      pdfplumber==0.11.9
      pgvector==0.4.2
      pillow==11.3.0
      playwright==1.59.0
      propcache==0.4.1
      proto-plus==1.27.2
      protobuf==6.33.6
      psutil==7.2.2
      psycopg==3.3.3
      psycopg-binary==3.3.3
      psycopg-pool==3.3.0
      pyasn1==0.6.3
      pyasn1-modules==0.4.2
      pycparser==3.0
      pydantic==2.13.3
      pydantic-core==2.46.3
      pydantic-settings==2.14.0
      pyee==13.0.1
      pygments==2.20.0
      pyjwt==2.12.1
      pymysql==1.1.2
      pypdf==6.10.2
      pypdfium2==5.7.1
      python-dateutil==2.9.0.post0
      python-dotenv==1.2.2
      python-multipart==0.0.27
      pytz==2026.1.post1
      pyyaml==6.0.3
      referencing==0.37.0
      regex==2026.4.4
      requests==2.33.1
      restrictedpython==8.1
      rich==14.3.4
      rpds-py==0.30.0
      s3transfer==0.14.0
      safetensors==0.7.0
      scikit-learn==1.8.0
      scipy==1.17.1
      sentence-transformers==5.4.1
      sentencepiece==0.2.1
      six==1.17.0
      sniffio==1.3.1
      soundfile==0.13.1
      soupsieve==2.8.3
      sqlalchemy==2.0.49
      sqlglot==27.29.0
      sse-starlette==3.0.3
      starlette==0.48.0
      sympy==1.14.0
      tenacity==9.1.4
      threadpoolctl==3.6.0
      tiktoken==0.10.0
      tokenizers==0.22.2
      torch==2.7.1
      torchaudio==2.7.1
      torchvision==0.22.1
      tqdm==4.67.3
      transformers==4.57.6
      tree-sitter==0.25.2
      tree-sitter-python==0.23.6
      typing-extensions==4.15.0
      typing-inspection==0.4.2
      tzdata==2026.2
      urllib3==2.6.3
      uvicorn==0.35.0
      websockets==16.0
      wrapt==1.17.3
      yarl==1.23.0
      youtube-transcript-api==1.2.4
      zipp==3.23.1
    EOS

    venv_python = libexec/"bin/python"
    extras = %w[
      agent
      audio
      memory
      quantization
      server
      tool
      secrets
      translation
      vendors
      vision
      vllm
      mlx
      apple
      nvidia
    ].join(",")
    # Extras must be attached to the distribution name for pip to resolve them from a wheel.
    package = "avalan[#{extras}] @ file://#{cached_download}"
    system venv_python, "-m", "pip", "install",
           "--disable-pip-version-check",
           "--no-cache-dir",
           "--only-binary=:all:",
           "--constraint", constraints,
           package

    bin.install_symlink libexec/"bin/avalan"
    bin.install_symlink libexec/"bin/avl"
  end

  test do
    assert_match "avalan #{version}", shell_output("#{bin}/avalan --version")
  end
end
