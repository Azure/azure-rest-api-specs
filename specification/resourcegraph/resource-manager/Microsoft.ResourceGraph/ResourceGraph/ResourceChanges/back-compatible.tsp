import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ResourceChanges;

// @@clientName(ResourceChangesRequestParameters.$skipToken, "skipToken");
// @@clientName(ResourceChangesRequestParameters.$top, "top");

// @@clientName(ResourceChangeList.$skipToken, "skipToken");

@@clientName(resourceChangeDetails::parameters.body, "parameters");
@@clientName(resourceChanges::parameters.body, "parameters");
