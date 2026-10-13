import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./NeuroShield.tsp";
import "./NeuroShieldProtectedResource.tsp";
import "./NeuroShieldFinding.tsp";
import "./NeuroShieldMitigation.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/** Microsoft.NetworkSecurity NeuroShield management API. */
@armProviderNamespace("Microsoft.NetworkSecurity")
@service(#{ title: "Microsoft.NetworkSecurity NeuroShield management service" })
@versioned(NeuroShield.Management.Versions)
namespace NeuroShield.Management;

/** The available API versions. */
enum Versions {
  /** 2026-06-01-preview version */
  @Azure.Core.previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_01_preview: "2026-06-01-preview",
}

/** The operations available from the Microsoft.NetworkSecurity provider. */
@added(Versions.v2026_06_01_preview)
interface Operations extends Azure.ResourceManager.Operations {}

/** Parameters for subscription- and location-scoped NeuroShield operation status. */
alias NeuroShieldOperationStatusParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;

  @path
  @segment("providers")
  @doc("The provider namespace.")
  provider: "Microsoft.NetworkSecurity";

  ...LocationResourceParameter;
  ...Azure.ResourceManager.CommonTypes.OperationIdParameter;
};

@@segment(
  NeuroShieldOperationStatusParameters.operationId,
  "neuroShieldOperationStatuses"
);
@@doc(
  NeuroShieldOperationStatusParameters.operationId,
  "The ID of an ongoing asynchronous NeuroShield operation."
);

@added(Versions.v2026_06_01_preview)
@armResourceOperations
interface NeuroShieldOperationStatuses {
  /** Gets the status of an asynchronous NeuroShield operation. */
  @autoRoute
  @get
  get is ArmReadOperation<
    NeuroShieldOperationStatusParameters,
    ArmResponse<OperationStatusResult>,
    ErrorResponse
  >;
}
