# main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from diffusers import StableDiffusionXLPipeline
import torch
import base64
from io import BytesIO
from PIL import Image

app = FastAPI(title="AniIllustriousXL Image Generator")

# Load and optimize model
model_id = "John6666/aniillustriousxl-v10-sdxl"
pipe = StableDiffusionXLPipeline.from_pretrained(
    model_id,
    torch_dtype=torch.float16,
    variant="fp16",
    use_safetensors=True
)
pipe.to("cuda")
pipe.enable_attention_slicing()
pipe.enable_model_cpu_offload()

# Request schema
class GenerationRequest(BaseModel):
    prompt: str
    negative_prompt: str = ""
    num_inference_steps: int = 30
    guidance_scale: float = 7.5
    width: int = 768
    height: int = 1024
    seed: int | None = None

@app.post("/generate")
def generate_image(req: GenerationRequest):
    try:
        # Seed generator for reproducibility
        generator = torch.manual_seed(req.seed) if req.seed is not None else None

        # Generate image
        result = pipe(
            prompt=req.prompt,
            negative_prompt=req.negative_prompt,
            num_inference_steps=req.num_inference_steps,
            guidance_scale=req.guidance_scale,
            width=req.width,
            height=req.height,
            generator=generator
        )
        image = result.images[0]

        # Convert image to base64
        buffered = BytesIO()
        image.save(buffered, format="PNG")
        img_str = base64.b64encode(buffered.getvalue()).decode("utf-8")

        return {
            "success": True,
            "image_base64": f"data:image/png;base64,{img_str}"
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Image generation failed: {e}")
