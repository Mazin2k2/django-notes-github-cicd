FROM python:3.12-slim
WORKDIR /app
COPY app.py .
RUN pip install web.py
EXPOSE 8081
CMD ["python3", "app.py"]
