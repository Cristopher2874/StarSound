import os
import json

# [Function to generate the audio available manifest]
def generate_audio_manifest(directory, output_file='image_manifest.json'):
    # store the audio files
    sounds = []
    
    #move through the directory
    for filename in os.listdir(directory):
        #filter files
        if filename.endswith(".png") or filename.endswith(".jpg"):
            # save the route
            sounds.append(f"assets/img/imagenes nasa/{filename}")

    # create the manifest
    manifest = {"sounds": sounds}

    #write names
    with open(os.path.join('assets/img/', output_file), 'w') as f:
        json.dump(manifest, f, indent=4)

#accessroute
audio_directory = 'assets/img/imagenes nasa/'
generate_audio_manifest(audio_directory)
