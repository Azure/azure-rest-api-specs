import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Dataset resource type.
 */
@parentResource(Factory)
model DatasetResource is Azure.ResourceManager.ProxyResource<Dataset, false> {
  ...ResourceNameParameter<
    Resource = DatasetResource,
    KeyName = "datasetName",
    SegmentName = "datasets",
    NamePattern = "^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface DatasetResources {
  /**
   * Gets a dataset.
   */
  get is ArmResourceRead<
    DatasetResource,
    Parameters = {
      /**
       * ETag of the dataset entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<DatasetResource> | NotModifiedResponse,
    Error = CloudError
  >;

  /**
   * Creates or updates a dataset.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DatasetResource,
    Parameters = {
      /**
       * ETag of the dataset entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<DatasetResource>,
    Error = CloudError
  >;

  /**
   * Deletes a dataset.
   */
  delete is ArmResourceDeleteSync<DatasetResource, Error = CloudError>;

  /**
   * Lists datasets.
   */
  listByFactory is ArmResourceListByParent<
    DatasetResource,
    Response = ArmResponse<DatasetListResponse>,
    Error = CloudError
  >;
}

@@maxLength(DatasetResource.name, 260);
@@minLength(DatasetResource.name, 1);
@@doc(DatasetResource.name, "The dataset name.");
@@doc(DatasetResource.properties, "Dataset properties.");
@@doc(DatasetResources.createOrUpdate::parameters.resource,
  "Dataset resource definition."
);
