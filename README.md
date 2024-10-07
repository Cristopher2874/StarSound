# StarSound

StarSound is a Flutter application that allows users to explore the universe through music inspired by the images from James Webb Space Telescope. The app includes four main modules: a homepage with theme music, an information page about the telescope, an interactive feed where users can create their own music based on the brightest zones in astronomical images, and a test infinite scrolling page to access other user's creations and unique musical videos.

## Project WalkThrough

For a better approach to the app and the project, we encourage the visitors to go to WalkThrough folder and find the main steps and detailed explanations of the functionality and ideas such as:
- [Project Demo]()
- [Resources](WalkThrough/Resources.md) - **Credits and links**
- [Project Details](WalkThrough/Resources.md) - **Process to create StarSound**

## Features

- **Main Page with Theme Music**: The homepage welcomes users with theme music, creating an immersive introduction to the universe of StarSound.
- **James Webb Telescope Information**: An informative section where users can learn about the James Webb Space Telescope, its discoveries, and its importance in the study of space.
- **Feed for Music Creation**: Users can select images from the James Webb telescope, and based on the brightest zones detected in these images, the app places interactive buttons. When clicked, these buttons produce sounds, allowing users to create their own cosmic music with keyboard, triangle, sintetizer, electric keyboard and other instrumental samples.
- **Scroll Page**: The idea if the app, is that after the user has created a unique brief video using the JWT images as base and their own sound mix, the users can record and upload the videos with the music patterns created by their own and look for inspiration in other user's publications. This screen is a test for further development to share videos with the community.

## Project Structure

```bash
StarSoundApp/
│
├── lib/
│   ├── main.dart                # Main page with the images and music
│   └── slides/
│       ├── feed.dart       # Interactive feed for creating music based on images
│       ├── webbInfo.dart       # Information page about the James Webb Space Telescope
│       ├── scroll.dart          # Test page for shared videos with music
│       └── audio_manager.dart    # Handles audio playback functionality
├── assets/
│   ├── img/           # Store background images and icons
│   ├── json/          #store the main json files for coordinates and image display info
│   └── audio/         # Audio files for theme music and sound generation
│
ImageProcess/
│
├── ImageProcess/                 # Image processing folder
│   └── getCoordinates.py          # Python script to detect brightest zones and return coordinates
│
WalkThrough/
│
├── lib/
│   ├── main.dart                # Main page with the images and music
│   └── slides/
│       ├── feed.dart       # Interactive feed for creating music based on images
│       ├── webbInfo.dart       # Information page about the James Webb Space Telescope
│       ├── scroll.dart          # Test page for shared videos with music
│       └── audio_manager.dart    # Handles audio playback functionality
├── assets/
│   ├── img/           # Store background images and icons
│   ├── json/          #store the main json files for coordinates and image display info
│   └── audio/         # Audio files for theme music and sound generation
│
└── Project Presentation  # Project presentation for Xalapa NasaSpace Apps event

```

## Modules

### 1. **Main Page with Theme Music**
   - The main page welcomes users with theme music. It sets the tone for the experience and invites users to explore the other features of the app.
   - The theme music plays automatically upon landing on the home page.
   - the James Webb Image leads to endless posibilities in music

### 2. **James Webb Telescope Information Page**
   - This page provides fascinating details about the James Webb Space Telescope, including how it works, the types of signals it captures (like infrared light), and its role in understanding the universe.
   - User have access to the main points of the mission and could continue learning in the Nasa official web-site

### 3. **Music feed**
   - The Feed page uses the current image given to the user and generates the button layout
   - The `imageprocess` folder contains a Python script that processes the image, detects the brightest zones, and returns the coordinates of these zones.
   - The app then places interactive buttons on the detected coordinates. When users click these buttons, they generate sounds, allowing them to create their own cosmic melodies.
   - There is a full library of sounds of keyboards, triangles, sintetizer and other instruments available.
   - Each placed button plays a sound and the user can combine the sounds ¡like if the image is a musical intrument itself!

### 4. **Test Infinite Scrolling Page**
   - This page is a test mode of the scroll designed for the users to access to public video generated by other users.
   - It is loaded with images, but in the future, it could be endless videos of music created with the JWT images.
   - The idea is to share each local video, and sharing the music, the images and JWT information is also shared.

## Image Processing

The `imageProcess/getCoordinates.py` script processes the uploaded images and detects the brightest areas. The detected coordinates are then passed to the Flutter app, where buttons are dynamically placed at those positions. This process must be followed by the developer, but in the final further version, the app should be able to do by itself

1. **Input**: Users selects an image from the James Webb telescope. (Currently, the developer has to select the image and upload the data to the app, mainly, the button coordinates)
2. **Processing**: The Python script analyzes the image, identifying the brightest zones.
3. **Output**: The coordinates are sent back to Flutter, which places interactive buttons for sound generation.

## Usage
- Navigate through the app using the menu options or buttons.
- Click on James Webb Telescope image to discover the music
- Explore the main page for theme music, the information page to learn about space, and the feed to create music based on astronomical images.
- Click on the *Explore* button, discover endless posibilities created by the community

### Installation For Local Usage (optional)

Follow these steps to install and run StarSound on your local machine (waiting for official launch of the web and Android app):

#### Prerequisites

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- An editor like Visual Studio Code or Android Studio
- Android or iOS Emulator (or a physical device)

#### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/starsound.git
   cd starsound
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```