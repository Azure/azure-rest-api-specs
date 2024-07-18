import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Fabric {
  @@access(Operations.list, Access.internal, "csharp");

  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest, "FabricCheckNameAvailabilityContent", "csharp");
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse, "FabricCheckNameAvailabilityResult", "csharp");
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason, "FabricNameUnavailableReason", "csharp");
  @@clientName(ProvisioningState, "FabricProvisioningState", "csharp");
  @@clientName(ResourceState, "FabricResourceState", "csharp");
  @@clientName(RpSkuDetailsForNewResource, "FabricSkuDetailsForNewCapacity", "csharp");
  @@clientName(RpSkuDetailsForExistingResource, "FabricSkuDetailsForExistingCapacity", "csharp");
  @@clientName(RpSku, "FabricSku", "csharp");
  @@clientName(RpSkuTier, "FabricSkuTier", "csharp");
}
