import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.PowerBIDedicated;

@@clientName(Capacities.getDetails, "get", "csharp");
@@clientName(CheckCapacityNameAvailabilityParameters, "CheckCapacityNameAvailabilityContent", "csharp");
@@clientName(CheckCapacityNameAvailabilityParameters.type, "ResourceType", "csharp");
@@clientName(CapacitiesOperationGroup.checkNameAvailability, "checkNameAvailabilityCapacity", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(SkuDetailsForExistingResource, "SkuDetails", "csharp");