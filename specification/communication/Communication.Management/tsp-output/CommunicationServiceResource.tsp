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
@doc("A class representing a CommunicationService resource.")
model CommunicationServiceResource
  is TrackedResource<CommunicationServiceProperties> {
  @doc("The name of the CommunicationService resource.")
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the CommunicationService and its properties.")
  @operationId("CommunicationServices_Get")
  get is ArmResourceRead<CommunicationServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new CommunicationService or update an existing CommunicationService.")
  @operationId("CommunicationServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CommunicationServiceResource,
    BaseParameters<CommunicationServiceResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an existing CommunicationService.")
  @operationId("CommunicationServices_Update")
  update is ArmCustomPatchSync<
    CommunicationServiceResource,
    CommunicationServiceResourceUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a CommunicationService.")
  @operationId("CommunicationServices_Delete")
  delete is ArmResourceDeleteAsync<
    CommunicationServiceResource,
    BaseParameters<CommunicationServiceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a resource group.")
  @operationId("CommunicationServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<CommunicationServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a subscription.")
  @operationId("CommunicationServices_ListBySubscription")
  listBySubscription is ArmListBySubscription<CommunicationServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Links an Azure Notification Hub to this communication service.")
  @operationId("CommunicationServices_LinkNotificationHub")
  linkNotificationHub is ArmResourceActionSync<
    CommunicationServiceResource,
    LinkNotificationHubParameters,
    LinkedNotificationHub
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the access keys of the CommunicationService resource.")
  @operationId("CommunicationServices_ListKeys")
  listKeys is ArmResourceActionSync<
    CommunicationServiceResource,
    void,
    CommunicationServiceKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerate CommunicationService access key. PrimaryKey and SecondaryKey cannot be regenerated at the same time.")
  @operationId("CommunicationServices_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    CommunicationServiceResource,
    RegenerateKeyParameters,
    CommunicationServiceKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the CommunicationService name is valid and is not already in use.")
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
