FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY requirements.txt .

# Fix setuptools compatibility
RUN pip3 install --upgrade pip
RUN pip3 install setuptools==68.2.2 wheel

# Important fix for pymediainfo 6.0.1
RUN pip3 install --use-pep517 --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
