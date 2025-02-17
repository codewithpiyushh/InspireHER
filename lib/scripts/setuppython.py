import geocoder
import requests
import json
from math import radians, sin, cos, atan2, sqrt

# def get_user_location():
#     """Fetches the user's location (latitude and longitude)."""
#     try:
#         g = geocoder.ip('me')  # Use IP-based geolocation
#         if g.ok:
#             latitude, longitude = g.latlng
#             print(f"User location: Latitude: {latitude}, Longitude: {longitude}")
#             return latitude, longitude
#         else:
#             print("Could not determine user location.")
#             return None, None
#     except Exception as e:
#         print(f"Error getting location: {e}")
#         return None, None

def set_user_location(latitude, longitude):
    """Sets the user's location manually."""
    return latitude, longitude

def find_nearby_dairy_shops(latitude, longitude, radius=5):
    """Finds nearby dairy shops using OpenStreetMap data via Overpass API."""
    overpass_query = f"""
    [out:json];
    (
      node(around:{radius*1000},{latitude},{longitude})["shop"="dairy"];
      way(around:{radius*1000},{latitude},{longitude})["shop"="dairy"];
      relation(around:{radius*1000},{latitude},{longitude})["shop"="dairy"];
    );
    out body;
    >;
    out skel qt;
    """
    
    overpass_url = "https://overpass-api.de/api/interpreter"
    
    try:
        response = requests.get(overpass_url, params={'data': overpass_query})
        response.raise_for_status()  # Raise exception for HTTP errors
        data = response.json()

        dairy_shops = []
        for element in data.get('elements', []):
            if 'lat' in element and 'lon' in element:
                name = element.get('tags', {}).get('name', 'Unknown Dairy Shop')
                shop_lat = element['lat']
                shop_lon = element['lon']
                distance = calculate_distance(latitude, longitude, shop_lat, shop_lon)
                dairy_shops.append({"name": name, "latitude": shop_lat, "longitude": shop_lon, "distance": distance})

        # Sort by distance
        dairy_shops.sort(key=lambda x: x['distance'])

        return dairy_shops

    except requests.exceptions.RequestException as e:
        print(f"Error querying Overpass API: {e}")
        return None
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON response: {e}")
        return None

def calculate_distance(lat1, lon1, lat2, lon2):
    """Calculate the great-circle distance using the Haversine formula."""
    R = 6371  # Earth's radius in km

    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])

    dlat = lat2 - lat1
    dlon = lon2 - lon1

    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    a = min(1, max(0, a))  # Clamp to prevent domain errors

    c = 2 * atan2(sqrt(a), sqrt(1 - a))

    distance = R * c
    return distance

if __name__ == "__main__":
    # Set user location manually
    user_lat, user_lon = set_user_location(28.6139, 77.2090)  # Example: New Delhi coordinates

    if user_lat is not None and user_lon is not None:
        nearby_shops = find_nearby_dairy_shops(user_lat, user_lon)

        if nearby_shops:
            print("\nNearby Dairy Shops:")
            for shop in nearby_shops:
                print(f"- {shop['name']} (Distance: {shop['distance']:.2f} km)")
        else:
            print("No dairy shops found nearby.")