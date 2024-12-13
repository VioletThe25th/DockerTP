from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
def home():
    return "Coucou"

@app.route('/health', methods=['GET'])
def health():
    return "Healthy!", 200

# Test de la connexion à la base de données
@app.before_first_request
def test_db_connection():
    db_url = os.environ.get('DATABASE_URL')
    try:
        conn = psycopg2.connect(db_url)
        conn.close()
        print("Connexion à la base de données réussie !")
    except Exception as e:
        print(f"Erreur de connexion à la base de données : {e}")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
