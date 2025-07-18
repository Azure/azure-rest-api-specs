import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Network;
using Azure.ClientGenerator.Core;

@@clientName(RecordSetProperties.TTL, "ttl", "java");