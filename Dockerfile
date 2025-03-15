FROM python:3.13-alpine

RUN apk -U upgrade && apk add bash

#RUN addgroup -S appgroup && adduser -S appuser -G appgroup
## Tell docker that all future commands should run as the appuser
#USER appuser

WORKDIR /usr/app

COPY requirements.txt .
COPY /match /dotenv makefile pyproject.toml ./

# uv vs pip vs poetry
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /usr/app

CMD ["uvicorn", "match.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
