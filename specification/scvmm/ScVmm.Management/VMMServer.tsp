import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
@doc("The VmmServers resource definition.")
model VMMServer is TrackedResource<VMMServerProperties> {
  @doc("Name of the VMMServer.")
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("vmmServerName")
  @segment("vmmServers")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VMMServers {
  @doc("Implements VMMServer GET method.")
  get is ArmResourceRead<VMMServer>;
  @doc("Onboards the SCVMM fabric as an Azure VmmServer resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VMMServer>;
  @doc("Updates the VmmServers resource.")
  update is ArmTagsPatchAsync<VMMServer>;
  @doc("Removes the SCVMM fabric from Azure.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VMMServer,
    {
      ...BaseParameters<VMMServer>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: Force;
    }
  >;
  @doc("List of VmmServers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VMMServer>;
  @doc("List of VmmServers in a subscription.")
  listBySubscription is ArmListBySubscription<VMMServer>;
}
