from flask import Flask
import logging

app = Flask(__name__)

# Setup logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def hello():
    app.logger.info("Serving the Hello World response") # Logged in a Logs --> Docker Logs
    app.logger.info("Diagnostic Message : Inside the Hellow Method.......")
    return "Hello World! This is from Container Deployed using Terraform"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
