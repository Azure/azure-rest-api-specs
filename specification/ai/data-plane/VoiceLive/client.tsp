import "@azure-tools/typespec-client-generator-core";
import "./servers/websocket.tsp";

using Azure.ClientGenerator.Core;

@@access(VoiceLive.VoiceLiveServerEventSessionCreated, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseAudioDelta, Access.public, "python");


