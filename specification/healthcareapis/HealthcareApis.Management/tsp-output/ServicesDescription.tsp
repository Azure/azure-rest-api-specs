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

namespace Microsoft.HealthcareApis;
/**
 * The description of the service.
 */
model ServicesDescription is TrackedResource<ServicesProperties> {
  /**
   * The name of the service instance.
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("resourceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface ServicesDescriptions {
  /**
   * Get the metadata of a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Get")
  get is ArmResourceRead<ServicesDescription>;

  /**
   * Create or update the metadata of a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServicesDescription>;

  /**
   * Update the metadata of a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<ServicesDescription, ServicesPatchDescription>;

  /**
   * Delete a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ServicesDescription>;

  /**
   * Get all the service instances in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ServicesDescription>;

  /**
   * Get all the service instances in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_List")
  list is ArmListBySubscription<ServicesDescription>;

  /**
   * Check if a service instance name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityParameters,
    ServicesNameAvailabilityInfo
  >;
}

@@projectedName(ServicesDescriptions.createOrUpdate::parameters.resource,
  "json",
  "serviceDescription"
);
@@extension(ServicesDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "serviceDescription"
);
@@doc(ServicesDescriptions.createOrUpdate::parameters.resource,
  "The service instance metadata."
);
@@projectedName(ServicesDescriptions.update::parameters.properties,
  "json",
  "servicePatchDescription"
);
@@extension(ServicesDescriptions.update::parameters.properties,
  "x-ms-client-name",
  "servicePatchDescription"
);
@@doc(ServicesDescriptions.update::parameters.properties,
  "The service instance metadata and security metadata."
);
