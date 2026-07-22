import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../AssessmentProjectsVersions.tsp";

using Http;
using Rest;
using Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("The SAS URI details if the output of the long running operation is a file.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SasUriDetails {
  @doc("The operation result sas Uri.")
  @visibility(Lifecycle.Read)
  uri: string;

  @doc("The operation result sas Uri expiration time.")
  @visibility(Lifecycle.Read)
  expiresBy: utcDateTime;
}

@doc("The properties of the operation result.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model OperationResultProperties {
  @doc("The operation result sas Uri.")
  @visibility(Lifecycle.Read)
  sasUriDetails: SasUriDetails;

  @doc("An ARM URI that can be used to access the operation result.")
  @visibility(Lifecycle.Read)
  armUri: string;
}

/** The standard operation status at the subscription level] */
@parentResource(SubscriptionLocationResource)
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model OperationResults is ArmOperationStatus<OperationResultProperties>;
