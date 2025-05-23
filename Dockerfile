FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

WORKDIR /app

RUN apt-get update && apt-get install -y git

COPY requirements.txt ./
COPY main.py ./
COPY run.sh ./

RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 8000

CMD ["./run.sh"]
