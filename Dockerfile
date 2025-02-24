# Build stage
FROM python:3.9 as builder

WORKDIR /app/backend

COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Runtime stage
FROM python:3.9-slim

WORKDIR /app/backend

COPY --from=builder /root/.local /root/.local
COPY . .

ENV PATH=/root/.local/bin:$PATH

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
