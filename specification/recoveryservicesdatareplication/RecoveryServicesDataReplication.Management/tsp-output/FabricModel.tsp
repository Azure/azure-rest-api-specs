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

namespace Microsoft.DataReplication;
/**
 * Fabric model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(FabricModelProperties)
@includeInapplicableMetadataInPayload(false)
model FabricModel extends TrackedResourceBase {
  /**
   * The fabric name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("fabricName")
  @segment("replicationFabrics")
  name: string;

  /**
   * Fabric model properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: FabricModelProperties;
}

@armResourceOperations
interface FabricModels {
  /**
   * Gets the details of the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Fabric_Get")
  get is ArmResourceRead<FabricModel>;

  /**
   * Creates the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Fabric_Create")
  create is ArmResourceCreateOrReplaceAsync<
    FabricModel,
    BaseParameters<FabricModel>,
    ArmLroLocationHeader
  >;

  /**
   * Performs update on the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Fabric_Update")
  update is ArmCustomPatchAsync<
    FabricModel,
    FabricModelUpdate,
    BaseParameters<FabricModel>,
    ArmLroLocationHeader
  >;

  /**
   * Removes the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Fabric_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    FabricModel,
    BaseParameters<FabricModel>,
    ArmLroLocationHeader
  >;

  /**
   * Gets the list of fabrics in the given subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Fabric_List")
  list is ArmResourceListByParent<
    FabricModel,
    {
      ...BaseParameters<FabricModel>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Fabric_ListBySubscription")
  listBySubscription is ArmListBySubscription<FabricModel>;
}

@@projectedName(FabricModels.create::parameters.resource, "json", "body");
@@extension(FabricModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(FabricModels.create::parameters.resource, "Fabric properties.");
@@projectedName(FabricModels.update::parameters.properties, "json", "body");
@@extension(FabricModels.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(FabricModels.update::parameters.properties, "Fabric properties.");
