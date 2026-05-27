FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

# ✅ Install aria2 v1.37.0 binary
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl libssl-dev && \
    curl -L https://github.com/q3aql/aria2-static-builds/releases/download/v1.37.0/aria2-1.37.0-linux-gnu-64bit-build1.tar.bz2 \
    -o /tmp/aria2.tar.bz2 && \
    tar -xjf /tmp/aria2.tar.bz2 -C /tmp && \
    cp /tmp/aria2-1.37.0-linux-gnu-64bit-build1/aria2c /usr/local/bin/aria2c && \
    chmod +x /usr/local/bin/aria2c && \
    rm -rf /tmp/aria2* && \
    apt-get clean

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install setuptools==68.2.2 wheel
RUN pip3 install --use-pep517 --no-cache-dir -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
