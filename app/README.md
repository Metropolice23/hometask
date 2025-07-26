# Minimal Flask API Application

This is a minimal Python web application built with Flask. It provides a simple API with health check, static message, and main info endpoints. The app is designed for easy containerization and deployment, with built-in logging and environment variable configuration.

---

## Features

- **Three endpoints:**
  - `GET /` — Main application info
  - `GET /health` — Health check
  - `GET /api/message` — Returns a static message and endpoint info
- **Logging:**
  Logs all endpoint accesses and 404 errors to both the console and `app/logs/app.log`.
- **Environment variable support:**
  Reads configuration (like port) from environment variables or a `.env` file.
- **Ready for Docker:**
  Designed to run in a containerized environment.

---

## How to Run Locally

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd <repo-directory>
   ```

2. **Install dependencies:**
   ```sh
   pip install -r app/requirements.txt
   ```

3. **(Optional) Create a `.env` file in the root or `app/` directory:**
   ```
   APP_PORT=8080
   FLASK_ENV=development
   ```

4. **Run the app:**
   ```sh
   python app/app.py
   ```

5. **Access the endpoints:**
   - [http://localhost:8080/](http://localhost:8080/)
   - [http://localhost:8080/health](http://localhost:8080/health)
   - [http://localhost:8080/api/message](http://localhost:8080/api/message)

---

## Logging

- Logs are written to `app/logs/app.log` and also output to the console.
- Each endpoint access and 404 error is logged with a timestamp and log level.

---

## Configuration

- The app reads configuration from environment variables (e.g., `APP_PORT`).
- You can set these in a `.env` file or export them in your shell before running the app.

---

## Docker Support

This app is ready to be containerized.
A sample Dockerfile is provided in the project root.

---

## Security & Observability

- No secrets are hardcoded; all configuration is via environment variables.
- Logging provides basic observability for endpoint usage and errors.

---

## License

MIT License (or specify your license here)
