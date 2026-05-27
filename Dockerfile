FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

# permissions (optional but ok for WZML-X)
RUN chmod 777 /usr/src/app

# =========================
# ✅ Install latest aria2c
# =========================
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    bzip2 \
    ca-certificates && \
    curl -L https://github.com/q3aql/aria2-static-builds/releases/download/v1.37.0/aria2-1.37.0-linux-gnu-64bit-build1.tar.bz2 \
    -o /tmp/aria2.tar.bz2 && \
    tar -xjf /tmp/aria2.tar.bz2 -C /tmp && \
    cp /tmp/aria2-1.37.0-linux-gnu-64bit-build1/aria2c /usr/local/bin/aria2c && \
    chmod +x /usr/local/bin/aria2c && \
    aria2c --version && \
    rm -rf /tmp/aria2* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# =========================
# Python dependencies
# =========================
COPY requirements.txt .

RUN pip3 install --upgrade pip
RUN pip3 install setuptools==68.2.2 wheel
RUN pip3 install --use-pep517 --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Start bot
CMD ["bash", "start.sh"]
