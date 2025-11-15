# build stage (installs deps to /root/.local)
FROM python:3.9 as builder
WORKDIR /app/backend
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# runtime stage
FROM python:3.9-slim
WORKDIR /app/backend

# copy installed packages from builder
COPY --from=builder /root/.local /root/.local
COPY . .

ENV PATH=/root/.local/bin:$PATH

EXPOSE 8000

# Use the normal runserver invocation and ensure 0.0.0.0
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

