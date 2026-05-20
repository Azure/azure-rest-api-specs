import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Fabric model.
 */
model FabricModel
  is Azure.ResourceManager.TrackedResource<FabricModelProperties> {
  ...ResourceNameParameter<
    Resource = FabricModel,
    KeyName = "fabricName",
    SegmentName = "replicationFabrics",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(Fabric.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(Fabric.update::parameters.properties,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface Fabric {
  /**
   * Gets the details of the fabric.
   */
  get is ArmResourceRead<FabricModel>;

  /**
   * Creates the fabric.
   */
  create is ArmResourceCreateOrReplaceAsync<FabricModel>;

  /**
   * Performs update on the fabric.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<FabricModel, FabricModelUpdate>;

  /**
   * Removes the fabric.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FabricModel>;

  /**
   * Gets the list of fabrics in the given subscription and resource group.
   */
  list is ArmResourceListByParent<
    FabricModel,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<FabricModel>;

      /**
       * Continuation token from the previous call.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  /**
   * Gets the list of fabrics in the given subscription.
   */
  listBySubscription is ArmListBySubscription<FabricModel>;
}

@@doc(FabricModel.name, "The fabric name.");
@@doc(Fabric.create::parameters.resource, "Fabric properties.");
@@doc(Fabric.update::parameters.properties, "Fabric properties.");
