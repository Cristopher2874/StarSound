import os
import json

# [Function to generate the audio available manifest]
def generate_audio_manifest(directory, output_file='sound_manifest.json'):
    # store the audio files
    sounds = []
    
    #move through the directory
    for filename in os.listdir(directory):
        #filter files
        if filename.endswith(".mp3") or filename.endswith(".wav"):
            # save the route
            sounds.append(f"assets/audio/{filename}")

    # create the manifest
    manifest = {"sounds": sounds}

    #write names
    with open(os.path.join(directory, output_file), 'w') as f:
        json.dump(manifest, f, indent=4)

audio_directory = 'assets/audio'
generate_audio_manifest(audio_directory)
