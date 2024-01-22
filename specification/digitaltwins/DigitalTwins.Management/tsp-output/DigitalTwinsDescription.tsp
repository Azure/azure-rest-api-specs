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

namespace Microsoft.DigitalTwins;
/**
 * The description of the DigitalTwins service.
 */
model DigitalTwinsDescription is TrackedResource<DigitalTwinsProperties> {
  /**
   * The name of the DigitalTwinsInstance.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$")
  @path
  @key("resourceName")
  @segment("digitalTwinsInstances")
  name: string;
}

@armResourceOperations
interface DigitalTwinsDescriptions {
  /**
   * Get DigitalTwinsInstances resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwins_Get")
  get is ArmResourceRead<DigitalTwinsDescription>;

  /**
   * Create or update the metadata of a DigitalTwinsInstance. The usual pattern to modify a property is to retrieve the DigitalTwinsInstance and security metadata, and then combine them with the modified values in a new body to update the DigitalTwinsInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwins_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DigitalTwinsDescription>;

  /**
   * Update metadata of DigitalTwinsInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DigitalTwins_Update")
  update is ArmCustomPatchAsync<
    DigitalTwinsDescription,
    DigitalTwinsPatchDescription
  >;

  /**
   * Delete a DigitalTwinsInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwins_Delete")
  delete is ArmResourceDeleteAsync<DigitalTwinsDescription>;

  /**
   * Get all the DigitalTwinsInstances in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwins_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DigitalTwinsDescription>;

  /**
   * Get all the DigitalTwinsInstances in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwins_List")
  list is ArmListBySubscription<DigitalTwinsDescription>;

  /**
   * Check if a DigitalTwinsInstance name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DigitalTwins_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    CheckNameRequest,
    CheckNameResult
  >;
}

@@projectedName(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "json",
  "digitalTwinsCreate"
);
@@extension(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "digitalTwinsCreate"
);
@@doc(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "The DigitalTwinsInstance and security metadata."
);
@@projectedName(DigitalTwinsDescriptions.update::parameters.properties,
  "json",
  "digitalTwinsPatchDescription"
);
@@extension(DigitalTwinsDescriptions.update::parameters.properties,
  "x-ms-client-name",
  "digitalTwinsPatchDescription"
);
@@doc(DigitalTwinsDescriptions.update::parameters.properties,
  "The DigitalTwinsInstance and security metadata."
);
