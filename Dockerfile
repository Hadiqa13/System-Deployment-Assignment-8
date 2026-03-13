# Use the official Python image from Docker Hub
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy requirements.txt first, then install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app/

# Initialize the database schema at build time
RUN python -c "import db; db.init_db()"

# Set the port for the application
ENV PORT=5000

# Run the app using Gunicorn (adjust the number of workers if necessary)
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:$PORT app:app"]
