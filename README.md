# Realtime Video Stream

A Flutter project for video streaming with real-time events and push notification handling.

## Overview

This project allows streaming videos from **YouTube** or a **server-hosted source**, integrating **real-time events** through WebSockets and handling **push notifications**. Notifications can directly open the video screen, and the app updates like counts and viewer events in real-time.

The architecture follows a clean pattern with **Repository → DataSource → Cubit**, **dependency injection**, and **GoRouter** for navigation.

## Features

### Video Streaming
- Play YouTube videos via ID or URL.
- Play server-hosted MP4 videos via direct links.
- Video player features:
  - Play, pause, seek, fullscreen.
  - Buffering indicator and playback error handling.
- Automatically selects the appropriate player based on video source type.
- Dummy video URLs are used for testing.

### Real-time Socket Integration
- Connects to a Socket.io server.
- Receives events such as:
  - Like count updates.
  - Viewer joined events.
- Sends playback status events (`playing` / `paused`).
- UI updates instantly based on incoming events.

### Push Notifications
- Integrated with **Firebase Cloud Messaging**.
- Handles notifications in:
  - Foreground
  - Background
  - Terminated states
- Notifications navigate directly to the video screen.
- Payloads may include video URL or metadata.
- Works while the video screen is open or closed.

### User Interface
- **Main Screen**: Buttons to play YouTube or server-hosted videos.
- **Video Screen**:
  - Video player with custom controls.
  - Real-time like count display.
  - Temporary message when a new viewer joins.
  - Socket connection status indicator.

## Architecture
- **Cubit (Bloc)**: State management.
- **Repository**: Handles business logic.
- **DataSource**: Handles network and WebSocket communication.
- **Dependency Injection**: Provides modular, testable code.
- **GoRouter**: Handles routing and deep linking.

## Getting Started

1. **Clone the repository**
```bash
git clone <repo_url>
cd realtime_video_stream_task
