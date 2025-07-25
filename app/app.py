from flask import Flask, jsonify
from datetime import datetime
import os
from dotenv import load_dotenv
import logging

# Load environment variables from .env file
load_dotenv()

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.FileHandler("app/logs/app.log"), logging.StreamHandler()],
)

# Create Flask app
app = Flask(__name__)

# Main route returning a static message
@app.route("/")
def home():
    logging.info("Home endpoint was accessed")
    return jsonify(
        {
            "message": "Hello! This is a simple Python web application.",
            "status": "success",
            "timestamp": datetime.now().isoformat(),
            "version": "1.0.0",
        }
    )


# Health check endpoint
@app.route("/health")
def health():
    logging.info("Health endpoint was accessed")
    return jsonify({"status": "healthy", "timestamp": datetime.now().isoformat()})


# API endpoint with a static message
@app.route("/api/message")
def api_message():
    logging.info("API message endpoint was accessed")
    return jsonify(
        {
            "message": "Welcome to our minimal Python API!",
            "data": {
                "greeting": "Hello from the Flask server!",
                "description": "This is a simple API returning static messages",
                "endpoints": [
                    "GET / - Main application info",
                    "GET /health - Health check",
                    "GET /api/message - This endpoint",
                ],
            },
        }
    )


# 404 error handler
@app.errorhandler(404)
def not_found(error):
    logging.warning(f"404 error: {error}")
    return jsonify(
        {
            "error": "Endpoint not found",
            "message": "The requested resource does not exist",
            "available_endpoints": ["/", "/health", "/api/message"],
        }
    ), 404

if __name__ == '__main__':
    print("🚀 Starting Flask server...")
    print("📝 Available endpoints:")
    print("   • GET / - Main application info")
    print("   • GET /health - Health check")
    print("   • GET /api/message - Static message API")

    app_port = int(os.environ.get("APP_PORT", 8080))
    app.run(host='0.0.0.0', port=app_port, debug=True)
