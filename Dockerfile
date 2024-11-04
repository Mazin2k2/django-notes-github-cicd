FROM python:3.12-slim
WORKDIR /app
COPY app.py .
RUN pip install web.py
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
CMD ["python3", "app.py"]
