import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ScVmm;
@doc("The Clouds resource definition.")
model Cloud is TrackedResource<CloudProperties> {
  @doc("Name of the Cloud.")
  @path
  @key("cloudName")
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Cloud,
    BaseParameters<Cloud>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the Clouds resource.")
  update is ArmCustomPatchAsync<
    Cloud,
    ResourcePatch,
    BaseParameters<Cloud>,
    ArmAsyncOperationHeader
  >;

  @doc("Deregisters the ScVmm fabric cloud from Azure.")
  delete is ArmResourceDeleteAsync<
    Cloud,
    {
      ...BaseParameters<Cloud>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List of Clouds in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cloud>;

  @doc("List of Clouds in a subscription.")
  listBySubscription is ArmListBySubscription<Cloud>;
}

@@projectedName(Clouds.createOrUpdate::parameters.resource, "json", "body");
@@extension(Clouds.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Clouds.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(Clouds.update::parameters.properties, "json", "body");
@@extension(Clouds.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Clouds.update::parameters.properties, "Clouds patch payload.");
