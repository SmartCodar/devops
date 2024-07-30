from flask import Flask, request, jsonify
import logging

app = Flask(__name__)

# Setup logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def hello():
    app.logger.info("Serving the Hello World response")
    app.logger.info("Diagnostic Message : Inside the Hello Method.......")
    return "Hello World! This is from Container Deployed using Terraform"

@app.route('/authenticate', methods=['POST'])
def authenticate():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    if username == "Ameet" and password == "Parse":
        app.logger.info(f"Successful login for user: {username}")
        return jsonify({"token": "some-token-value"}), 200
    else:
        app.logger.warning(f"Failed login attempt for user: {username}")
        return jsonify({"error": "Invalid username or password"}), 401

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
