namespace ApiCenter.DataApi.Models;

using TypeSpec.Rest;

@doc("Export specification resource model.")
@resource("definitions")
@parentResource(ApiVersion)
model ExportSpecification {
  @doc("API definition identifier.")
  @key("definitionName")
  @visibility("query")
  definitionName: string;

  @doc("The result of the specification export.")
  value: string;

  @doc("The result format of the specification export.")
  format: SpecFormat;
}

@doc("Export specification format")
enum SpecFormat {
  @doc("Link format")
  Link: "link",
}
