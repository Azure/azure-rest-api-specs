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
  get is ArmResourceRead<ServiceResource, Error = CloudError>;

  /**
   * Creates a service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ServiceResource,
    Request = ServiceResourceCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<ServiceResource> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServiceResource> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes service with the given serviceName.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets the status of service.
   */
  list is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceListResult>,
    Error = CloudError
  >;
}

@@maxLength(ServiceResource.name, 50);
@@minLength(ServiceResource.name, 3);
@@doc(ServiceResource.name, "Cosmos DB service name.");
@@doc(ServiceResource.properties, "Services response resource.");
@@doc(ServiceResources.create::parameters.resource,
  "The Service resource parameters."
);
