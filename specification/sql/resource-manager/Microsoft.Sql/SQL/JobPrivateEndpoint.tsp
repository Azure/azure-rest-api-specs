import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A job agent private endpoint.
 */
@parentResource(JobAgent)
model JobPrivateEndpoint
  is Azure.ResourceManager.ProxyResource<JobPrivateEndpointProperties> {
  ...ResourceNameParameter<
    Resource = JobPrivateEndpoint,
    KeyName = "privateEndpointName",
    SegmentName = "privateEndpoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JobPrivateEndpoints {
  /**
   * Gets a private endpoint.
   */
  get is ArmResourceRead<JobPrivateEndpoint>;

  /**
   * Creates or updates a private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    JobPrivateEndpoint,
    Response = ArmResourceUpdatedResponse<JobPrivateEndpoint> | ArmResourceCreatedResponse<
      JobPrivateEndpoint,
      ArmLroLocationHeader<FinalResult = JobPrivateEndpoint> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    JobPrivateEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of job agent private endpoints.
   */
  listByAgent is ArmResourceListByParent<JobPrivateEndpoint>;
}

@@doc(JobPrivateEndpoint.name, "The name of the private endpoint to get.");
@@doc(JobPrivateEndpoint.properties, "Resource properties.");
@@doc(JobPrivateEndpoints.createOrUpdate::parameters.resource,
  "The requested private endpoint state."
);
