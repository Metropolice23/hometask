# Base image for the Docker container
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app
# Copy the requirements file into the container and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Copy the the application code into the container
COPY app.py .
# Define port exposed by the container
EXPOSE 8080

# Command to run the application
CMD ["python", "app.py"]
