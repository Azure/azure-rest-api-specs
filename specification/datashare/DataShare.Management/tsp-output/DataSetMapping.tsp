import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: DataSetMapping has no properties property
@doc("A data set mapping data transfer object.")
@parentResource(ShareSubscription)
model DataSetMapping is ProxyResource<{}> {
  @doc("The name of the dataSetMapping.")
  @path
  @key("dataSetMappingName")
  @segment("dataSetMappings")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataSetMappings {
  @doc("Get a DataSetMapping in a shareSubscription")
  get is ArmResourceRead<DataSetMapping>;

  @doc("Create a DataSetMapping ")
  create is ArmResourceCreateOrReplaceSync<DataSetMapping>;

  @doc("Delete a DataSetMapping in a shareSubscription")
  delete is ArmResourceDeleteSync<DataSetMapping>;

  @doc("List DataSetMappings in a share subscription")
  listByShareSubscription is ArmResourceListByParent<
    DataSetMapping,
    {
      ...BaseParameters<DataSetMapping>;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Filters the results using OData syntax.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results using OData syntax.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(DataSetMappings.create::parameters.resource,
  "json",
  "dataSetMapping"
);
@@extension(DataSetMappings.create::parameters.resource,
  "x-ms-client-name",
  "dataSetMapping"
);
@@doc(DataSetMappings.create::parameters.resource,
  "Destination data set configuration details."
);
