FROM python:3.11.9-alpine3.18

LABEL maintainer="Jalen Mak"

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python3", "webapp/manage.py", "runserver", "0.0.0.0:8000"]
