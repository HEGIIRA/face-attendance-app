# api_face.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import face_recognition
import uuid
import os
from datetime import datetime

# ===== Firestore via firebase_admin =====
import firebase_admin
from firebase_admin import credentials, firestore

# Inisialisasi Firebase Admin (download service account JSON dari Firebase Console)
# Simpan filenya misal "serviceAccountKey.json" di folder ini
if not firebase_admin._apps:
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_admin.initialize_app(cred)

db = firestore.client()

app = Flask(__name__)
CORS(app)  # biar aman akses dari emulator/device

# Simpan encoding sementara di RAM
TEMP_ENCODINGS = {}  # { temp_id: [128 floats] }

@app.route("/encode_face", methods=["POST"])
def encode_face():
    # terima file dari Flutter: field name = 'file'
    file = request.files.get("file")
    if not file:
        return jsonify({"face_detected": False, "msg": "No file"}), 400

    # load & encode
    img = face_recognition.load_image_file(file)
    encs = face_recognition.face_encodings(img)

    if len(encs) == 0:
        return jsonify({"face_detected": False, "msg": "No face detected"}), 200

    temp_id = str(uuid.uuid4())
    TEMP_ENCODINGS[temp_id] = encs[0].tolist()

    return jsonify({
        "face_detected": True,
        "temp_id": temp_id
    }), 200


@app.route("/register", methods=["POST"])
def register():
    data = request.get_json(silent=True) or {}
    temp_id = data.get("temp_id")
    name = data.get("name")
    division = data.get("division")
    owner_uid = data.get("ownerUid")

    if not temp_id or not name or not division or not owner_uid:
        return jsonify({"success": False, "msg": "Missing fields"}), 400

    if temp_id not in TEMP_ENCODINGS:
        return jsonify({"success": False, "msg": "Temp ID not found"}), 404

    encoding = TEMP_ENCODINGS.pop(temp_id)

    # tulis ke Firestore
    now = firestore.SERVER_TIMESTAMP
    doc_ref = db.collection("employees").document()  # auto id
    doc_ref.set({
        "name": name,
        "division": division,
        "ownerUid": owner_uid,
        "tempId": temp_id,
        "encoding": encoding,
        "active": True,
        "createdAt": now,
    })

    return jsonify({
        "success": True, 
        "employeeId": doc_ref.id,
        "msg": f"Employee {name} registered in division {division}"
    }), 200


if __name__ == "__main__":
    # jalankan di 0.0.0.0 biar device bisa akses (pakai ngrok kalau di device fisik)
    port = int(os.environ.get("PORT", 5001))
    app.run(host="0.0.0.0", port=port, debug=False)
