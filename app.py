#!/usr/bin/env python3
"""
FireRedTTS2 Gradio App - Downloads model from HuggingFace at startup.
"""

import os

MODEL_ID = os.environ.get("FIREREDTTS2_MODEL", "FireRedTeam/FireRedTTS2")
MODEL_DIR = os.environ.get("FIREREDTTS2_MODEL_DIR", "/app/models/FireRedTTS2")
DEVICE = os.environ.get("FIREREDTTS2_DEVICE", "cuda")
PORT = int(os.environ.get("GRADIO_PORT", "7860"))


def download_model():
    from huggingface_hub import snapshot_download

    if os.path.exists(os.path.join(MODEL_DIR, "config_llm.json")):
        print(f"Model exists at {MODEL_DIR}")
        return MODEL_DIR

    print(f"Downloading {MODEL_ID}...")
    return snapshot_download(
        repo_id=MODEL_ID,
        local_dir=MODEL_DIR,
        local_dir_use_symlinks=False,
    )


if __name__ == "__main__":
    model_path = download_model()

    from gradio_demo import initiate_model, render_interface

    print(f"Loading model from {model_path}...")
    initiate_model(pretrained_dir=model_path, device=DEVICE)

    page = render_interface()
    page.launch(server_name="0.0.0.0", server_port=PORT, show_error=True)
