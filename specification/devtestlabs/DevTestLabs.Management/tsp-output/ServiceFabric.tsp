import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A Service Fabric.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(User)
@includeInapplicableMetadataInPayload(false)
model ServiceFabric extends Resource {
  /**
   * The name of the service fabric.
   */
  @path
  @key("name")
  @segment("servicefabrics")
  @visibility("read")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: ServiceFabricProperties;
}

@armResourceOperations
interface ServiceFabrics {
  /**
   * Get service fabric.
   */
  get is ArmResourceRead<
    ServiceFabric,
    {
      ...BaseParameters<ServiceFabric>;

      /**
       * Specify the $expand query. Example: 'properties($expand=applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing service fabric. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceFabric>;

  /**
   * Allows modifying tags of service fabrics. All other properties will be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ServiceFabric, ServiceFabricFragment>;

  /**
   * Delete service fabric. This operation can take a while to complete.
   */
  delete is ArmResourceDeleteAsync<ServiceFabric>;

  /**
   * List service fabrics in a given user profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServiceFabrics_List")
  list is ArmResourceListByParent<
    ServiceFabric,
    {
      ...BaseParameters<ServiceFabric>;

      /**
       * Specify the $expand query. Example: 'properties($expand=applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
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
    }
  >;

  /**
   * Lists the applicable start/stop schedules, if any.
   */
  listApplicableSchedules is ArmResourceActionSync<
    ServiceFabric,
    void,
    ApplicableSchedule
  >;

  /**
   * Start a service fabric. This operation can take a while to complete.
   */
  start is ArmResourceActionAsync<ServiceFabric, void, void>;

  /**
   * Stop a service fabric This operation can take a while to complete.
   */
  stop is ArmResourceActionAsync<ServiceFabric, void, void>;
}

@@projectedName(ServiceFabrics.createOrUpdate::parameters.resource,
  "json",
  "serviceFabric"
);
@@extension(ServiceFabrics.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "serviceFabric"
);
@@doc(ServiceFabrics.createOrUpdate::parameters.resource, "A Service Fabric.");
@@projectedName(ServiceFabrics.update::parameters.properties,
  "json",
  "serviceFabric"
);
@@extension(ServiceFabrics.update::parameters.properties,
  "x-ms-client-name",
  "serviceFabric"
);
@@doc(ServiceFabrics.update::parameters.properties, "A Service Fabric.");
