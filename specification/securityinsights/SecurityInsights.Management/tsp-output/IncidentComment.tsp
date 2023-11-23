import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Incident.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents an incident comment")
@parentResource(Incident)
model IncidentComment is ProxyResource<IncidentCommentProperties> {
  @doc("Incident comment ID")
  @path
  @key("incidentCommentId")
  @segment("comments")
  name: string;
}

@armResourceOperations
interface IncidentComments {
  @doc("Gets an incident comment.")
  get is ArmResourceRead<IncidentComment>;
  @doc("Creates or updates the incident comment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IncidentComment>;
  @doc("Delete the incident comment.")
  delete is ArmResourceDeleteSync<IncidentComment>;
  @doc("Gets all incident comments.")
  list is ArmResourceListByParent<
    IncidentComment,
    {
      ...BaseParameters<IncidentComment>;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
