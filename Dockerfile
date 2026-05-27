FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

# =========================
# System packages + aria2
# =========================
RUN apt-get update && apt-get install -y --no-install-recommends \
    aria2 \
    curl \
    bzip2 \
    ca-certificates \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# (Optional) verify aria2 version
RUN aria2c --version

# =========================
# Python deps
# =========================
COPY requirements.txt .

RUN pip3 install --upgrade pip \
    && pip3 install setuptools==68.2.2 wheel \
    && pip3 install --use-pep517 --no-cache-dir -r requirements.txt

# =========================
# App source
# =========================
COPY . .

# =========================
# Permissions
# =========================
RUN chmod +x start.sh

CMD ["bash", "start.sh"]
