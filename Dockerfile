# ใช้ Python image เบา ๆ
FROM python:3.9-slim

# ติดตั้ง curl (ใช้ตรวจ healthcheck) และ dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ตั้ง working directory
WORKDIR /app

# กำหนด ENV
ENV PYTHONPATH=/app

# Copy requirements และติดตั้งก่อน (ช่วย cache layer)
COPY ./backend/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy code ทั้งหมดจาก backend เข้า /app
COPY ./backend /app

# เปิด port
EXPOSE 5000

# คำสั่งเริ่มต้น รัน Flask app
CMD ["python", "app.py"]
