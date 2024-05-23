// import "@typespec/rest";
// import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

// @versioned(Microsoft.App.Versions)
namespace Microsoft.App;

@doc("A widget.")
@resource("widgets")
model Widget {
  @key("widgetName")
  @doc("The widget name.")
  @visibility("read")
  name: string;

  @doc("The ID of the manufacturer.")
  manufacturerId: string;

  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

@doc("Faked shared model")
model FakedSharedModel {
  @doc("The tag.")
  tag: string;

  @doc("The created date.")
  createdDate: utcDateTime;
}
