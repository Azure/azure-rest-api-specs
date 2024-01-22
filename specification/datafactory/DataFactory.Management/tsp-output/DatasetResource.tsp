import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Dataset resource type.
 */
@parentResource(Factory)
model DatasetResource is ProxyResource<Dataset> {
  /**
   * The dataset name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("datasetName")
  @segment("datasets")
  name: string;
}

@armResourceOperations
interface DatasetResources {
  /**
   * Gets a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Datasets_Get")
  get is ArmResourceRead<
    DatasetResource,
    {
      ...BaseParameters<DatasetResource>;

      /**
       * ETag of the dataset entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Datasets_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DatasetResource,
    {
      ...BaseParameters<DatasetResource>;

      /**
       * ETag of the dataset entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Datasets_Delete")
  delete is ArmResourceDeleteSync<DatasetResource>;

  /**
   * Lists datasets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Datasets_ListByFactory")
  listByFactory is ArmResourceListByParent<DatasetResource>;
}

@@projectedName(DatasetResources.createOrUpdate::parameters.resource,
  "json",
  "dataset"
);
@@extension(DatasetResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "dataset"
);
@@doc(DatasetResources.createOrUpdate::parameters.resource,
  "Dataset resource definition."
);
