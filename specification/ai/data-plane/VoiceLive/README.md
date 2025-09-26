# Azure Voice Live WebSocket API TypeSpec

This directory contains the [TypeSpec](https://typespec.io/) definitions for the Azure Voice Live WebSocket API.

## Overview

Azure Voice Live is a managed service that enables low-latency, high-quality speech-to-speech interactions for voice agents. The API consolidates speech recognition, generative AI, and text-to-speech functionalities into a single, unified WebSocket interface, providing an end-to-end solution for creating seamless voice-driven experiences.

## API Description

The Voice Live API uses WebSocket connections for real-time, bidirectional communication between clients and the service. This TypeSpec defines:

### Core Components

- **WebSocket Session Management**: Establishing and configuring real-time voice sessions
- **Audio Streaming**: Bidirectional audio data transmission for speech input and output
- **Event System**: Comprehensive event-based communication protocol for session updates, transcriptions, and responses
- **Turn Detection**: Advanced voice activity detection with semantic understanding

### Key Features

The TypeSpec defines models and operations for:

- **Real-time Speech Processing**
  - Input audio streaming with PCM format support (16kHz/24kHz)
  - Output audio generation with configurable voices
  - Live transcription and text streaming

- **AI Model Integration**
  - Support for multiple AI models (GPT-4o-realtime-preview, GPT-4o-mini-realtime-preview, phi4-mm-realtime)
  - Function calling and tool integration capabilities
  - Customizable instructions and system prompts

- **Voice Customization**
  - Standard Azure voices
  - High-definition neural voices
  - Custom voice endpoints
  - Temperature and style controls

- **Audio Enhancement**
  - Azure Semantic VAD (Voice Activity Detection) with filler word removal
  - Noise suppression
  - Echo cancellation
  - Configurable silence detection and turn management

- **Avatar Support** (Optional)
  - SDP negotiation for avatar-enabled interactions
  - Visual component synchronization with voice

### Event Types

The API defines a comprehensive event system including:

- **Client Events**: Session configuration, audio input, function responses
- **Server Events**: Audio deltas, text deltas, transcriptions, function calls, session updates

### Models

Key TypeSpec models include:

- `Session`: Configuration for voice sessions including model, voice, instructions, and tools
- `ClientEvent`: Base model for client-to-server events
- `ServerEvent`: Base model for server-to-client events
- `Turn`: Audio turn management for conversation flow
- `Item`: Conversation items including messages and function calls
- `Tool`: Function definitions for AI assistant capabilities

## Directory Structure

```
VoiceLive/
├── main.tsp              # Main entry point
├── client.tsp            # Client configuration
├── models.tsp            # Core data models
├── operations.tsp        # API operations and versioning
├── custom.tsp            # Custom type definitions
├── tspconfig.yaml        # TypeSpec configuration
├── common/               # Common shared models
│   ├── main.tsp
│   └── models.tsp
├── custom/               # Custom event and item definitions
│   ├── content_parts.tsp
│   ├── events.tsp
│   ├── items.tsp
│   └── tools.tsp
└── servers/              # Server configuration
    └── websocket.tsp    # WebSocket endpoint definition
```

## API Versions

The current API version is:
- `2025-10-01` - Latest stable version with full Voice Live capabilities

## Getting Started

### Prerequisites

- An Azure subscription
- An Azure AI Foundry resource with Voice Live enabled
- WebSocket client support

### Authentication

The Voice Live API supports:
- **Microsoft Entra ID (recommended)**: Token-based authentication with OAuth 2.0
- **API Key**: Resource key-based authentication

### WebSocket Endpoint

```
wss://<your-resource>.cognitiveservices.azure.com/voicelive/realtime
```

## SDK Generation

This TypeSpec is configured to generate SDKs for multiple languages:

- **Python**: `azure-ai-voicelive`
- **.NET**: `Azure.AI.VoiceLive`
- **JavaScript/TypeScript**: `@azure-rest/ai-voicelive`
- **Java**: `com.azure.ai.voicelive`
- **Go**: `github.com/Azure/azure-sdk-for-go/sdk/ai/voicelive`

## Related Documentation

- [Azure AI Voice Live Documentation](https://docs.microsoft.com/azure/ai-services/)
- [TypeSpec Documentation](https://typespec.io/)
- [Azure AI Foundry](https://azure.microsoft.com/products/ai-studio/)

## Contributing

This project welcomes contributions and suggestions. Please see the [Azure SDK Contributing Guide](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/README.md) for more information.