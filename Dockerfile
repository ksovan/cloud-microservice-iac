# Use an official lightweight Python base image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependency definition and install packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY app/ ./app/

# Expose port 8000 for network access
EXPOSE 8000

# Specify the default command to launch the web server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]