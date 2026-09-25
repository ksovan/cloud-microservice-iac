from fastapi import FastAPI

app = FastAPI(title="Metrics Microservice")

@app.get("/")
def read_root():
    return {
        "status": "healthy",
        "service": "metrics-api",
        "version": "1.0.0"
    }

@app.get("/health")
def health_check():
    return {"status": "ok"}