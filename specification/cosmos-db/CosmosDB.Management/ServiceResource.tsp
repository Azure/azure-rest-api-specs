import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * Properties for the database account.
 */
@parentResource(DatabaseAccountGetResults)
model ServiceResource
  is Azure.ResourceManager.ProxyResource<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Gets the status of service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Service_Get")
  get is ArmResourceRead<ServiceResource>;

  /**
   * Creates a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Service_Create")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ServiceResource,
    Request = ServiceResourceCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<ServiceResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServiceResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes service with the given serviceName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Service_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the status of service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Service_List")
  list is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceListResult>
  >;
}

@@maxLength(ServiceResource.name, 50);
@@minLength(ServiceResource.name, 3);
@@doc(ServiceResource.name, "Cosmos DB service name.");
@@doc(ServiceResource.properties, "Services response resource.");
@@doc(ServiceResources.create::parameters.resource,
  "The Service resource parameters."
);
