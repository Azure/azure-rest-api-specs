import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Tags;

interface Tags {
  @doc("List a collection of tags.")
  listTags is ResourceList<
    TagResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;
}

@doc("Tag resource model.")
@resource("tags")
model TagResource extends Tag {
  @doc("Tag identifier.")
  @key("tagId")
  @visibility("query")
  tagId: string;
}
