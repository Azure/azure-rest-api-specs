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
 * A Service Fabric.
 */
@parentResource(Lab)
model ServiceFabric
  is Azure.ResourceManager.TrackedResource<ServiceFabricProperties> {
  ...ResourceNameParameter<
    Resource = ServiceFabric,
    KeyName = "name",
    SegmentName = "servicefabrics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceFabrics {
  /**
   * Get service fabric.
   */
  get is ArmResourceRead<
    ServiceFabric,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing Service Fabric. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceFabric,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of service fabrics. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServiceFabric,
    PatchModel = ServiceFabricFragment
  >;

  /**
   * Delete service fabric. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceFabric,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List service fabrics in a given user profile.
   */
  list is ArmResourceListByParent<
    ServiceFabric,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;

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
    Response = ArmResponse<ServiceFabricList>
  >;

  /**
   * Lists the applicable start/stop schedules, if any.
   */
  listApplicableSchedules is ArmResourceActionSync<
    ServiceFabric,
    void,
    ArmResponse<ApplicableSchedule>
  >;

  /**
   * Start a service fabric. This operation can take a while to complete.
   */
  start is ArmResourceActionAsync<ServiceFabric, void, OkResponse>;

  /**
   * Stop a service fabric This operation can take a while to complete.
   */
  stop is ArmResourceActionAsync<ServiceFabric, void, OkResponse>;
}

@@doc(ServiceFabric.name, "The name of the service fabric.");
@@doc(ServiceFabric.properties, "The properties of the resource.");
@@doc(ServiceFabrics.createOrUpdate::parameters.resource, "A Service Fabric.");
@@doc(ServiceFabrics.update::parameters.properties,
  "Allows modifying tags of service fabrics. All other properties will be ignored."
);
