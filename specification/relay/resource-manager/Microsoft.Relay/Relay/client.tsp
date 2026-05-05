import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Relay;

// Preserve existing "WcfRelays" client name (was "WCFRelays" in TypeSpec)
@@clientName(WCFRelays, "WcfRelays", "java");
