from fastapi import FastAPI, File, UploadFile
from PIL import Image
import easyocr
import io
import numpy as np

app = FastAPI()

reader = easyocr.Reader(['en'], gpu=False)  

@app.post("/api/get/content/")
async def get_text(image: UploadFile = File(...)):

    image_bytes = await image.read()
    img = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    img_array = np.array(img)
    results = reader.readtext(img_array)

    texts = []
    for _, text, conf in results:
        texts.append({
            "text": text,
            "confidence": float(conf)
        })

    return {
        "filename": image.filename,
        "results": texts
    }
