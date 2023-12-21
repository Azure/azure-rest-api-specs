import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("The VmmServers resource definition.")
model VMMServer is TrackedResource<VMMServerProperties> {
  @doc("Name of the VMMServer.")
  @path
  @key("vmmServerName")
  @segment("vmmServers")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VmmServers {
  @doc("Implements VMMServer GET method.")
  get is ArmResourceRead<VMMServer>;
  @doc("Onboards the SCVMM fabric as an Azure VmmServer resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VMMServer>;
  @doc("Updates the VmmServers resource.")
  update is ArmTagsPatchAsync<VMMServer>;
  @doc("Deboards the SCVMM fabric from Azure.")
  delete is ArmResourceDeleteAsync<
    VMMServer,
    {
      ...BaseParameters<VMMServer>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of VmmServers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VMMServer>;
  @doc("List of VmmServers in a subscription.")
  listBySubscription is ArmListBySubscription<VMMServer>;
}
