import cv2
import json
from PIL import Image
from PIL.ExifTags import TAGS
import os

def get_metaData(image_path):
    image = Image.open(image_path)
    metaData_indx = image._getexif()

    if metaData_indx is not None:
        metaData = {}
        for mainTag, value in metaData_indx.items():
            mainTag_name = TAGS.get(mainTag, mainTag)
            if mainTag_name == "DateTime":
                metaData['DateTime'] = value
        return metaData
    else:
        return {}

def get_image_name(image_path):
    #get the name of the file
    image_name = os.path.splitext(os.path.basename(image_path))[0].lower()
    return image_name

def find_light_zones(image_path, max_illumintation=200, min_area=1000, max_distance=50):
    #read image
    image = cv2.imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Apply filter to find light zones
    _, umbral = cv2.threshold(gray, max_illumintation, 255, cv2.THRESH_BINARY)

    # find the perimeter of the zones
    perimeter, _ = cv2.findContours(umbral, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # list to storage the size of the rectangles
    rectangle = []

    for per in perimeter:
        # calculate area
        area = cv2.contourArea(per)
        if area > min_area:
            # create a rectangle
            x, y, w, h = cv2.boundingRect(per)
            rectangle.append((x, y, w, h))

    # to join closest rectangles
    def join_rectangle(rectangle, max_distance):
        joined = []
        while rectangle:
            r1 = rectangle.pop(0)
            newR = []
            for r2 in rectangle:
                if (abs(r1[0] - r2[0]) < max_distance and abs(r1[1] - r2[1]) < max_distance):
                    # join into a bigger rectangle
                    x1 = min(r1[0], r2[0])
                    y1 = min(r1[1], r2[1])
                    x2 = max(r1[0] + r1[2], r2[0] + r2[2])
                    y2 = max(r1[1] + r1[3], r2[1] + r2[3])
                    r1 = (x1, y1, x2 - x1, y2 - y1)
                else:
                    newR.append(r2)
            rectangle = newR
            joined.append(r1)
        return joined

    #join the rectangles
    rectangle_joined = join_rectangle(rectangle, max_distance)

    # list to storage center coordinates
    centers = []

    # save the coordinates in the list
    for (x, y, w, h) in rectangle_joined:
        # calculate rectangle center
        x_center = int(x + w / 2)
        y_center = int(y + h / 2)
        centers.append((x_center, y_center))

    metaData = get_metaData(image_path)

    image_name = get_image_name(image_path)

    # storage the data in json format
    info = {
        "image_path": image_path,
        "name": image_name,
        "centers": centers,
        "metadata": metaData
    }
    # create json file
    with open(image_name +'.json', 'w') as archivo_json:
        json.dump(info, archivo_json, indent=4)

    return centers

image_path = r'C:\Users\Gokus\OneDrive\Escritorio\StarSound\ImageProcess\dwnImg\e1.png'
centers = find_light_zones(image_path, max_illumintation=150, min_area=100, max_distance=50)