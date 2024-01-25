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

namespace Microsoft.OpenEnergyPlatform;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(EnergyServiceProperties)
model EnergyService extends TrackedResourceBase {
  /**
   * The resource name.
   */
  @path
  @key("resourceName")
  @segment("energyServices")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: EnergyServiceProperties;
}

@armResourceOperations
interface EnergyServices {
  /**
   * Returns oep resource for a given name.
   */
  get is ArmResourceRead<EnergyService>;

  /**
   * Method that gets called if subscribed for ResourceCreationBegin trigger.
   */
  create is ArmResourceCreateOrReplaceAsync<
    EnergyService,
    BaseParameters<EnergyService>,
    ArmAsyncOperationHeader
  >;

  @parameterVisibility("read")
  update is ArmCustomPatchSync<EnergyService, EnergyResourceUpdate>;

  /**
   * Deletes oep resource
   */
  delete is ArmResourceDeleteAsync<EnergyService>;

  /**
   * Returns list of oep resources..
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EnergyServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EnergyService>;

  /**
   * Lists a collection of oep resources under the given Azure Subscription ID.
   */
  listBySubscription is ArmListBySubscription<EnergyService>;

  /**
   * Method that gets called if new partition is to be added in a resource.
   */
  addPartition is ArmResourceActionNoResponseContentAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest
  >;

  /**
   * Method that gets called if new partition is to be removed from a resource.
   */
  removePartition is ArmResourceActionNoResponseContentAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest
  >;

  /**
   * Method that gets called when list of partitions is requested.
   */
  listPartitions is ArmResourceActionSync<
    EnergyService,
    void,
    DataPartitionsListResult
  >;
}

@@projectedName(EnergyServices.create::parameters.resource, "json", "body");
@@extension(EnergyServices.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(EnergyServices.create::parameters.resource, "Request body.");
@@projectedName(EnergyServices.update::parameters.properties, "json", "body");
@@extension(EnergyServices.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(EnergyServices.update::parameters.properties, "");
@@doc(EnergyServices.addPartition::parameters.body,
  "add partition action payload"
);
@@doc(EnergyServices.removePartition::parameters.body,
  "remove partition action payload"
);
