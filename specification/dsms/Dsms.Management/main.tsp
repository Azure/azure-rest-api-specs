import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";
import "./endpoint.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Dsms Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Dsms management service" })
@versioned(Versions)
namespace Microsoft.Dsms;

/** Microsoft.Dsms API versions */
enum Versions {
  /** 2025-08-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01_preview: "2025-08-01-preview",
}

/** Endpoint properties */
model EndpointProperties {
  @doc("The hostname for the endpoint")
  hostname?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The provisioning state of a resource. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}
