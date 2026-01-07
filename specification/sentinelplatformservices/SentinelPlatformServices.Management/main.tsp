import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.SentinelPlatformServices Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.SentinelPlatformServices management service" })
@versioned(Versions)
namespace Microsoft.SentinelPlatformServices;

/** The available API versions. */
enum Versions {
  /** 2025-04-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_01_preview: "2025-04-01-preview",
}

@doc("A SentinelPlatformServices resource")
model SentinelPlatformService
  is TrackedResource<SentinelPlatformServicesProperties> {
  @doc("Name of SentinelPlatformServices resource")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @key("name")
  @path
  @segment("sentinelPlatformServices")
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("SentinelPlatformServices properties")
model SentinelPlatformServicesProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is in an unknown state")
  Unknown: "Unknown",

  @doc("The resource is creating")
  Creating: "Creating",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",

  @doc("The resource creation has succeeded")
  Succeeded: "Succeeded",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface SentinelPlatformServices {
  get is ArmResourceRead<SentinelPlatformService>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<SentinelPlatformService>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    SentinelPlatformService,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SentinelPlatformService,
      SentinelPlatformServicesProperties
    >
  >;
  delete is ArmResourceDeleteSync<SentinelPlatformService>;
  listByResourceGroup is ArmResourceListByParent<SentinelPlatformService>;
  listBySubscription is ArmListBySubscription<SentinelPlatformService>;
}
