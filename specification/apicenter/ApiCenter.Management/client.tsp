import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.ApiCenter;

// Preserve legacy Java header property names for compatibility
@@clientName(Azure.Core.EtagResponseEnvelope.etagHeader, "etag", "java");
