# StarSound

StarSound is a Flutter application that allows users to explore the universe through music inspired by the James Webb Space Telescope. The app includes three main modules: a homepage with theme music, an information page about the telescope, and an interactive playground where users can create their own music based on the brightest zones in astronomical images.

## Features

- **Main Page with Theme Music**: The homepage welcomes users with theme music, creating an immersive introduction to the universe of StarSound.
- **James Webb Telescope Info**: An informative section where users can learn about the James Webb Space Telescope, its discoveries, and its importance in the study of space.
- **Playground for Music Creation**: Users can upload images from the James Webb telescope, and based on the brightest zones detected in these images, the app places interactive buttons. When clicked, these buttons produce sounds, allowing users to create their own cosmic music.

## Installation

Follow these steps to install and run StarSound on your local machine:

### Prerequisites

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- An editor like Visual Studio Code or Android Studio
- Android or iOS Emulator (or a physical device)

### Setup

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

## Project Structure

```bash
StarSound/
│
├── lib/
│   ├── main.dart                # Main entry point for the application
│   ├── pages/
│   │   ├── home_page.dart       # Home page with theme music
│   │   ├── info_page.dart       # Information page about the James Webb Space Telescope
│   │   └── playground_page.dart # Interactive playground for creating music based on images
│   └── utils/
│       └── audio_player.dart    # Handles audio playback functionality
│
├── imageprocess/                 # Image processing folder
│   └── process_image.py          # Python script to detect brightest zones and return coordinates
│
└── assets/
    ├── images/                   # Store background images and icons
    └── sounds/                   # Audio files for theme music and sound generation
```

## Modules

### 1. **Main Page with Theme Music**
   - The main page welcomes users with theme music. It sets the tone for the experience and invites users to explore the other features of the app.
   - The theme music plays automatically upon landing on the home page and can be paused or resumed with a dedicated button.

### 2. **James Webb Telescope Information Page**
   - This page provides fascinating details about the James Webb Space Telescope, including how it works, the types of signals it captures (like infrared light), and its role in understanding the universe.
   - Users can navigate this section to learn about the life cycle of stars, the search for exoplanets, and the collaboration with other telescopes like Hubble.

### 3. **Music Playground**
   - The playground allows users to upload images (e.g., those taken by the James Webb telescope).
   - The `imageprocess` folder contains a Python script that processes the image, detects the brightest zones, and returns the coordinates of these zones.
   - The app then places interactive buttons on the detected coordinates. When users click these buttons, they generate sounds, allowing them to create their own cosmic melodies.

## Image Processing

The `imageprocess/process_image.py` script processes the uploaded images and detects the brightest areas. The detected coordinates are then passed to the Flutter app, where buttons are dynamically placed at those positions.

1. **Input**: Users upload an image from the James Webb telescope.
2. **Processing**: The Python script analyzes the image, identifying the brightest zones.
3. **Output**: The coordinates are sent back to Flutter, which places interactive buttons for sound generation.

## Usage

- Navigate through the app using the menu options or buttons.
- Explore the main page for theme music, the information page to learn about space, and the playground to create music based on astronomical images.
  
## Contributions

Feel free to submit pull requests or open issues if you encounter bugs or have feature suggestions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.