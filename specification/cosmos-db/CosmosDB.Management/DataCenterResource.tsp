import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ClusterResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * A managed Cassandra data center.
 */
@parentResource(ClusterResource)
model DataCenterResource
  is Azure.ResourceManager.ProxyResource<DataCenterResourceProperties> {
  ...ResourceNameParameter<
    Resource = DataCenterResource,
    KeyName = "dataCenterName",
    SegmentName = "dataCenters",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;
}

@armResourceOperations
interface DataCenterResources {
  /**
   * Get the properties of a managed Cassandra data center.
   */
  get is ArmResourceRead<DataCenterResource, Error = CloudError>;

  /**
   * Create or update a managed Cassandra data center. When updating, overwrite all properties. To update only some properties, use PATCH.
   */
  createUpdate is ArmResourceCreateOrReplaceAsync<
    DataCenterResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = DataCenterResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Update some of the properties of a managed Cassandra data center.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DataCenterResource,
    PatchModel = DataCenterResource,
    Response = ArmResponse<DataCenterResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DataCenterResource> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: DataCenterResource;
    }),
    Error = CloudError
  >;

  /**
   * Delete a managed Cassandra data center.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    DataCenterResource,
    Error = CloudError
  >;

  /**
   * List all data centers in a particular managed Cassandra cluster.
   */
  list is ArmResourceListByParent<
    DataCenterResource,
    Response = ArmResponse<ListDataCenters>,
    Error = CloudError
  >;
}

@@maxLength(DataCenterResource.name, 100);
@@minLength(DataCenterResource.name, 1);
@@doc(DataCenterResource.name,
  "Data center name in a managed Cassandra cluster."
);
@@doc(DataCenterResource.properties,
  "Properties of a managed Cassandra data center."
);
@@doc(DataCenterResources.createUpdate::parameters.resource,
  "Parameters specifying the managed Cassandra data center."
);
@@doc(DataCenterResources.update::parameters.properties,
  "Parameters to provide for specifying the managed Cassandra data center."
);
