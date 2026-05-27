FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

RUN chmod 777 /usr/src/app

# ✅ Update aria2 to v1.37.0
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libaria2-0 && \
    pip3 install aria2p && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip3 install --upgrade pip
RUN pip3 install setuptools==68.2.2 wheel
RUN pip3 install --use-pep517 --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
