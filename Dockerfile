# ใช้ Python 3.10 เพื่อให้มี wheel ของ paddlepaddle/paddleocr
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 NUMEXPR_NUM_THREADS=1

WORKDIR /opt/app

# ไลบรารีระบบที่จำเป็นสำหรับ opencv/paddle (รันไทม์)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 libsm6 libxext6 libxrender1 libgl1 ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*

# ติดตั้งไลบรารี Python
COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install -U pip setuptools wheel \
 && python -m pip install --no-cache-dir -r /tmp/requirements.txt

# คัดลอกซอร์สโค้ดแอป (ถ้ามีไฟล์อื่น ๆ ให้เพิ่ม)
COPY . /opt/app

# ปรับได้ตามแอปของคุณ
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
