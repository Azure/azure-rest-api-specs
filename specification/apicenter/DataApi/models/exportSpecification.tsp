namespace ApiCenter.DataApi.Models;

using TypeSpec.Rest;

@doc("Export specification")
@resource("definitions")
@parentResource(ApiVersion)
model ExportSpecification {
  @doc("Definition identifier.")
  @key("apiDefinitionName")
  @visibility("query")
  apiDefinitionName: string;

  @doc("The result of the specification export.")
  value: string;

  @doc("The result format of the specification export.")
  format: SpecFormat;
}

@doc("Export specification format")
enum SpecFormat {
  @doc("Inline format")
  Inline: "inline",

  @doc("Link format")
  Link: "link",
}
