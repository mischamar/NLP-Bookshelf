from flask import Flask, request, jsonify
import pytesseract
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
from PIL import Image
import requests


app = Flask(__name__)

@app.route("/getbook", methods=["POST"])
def getbooktitle():
    if request.method == "POST":
        file = request.files['image']
        img = Image.open(file.stream)
        booktitle = pytesseract.image_to_string(img)

        api_key = "AIzaSyDlp19ogXeUuugzO3UZYRUqL9RVSzo2nQk"
        url = f"https://www.googleapis.com/books/v1/volumes?q={booktitle}&key={api_key}"
        response = requests.get(url)
        json_response = response.json()
        volume_info = json_response['items'][0]['volumeInfo']
        title = volume_info.get('title')
        author = volume_info.get('authors')
        images_link = volume_info['imageLinks']
        return jsonify({'title': title,'author': author,'images_links': images_link})

if __name__ == "__main__":
    app.run(debug=True)
