import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("An Azure resource ID that identifies a HorizonDB cluster.")
scalar HorizonDbClusterResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters",
    }
  ]>;

@doc("The Azure resource ID of a HorizonDB pool.")
scalar PoolResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/pools",
    }
  ]>;

@doc("Long-running operation headers returned while creating or replacing a HorizonDB resource.")
model HorizonDbResourceLroHeaders<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...ArmAsyncOperationHeader<FinalResult = Resource>;
  ...Azure.Core.Foundations.RetryAfterHeader;
}

@doc("The response returned when an asynchronous HorizonDB resource replacement is accepted.")
model HorizonDbResourceUpdatedLroResponse<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...ArmResourceUpdatedResponse<Resource>;
  ...HorizonDbResourceLroHeaders<Resource>;
}

@doc("A user-supplied description with a maximum length of 1024 characters.")
@maxLength(1024)
scalar WritableDescription extends string;

@doc("A PostgreSQL major version supported by HorizonDB. API version 2026-10-01-preview accepts 17 and 18. Future API versions may add named values, and clients must tolerate unknown values returned by the service.")
union PostgreSqlVersion {
  string,

  /** PostgreSQL major version 17. */
  V17: "17",

  /** PostgreSQL major version 18. */
  V18: "18",
}

@doc("The provisioning state.")
@lroStatus
union ProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  /** The HorizonDB resource operation is actively running. */
  InProgress: "InProgress",

  /** The HorizonDB resource is still provisioning. */
  Provisioning: "Provisioning",
}
