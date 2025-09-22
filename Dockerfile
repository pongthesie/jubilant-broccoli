# ตัวอย่างฐาน Python
FROM python:3.12-slim

# ทำให้ log อ่านง่าย + network เสถียรขึ้น
ENV PIP_NO_CACHE_DIR=1 PIP_DEFAULT_TIMEOUT=60

# (แนะนำ) ติดตั้งเครื่องมือคอมไพล์ไว้ก่อน เผื่อบาง lib ต้อง build
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .

# อัปเกรด pip/setuptools/wheel แล้วแสดง log แบบ -vvv
RUN python -m pip install -U pip setuptools wheel \
 && python -m pip --verbose -vvv install -r requirements.txt

COPY . .
CMD ["python", "app.py"]
