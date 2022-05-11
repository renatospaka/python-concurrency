FROM python:3.8

RUN apt update
RUN apt install -y nodejs npm build-essential libffi-dev python-dev
RUN npm install -g nodemon

RUN pip install -U pip
RUN pip install python-dateutil
RUN pip install pytz

WORKDIR /devel

COPY dev_requirements.txt .
RUN pip install -r dev_requirements.txt

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN echo "import subprocess; subprocess.run(['clear']); subprocess.run(['pytest', '/app/test/'])" > entrypoint.py 
RUN echo "black /app/src; black /app/test; isort /app/src; isort /app/test; pylint /app/src; pylint /app/test; " > linter.sh 

WORKDIR /app

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development 

ENV TERM=xterm-256color

CMD ["flask", "run"]