import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.NetAppInternal Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.NetAppInternal management service" })
@versioned(Versions)
namespace Microsoft.NetAppInternal {
  /** Contoso API versions */
  enum Versions {
    /** 2021-10-01-preview version */
    @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
    v2025_05_01_preview: "2025-05-01-preview",
  }

  @doc("storage appliance properties")
  model StorageApplianceProperties {
    @doc("The physical datacenter where the storage appliance is located")
    datacenterId: string; // Ex: /providers/Microsoft.AzureCloudMetadata/clouds/Public/datacenters/AMS08

    @doc("storage appliance rackId.")
    rackId?: string;

    @doc("The status of the last operation.")
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
  }

  @parentResource(TenantLocationResource)
  model StorageAppliance
    is Azure.ResourceManager.ProxyResource<StorageApplianceProperties> {
    @doc("The ID of the storage appliance.")
    @segment("storageAppliances")
    @key("storageApplianceId")
    @visibility(Lifecycle.Read)
    @pattern("^[A-Za-z0-9\\-]+$")
    @path
    name: string;
  }

  @armResourceOperations
  interface StorageAppliances {
    /** Get the specified network container */
    get is ArmResourceRead<StorageAppliance>;

    /** List all network containers in the location */
    list is ArmResourceListByParent<StorageAppliance>;
  }

  interface Operations extends Azure.ResourceManager.Operations {}
}
