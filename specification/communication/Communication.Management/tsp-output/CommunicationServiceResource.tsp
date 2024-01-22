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

namespace Microsoft.Communication;
/**
 * A class representing a CommunicationService resource.
 */
model CommunicationServiceResource
  is TrackedResource<CommunicationServiceProperties> {
  /**
   * The name of the CommunicationService resource.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[-\\w]+$")
  @path
  @key("communicationServiceName")
  @segment("communicationServices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface CommunicationServiceResources {
  /**
   * Get the CommunicationService and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_Get")
  get is ArmResourceRead<CommunicationServiceResource>;

  /**
   * Create a new CommunicationService or update an existing CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CommunicationServiceResource,
    BaseParameters<CommunicationServiceResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to update an existing CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("CommunicationServices_Update")
  update is ArmCustomPatchSync<
    CommunicationServiceResource,
    CommunicationServiceResourceUpdate
  >;

  /**
   * Operation to delete a CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_Delete")
  delete is ArmResourceDeleteAsync<
    CommunicationServiceResource,
    BaseParameters<CommunicationServiceResource>,
    ArmLroLocationHeader
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<CommunicationServiceResource>;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_ListBySubscription")
  listBySubscription is ArmListBySubscription<CommunicationServiceResource>;

  /**
   * Links an Azure Notification Hub to this communication service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_LinkNotificationHub")
  linkNotificationHub is ArmResourceActionSync<
    CommunicationServiceResource,
    LinkNotificationHubParameters,
    LinkedNotificationHub
  >;

  /**
   * Get the access keys of the CommunicationService resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_ListKeys")
  listKeys is ArmResourceActionSync<
    CommunicationServiceResource,
    void,
    CommunicationServiceKeys
  >;

  /**
   * Regenerate CommunicationService access key. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    CommunicationServiceResource,
    RegenerateKeyParameters,
    CommunicationServiceKeys
  >;

  /**
   * Checks that the CommunicationService name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationServices_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    NameAvailabilityParameters,
    CheckNameAvailabilityResponse
  >;
}

@@projectedName(CommunicationServiceResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(CommunicationServiceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CommunicationServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(CommunicationServiceResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(CommunicationServiceResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(CommunicationServiceResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(CommunicationServiceResources.linkNotificationHub::parameters.body,
  "json",
  "linkNotificationHubParameters"
);
@@extension(CommunicationServiceResources.linkNotificationHub::parameters.body,
  "x-ms-client-name",
  "linkNotificationHubParameters"
);
@@doc(CommunicationServiceResources.linkNotificationHub::parameters.body,
  "Parameters supplied to the operation."
);
@@projectedName(CommunicationServiceResources.regenerateKey::parameters.body,
  "json",
  "parameters"
);
@@extension(CommunicationServiceResources.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(CommunicationServiceResources.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
