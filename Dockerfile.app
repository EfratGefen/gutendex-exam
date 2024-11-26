FROM python:3.9

# Set working directory
WORKDIR /app

# Install netcat for the 'nc' command
RUN apt-get update && apt-get install -y netcat-openbsd

# Copy the requirements file and install packages
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables for Django
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set entrypoint to our script
ENTRYPOINT ["/entrypoint.sh"]
