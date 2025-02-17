from flask import Flask, request, jsonify
import requests
import json
from math import radians, sin, cos, atan2, sqrt
from flask_cors import CORS

app = Flask(__name__)
CORS(app)



def calculate_distance(lat1, lon1, lat2, lon2):
    """Calculate great-circle distance using Haversine formula."""
    R = 6371  # Earth's radius in km
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
    dlat, dlon = lat2 - lat1, lon2 - lon1
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    return R * c

@app.route('/find_shops', methods=['POST'])  # Changed to POST
def find_nearby_shops():
    """Finds nearby shops using OpenStreetMap (Overpass API)."""
    try:
        data = request.get_json()  # Get JSON data from Flutter
        latitude = data.get("latitude")
        longitude = data.get("longitude")
        business_type = data.get("business", "dairy") # Get business type

        if not latitude or not longitude:
            return jsonify({"error": "Missing latitude or longitude"}), 400

        overpass_query = f"""
        [out:json];
        (
            node(around:5000,{latitude},{longitude})["shop"="{business_type}"];
            way(around:5000,{latitude},{longitude})["shop"="{business_type}"];
            relation(around:5000,{latitude},{longitude})["shop"="{business_type}"];
        );
        out body;
        >;
        out skel qt;
        """

        overpass_url = "https://overpass-api.de/api/interpreter"

        try:
            response = requests.get(overpass_url, params={'data': overpass_query})
            response.raise_for_status()
            data = response.json()

            shops = []
            for element in data.get("elements", []):
                if 'lat' in element and 'lon' in element:
                    name = element.get('tags', {}).get('name', 'Unknown Shop')
                    shop_lat, shop_lon = element['lat'], element['lon']
                    distance = calculate_distance(latitude, longitude, shop_lat, shop_lon)
                    shops.append({"name": name, "latitude": shop_lat, "longitude": shop_lon, "distance": distance})

            shops.sort(key=lambda x: x["distance"])
            print(shops)
            return jsonify(shops)

        except requests.exceptions.RequestException as e:
            return jsonify({"error": f"Error querying Overpass API: {e}"}), 500

    except Exception as e:
        return jsonify({"error": f"Error processing request: {e}"}), 500  # Catch JSON errors


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5003, debug=True)