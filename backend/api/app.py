from flask import Flask
from flask_cors import CORS


app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Register the blueprint for movie routes
app.register_blueprint(movie_bp)
app.register_blueprint(explore_bp)

if __name__ == '__main__':
    app.run(debug=True)
