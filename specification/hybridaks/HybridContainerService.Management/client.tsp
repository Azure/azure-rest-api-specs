import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.HybridContainerService;

@@Azure.ClientGenerator.Core.clientName(HybridIdentityMetadataOperationGroup,
  "HybridIdentityMetadata"
);
