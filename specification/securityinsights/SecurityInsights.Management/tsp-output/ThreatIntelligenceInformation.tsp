import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: ThreatIntelligenceInformation has no properties property
@doc("Threat intelligence information object.")
model ThreatIntelligenceInformation is ProxyResource<{}> {
  @doc("Threat intelligence indicator name field.")
  @path
  @key("name")
  @segment("indicators")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ThreatIntelligenceInformations {
  @doc("View a threat intelligence indicator by name.")
  get is ArmResourceRead<ThreatIntelligenceInformation>;
  @doc("Update a threat Intelligence indicator.")
  create is ArmResourceCreateOrReplaceSync<ThreatIntelligenceInformation>;
  @doc("Delete a threat intelligence indicator.")
  delete is ArmResourceDeleteSync<ThreatIntelligenceInformation>;
  @doc("Get all threat intelligence indicators.")
  list is ArmResourceListByParent<
    ThreatIntelligenceInformation,
    {
      ...BaseParameters<ThreatIntelligenceInformation>;

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
  @doc("Append tags to a threat intelligence indicator.")
  appendTags is ArmResourceActionSync<
    ThreatIntelligenceInformation,
    ThreatIntelligenceAppendTags,
    {}
  >;
  @doc("Replace tags added to a threat intelligence indicator.")
  replaceTags is ArmResourceActionSync<
    ThreatIntelligenceInformation,
    ThreatIntelligenceIndicatorModel,
    ThreatIntelligenceInformation
  >;
}
