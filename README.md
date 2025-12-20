# 🎙️ FireRedTTS2 Gradio Interface 🎧

[![Python 3.11](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![Gradio](https://img.shields.io/badge/Gradio-4.0%2B-orange.svg)](https://gradio.app/)
[![Hugging Face](https://img.shields.io/badge/Hugging%20Face-Model-yellow.svg)](https://huggingface.co/FireRedTeam/FireRedTTS2)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A user-friendly Gradio interface for [FireRedTTS2](https://huggingface.co/FireRedTeam/FireRedTTS2), a long-form streaming TTS system for multi-speaker dialogue generation with natural speech and reliable speaker switching.

## ✨ Features

- 🗣️ **Multi-Speaker Dialogues**: Generate conversations with up to 4 speakers, supporting 3+ minute dialogues
- 🌐 **Multilingual Support**: English, Chinese, Japanese, Korean, French, German, and Russian
- 🎭 **Voice Cloning**: Zero-shot voice cloning for cross-lingual and code-switching scenarios
- ⚡ **Ultra-Low Latency**: 12.5Hz streaming with first-packet latency as low as 140ms
- 🎲 **Random Timbre Generation**: Create unique synthetic voices on-the-fly
- 🎚️ **BF16 Inference**: Reduced VRAM usage (9GB) for consumer-grade GPU deployment

## 🚀 Quick Start

### Prerequisites

- CUDA-compatible GPU (recommended: 9GB+ VRAM)
- Docker (recommended) or Python 3.11

## 🐳 Docker Support

### Using Pre-built Image

Pull and run the pre-built Docker image from GitHub Container Registry:

```bash
# Pull the image
docker pull ghcr.io/comput3ai/c3-fireredtts2-gradio:latest

# Run the container with GPU support
docker run -p 7860:7860 --gpus all \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  ghcr.io/comput3ai/c3-fireredtts2-gradio
```

### Building Locally

Build and run the application using Docker:

```bash
# Build the image
docker build -t fireredtts2 .

# Run the container with GPU support
docker run -p 7860:7860 --gpus all \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  fireredtts2
```

Open your browser at `http://localhost:7860`

### Local Installation

```bash
# Clone the repository
git clone https://github.com/comput3ai/c3-fireredtts2-gradio.git
cd c3-fireredtts2-gradio

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install PyTorch with CUDA
pip install torch==2.7.1 torchaudio==2.7.1 --index-url https://download.pytorch.org/whl/cu126

# Install dependencies
pip install -e .
pip install -r requirements.txt

# Run the application
python app.py
```

## 🧩 Usage Examples

### Dialogue Mode

Format your script with speaker tags:

```
[S1] Hello! Welcome to our podcast today.
[S2] Thanks for having me, it's great to be here.
[S1] Let's start with your background in AI research.
[S2] Sure, I've been working in this field for about five years now.
```

### Voice Cloning

Upload audio samples for each speaker to clone their voice. The model supports:
- Cross-lingual voice cloning
- Code-switching within the same utterance
- Multiple reference samples per speaker

## ⚙️ Advanced Configuration

- **Temperature**: Controls randomness (default: 0.9)
- **Top-k**: Limits token selection (default: 30)
- **Streaming**: Real-time audio output with 80ms chunks

## 🔍 Implementation Details

This application is built on:

- **FireRedTTS2**: Long-form conversational TTS model
- **Qwen2.5-1.5B**: For text tokenization
- **Xcodec2**: Vocos-based acoustic decoder
- **Gradio**: For the web interface

## ⚠️ Ethical Use Guidelines

This tool is provided for research, education, and legitimate creative purposes. Please:

- Do not clone voices without explicit consent
- Do not create misleading or deceptive content
- Do not use for any illegal activities
- Report any instances of abuse or misuse

## 📄 License

This interface is licensed under the Apache 2.0 License. The FireRedTTS2 model has its own license terms available at [Hugging Face](https://huggingface.co/FireRedTeam/FireRedTTS2).

## 🙏 Acknowledgements

- [FireRed Team](https://github.com/FireRedTeam/FireRedTTS2) for FireRedTTS2
- [Sesame AI Labs](https://github.com/SesameAILabs/csm) for the dual-transformer approach
- [Hugging Face](https://huggingface.co/) for model hosting
- [Gradio](https://gradio.app/) for the interface framework
