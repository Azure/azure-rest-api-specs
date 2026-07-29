import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// All request and result models are reachable through the SIP operations and are therefore public
// in every generated SDK by default, so no per-model access or naming overrides are required here.
// This file exists to keep the client-generator ruleset applied and to provide a single place for
// future per-language client customizations, mirroring the VoiceLive realtime spec layout.
