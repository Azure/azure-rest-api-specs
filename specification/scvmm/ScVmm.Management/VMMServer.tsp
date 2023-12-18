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
model VmmServer is TrackedResource<VmmServerProperties> {
  @doc("Name of the VmmServer.")
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
interface VmmServers {
  @doc("Implements VmmServer GET method.")
  get is ArmResourceRead<VmmServer>;
  @doc("Onboards the SCVmm fabric as an Azure VmmServer resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VmmServer>;
  @doc("Updates the VmmServers resource.")
  update is ArmTagsPatchAsync<VmmServer>;
  @doc("Removes the SCVmm fabric from Azure.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VmmServer,
    {
      ...BaseParameters<VmmServer>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: Force;
    }
  >;
  @doc("List of VmmServers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VmmServer>;
  @doc("List of VmmServers in a subscription.")
  listBySubscription is ArmListBySubscription<VmmServer>;
}
