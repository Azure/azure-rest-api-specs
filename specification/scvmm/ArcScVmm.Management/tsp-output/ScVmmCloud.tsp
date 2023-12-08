import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("The Clouds resource definition.")
model ScVmmCloud is TrackedResource<CloudProperties> {
  @doc("Name of the Cloud.")
  @path
  @key("cloudName")
  @segment("clouds")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface ScVmmClouds {
  @doc("Implements Cloud GET method.")
  get is ArmResourceRead<ScVmmCloud>;
  @doc("Onboards the ScVmm fabric cloud as an Azure cloud resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScVmmCloud>;
  @doc("Updates the Clouds resource.")
  update is ArmTagsPatchAsync<ScVmmCloud>;
  @doc("Deregisters the ScVmm fabric cloud from Azure.")
  delete is ArmResourceDeleteAsync<
    ScVmmCloud,
    {
      ...BaseParameters<ScVmmCloud>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of Clouds in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ScVmmCloud>;
  @doc("List of Clouds in a subscription.")
  listBySubscription is ArmListBySubscription<ScVmmCloud>;
}
