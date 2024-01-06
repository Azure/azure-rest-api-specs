import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;


alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

alias ListQueryParamsIndex = ListQueryParametersTrait<{
  @query listViewType: string = "ActiveOnly";
  @query label: string;
}>;

interface IndexVerions {
  @doc("Fetch a IndexVersion by name.")
  getIndexVersion is Operations.ResourceRead<IndexVersion>;

  @doc("Creates or updates a IndexVersion.")
  createIndex is Operations.ResourceCreateOrUpdate<IndexVersion>;

  @doc("List IndexVersion resources.")
  list is Operations.ResourceList<
    IndexVersion,
    StandardListQueryParameters & ListQueryParamsIndex
    >;
}

interface IndexContainers {
  @doc("List the latest index resources.")
  list is Operations.ResourceList<
    IndexContainer,
    StandardListQueryParameters & ListQueryParamsIndex
    >;
}

