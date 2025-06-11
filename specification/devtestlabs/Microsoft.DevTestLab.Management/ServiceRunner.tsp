import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A container for a managed identity to execute DevTest lab services.
 */
model ServiceRunner
  is Azure.ResourceManager.TrackedResource<ServiceRunnerProperties> {
  ...ResourceNameParameter<
    Resource = ServiceRunner,
    KeyName = "name",
    SegmentName = "servicerunners",
    NamePattern = ""
  >;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
}

@armResourceOperations
interface ServiceRunners {
  /**
   * Get service runner.
   */
  get is ArmResourceRead<ServiceRunner>;

  /**
   * Create or replace an existing Service runner. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceRunner,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete service runner. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceRunner,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List service runners in a given lab.
   */
  list is ArmResourceListByParent<
    ServiceRunner,
    Parameters = {
      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<ServiceRunnerList>
  >;
}

@@doc(ServiceRunner.name, "The name of the service runner.");
@@doc(ServiceRunner.properties, "The properties of the resource.");
@@doc(ServiceRunners.createOrUpdate::parameters.resource,
  "A container for a managed identity to execute DevTest lab services."
);
