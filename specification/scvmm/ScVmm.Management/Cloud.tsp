import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
@doc("The Clouds resource definition.")
model Cloud is TrackedResource<CloudProperties> {
  @doc("Name of the Cloud.")
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("cloudResourceName")
  @segment("clouds")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Clouds {
  @doc("Implements Cloud GET method.")
  get is ArmResourceRead<Cloud>;
  @doc("Onboards the ScVmm fabric cloud as an Azure cloud resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Cloud>;
  @doc("Updates the Clouds resource.")
  update is ArmTagsPatchAsync<Cloud>;
  @doc("Deregisters the ScVmm fabric cloud from Azure.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Cloud,
    {
      ...BaseParameters<Cloud>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: Force;
    }
  >;
  @doc("List of Clouds in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cloud>;
  @doc("List of Clouds in a subscription.")
  listBySubscription is ArmListBySubscription<Cloud>;
}
