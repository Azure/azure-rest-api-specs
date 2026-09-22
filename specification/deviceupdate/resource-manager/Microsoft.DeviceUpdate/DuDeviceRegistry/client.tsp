import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

/**
 * .NET SDK does not like the model name ends with Response
 */
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "CheckNameAvailabilityResult"
);
