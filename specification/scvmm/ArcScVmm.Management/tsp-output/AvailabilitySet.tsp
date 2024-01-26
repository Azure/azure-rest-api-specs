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
/**
 * The AvailabilitySets resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AvailabilitySetProperties)
model AvailabilitySet extends TrackedResourceBase {
  /**
   * Name of the AvailabilitySet.
   */
  @path
  @key("availabilitySetName")
  @segment("availabilitySets")
  @visibility("read")
  name: string;

  /**
   * The extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AvailabilitySetProperties;
}

@armResourceOperations
interface AvailabilitySets {
  /**
   * Implements AvailabilitySet GET method.
   */
  get is ArmResourceRead<AvailabilitySet>;

  /**
   * Onboards the ScVmm availability set as an Azure resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AvailabilitySet,
    BaseParameters<AvailabilitySet>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the AvailabilitySets resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    AvailabilitySet,
    ResourcePatch,
    BaseParameters<AvailabilitySet>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deregisters the ScVmm availability set from Azure.
   */
  delete is ArmResourceDeleteAsync<
    AvailabilitySet,
    {
      ...BaseParameters<AvailabilitySet>;

      /**
       * Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of AvailabilitySets in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AvailabilitySets_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AvailabilitySet>;

  /**
   * List of AvailabilitySets in a subscription.
   */
  listBySubscription is ArmListBySubscription<AvailabilitySet>;
}

@@projectedName(AvailabilitySets.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(AvailabilitySets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(AvailabilitySets.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(AvailabilitySets.update::parameters.properties, "json", "body");
@@extension(AvailabilitySets.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(AvailabilitySets.update::parameters.properties,
  "AvailabilitySets patch payload."
);
