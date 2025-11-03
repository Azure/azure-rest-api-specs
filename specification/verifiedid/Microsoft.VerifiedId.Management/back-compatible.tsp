import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;

using Microsoft.VerifiedId;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Authority.properties,
  "autorest"
);