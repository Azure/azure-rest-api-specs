import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DedicatedHostGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the Dedicated host.
 */
@parentResource(DedicatedHostGroup)
model DedicatedHost
  is Azure.ResourceManager.TrackedResource<DedicatedHostProperties> {
  ...ResourceNameParameter<
    Resource = DedicatedHost,
    KeyName = "hostName",
    SegmentName = "hosts",
    NamePattern = ""
  >;

  /**
   * SKU of the dedicated host for Hardware Generation and VM family. Only name is required to be set. List Microsoft.Compute SKUs for a list of possible values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;
}

@armResourceOperations
interface DedicatedHosts {
  /**
   * Retrieves information about a dedicated host.
   */
  get is ComputeResourceRead<
    DedicatedHost,
    Parameters = {
      /**
       * The expand expression to apply on the operation. 'InstanceView' will retrieve the list of instance views of the dedicated host. 'UserData' is not supported for dedicated host.
       */
      @query("$expand")
      $expand?: InstanceViewTypes;
    }
  >;

  /**
   * Create or update a dedicated host .
   */
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    DedicatedHost,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a dedicated host .
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    DedicatedHost,
    DedicatedHostUpdate,
    Response = ArmResponse<DedicatedHost> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a dedicated host.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<DedicatedHost>;

  /**
   * Lists all of the dedicated hosts in the specified dedicated host group. Use the nextLink property in the response to get the next page of dedicated hosts.
   */
  listByHostGroup is ComputeResourceListByParent<
    DedicatedHost,
    Response = DedicatedHostListResult
  >;

  /**
   * Lists all available dedicated host sizes to which the specified dedicated host can be resized. NOTE: The dedicated host sizes provided can be used to only scale up the existing dedicated host.
   */
  @get
  @action("hostSizes")
  listAvailableSizes is ComputeResourceActionSync<
    DedicatedHost,
    void,
    DedicatedHostSizeListResult
  >;

  /**
   * Redeploy the dedicated host. The operation will complete successfully once the dedicated host has migrated to a new node and is running. To determine the health of VMs deployed on the dedicated host after the redeploy check the Resource Health Center in the Azure Portal. Please refer to https://docs.microsoft.com/azure/service-health/resource-health-overview for more details.
   */
  redeploy is ComputeResourceActionNoResponseContentAsync<
    DedicatedHost,
    void,
    Error = CloudError
  >;

  /**
   * Restart the dedicated host. The operation will complete successfully once the dedicated host has restarted and is running. To determine the health of VMs deployed on the dedicated host after the restart check the Resource Health Center in the Azure Portal. Please refer to https://docs.microsoft.com/azure/service-health/resource-health-overview for more details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes"
  restart is ComputeResourceActionAsyncBase<
    DedicatedHost,
    void,
    Response = OkResponse &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DedicatedHost>
  >;
}

@@doc(DedicatedHost.name, "The name of the dedicated host.");
@@doc(DedicatedHost.properties, "Properties of the dedicated host.");
@@doc(DedicatedHosts.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Dedicated Host."
);
@@doc(DedicatedHosts.update::parameters.properties,
  "Parameters supplied to the Update Dedicated Host operation."
);
