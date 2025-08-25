# Gunain base image python
FROM python:3.9-slim

# Install dependencies sistem biar face_recognition & cmake gak error
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    libopenblas-dev \
    liblapack-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgl1 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory di dalam container
WORKDIR /app

# Copy semua file project ke container
COPY . /app

# Install semua python package
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000 buat Flask
EXPOSE 5000

# Jalankan app
CMD ["python", "api_face.py"]
