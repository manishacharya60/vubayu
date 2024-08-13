# Vubayu - Soil Analysis Tool

An innovative soil analysis app developed as part of the Gemini API Development Competition by Manish, and Aamod. This app allows users to explore and visualize various soil properties and environmental factors through interactive charts and detailed insights, leveraging Google’s Gemini API. Vubayu is derived from Nepali word where `Vu` means Land and `Bayu` means air.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Gemini API Integration](#gemini-api-integration)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Overview

This app offers a sleek and intuitive interface where users can upload soil images, specify the location and season, and gain a comprehensive understanding of soil health. The app transforms user inputs into meaningful, personalized content, providing an interactive and engaging experience.

## Key Features

- **Soil Health Visualization:** Upload images and input soil data to visualize key properties.
- **Interactive Insights:** Tap on charts to unlock detailed explanations and deeper insights into each soil property.
- **Environmental Impact Analysis:** Understand the environmental implications of soil conditions.
- **Personalized Content Generation:** The Gemini API generates custom reports and insights based on soil samples.

## Gemini API Integration

- **Content/Report Generation:** Analyzes user inputs to generate personalized content and insights about soil health, highlighting key soil properties and environmental impacts.
- **Image Processing:** Processes uploaded soil images, extracting data for analysis and visualization.
- **Interactive Dialogues:** Powers dynamic content in the app’s interactive dialogues, providing detailed explanations.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK installed on your machine. You can download it from [Flutter's official website](https://flutter.dev).
- A Gemini API key, which can be obtained from Google Cloud's API Console.
- A code editor like Visual Studio Code or Android Studio.

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/manishacharya60/vubayu.git
   cd vubayu
   ```

2. **Install Dependencies:**

   Navigate to the project directory and install the necessary packages:

   ```bash
   flutter pub get
   ```

3. **Set Up the Gemini API Key:**

   You'll need to provide your Gemini API key when running the app. Use the following command:

   ```bash
   flutter run --dart-define=API_KEY=<<YOUR API KEY>>
   ```

### Running the App

1. **Run the App:**

   Use the following command to run the app:

   ```bash
   flutter run --dart-define=API_KEY=<<YOUR API KEY>>
   ```

2. **Sign In:**

   Use the following credentials to log in:

   - **Email:** manish.dev2060@gmail.com
   - **Password:** 12345

## Usage

### Step 1: Upload Soil Image

- **Select Image Source:** On the home screen, choose to either take a new photo or upload one from your gallery.

### Step 2: Input Soil Data

- **Enter Location:** Input your current location or the location where the soil was sampled.
- **Choose Time and Season:** Select the time of day and season during which the soil image was captured.
- **Confirm Inputs:** Ensure all inputs are correct and tap the "Save" button to process the data.

### Step 3: Explore Soil Visualization

- **View Visualization:** After processing, explore the soil health visualization displayed on the screen.
- **Tap on Charts:** Tap on any chart or graph to open a detailed dialog with in-depth explanations powered by the Gemini API.

### Step 4: Access Environmental Impact Analysis

- **Scroll Down:** Continue scrolling to view the environmental impact analysis section.
- **Review Data:** Review the real-time data processing results, including the environmental implications of the soil condition.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Acknowledgements

- Thanks to Google for providing the Gemini API.
