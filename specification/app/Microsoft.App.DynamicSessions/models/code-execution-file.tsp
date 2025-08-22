import "./common.tsp";
using TypeSpec.Rest;

namespace Microsoft.App.DynamicSessions;

@doc("Code execution file resource collection.")
model SessionResourceFileCollection {
  @doc("The files uploaded.")
  value: SessionResourceFile[];
}

@doc("Code execution file resource.")
@resource("files")
model SessionResourceFile {
  @key("name")
  @segment("files")
  @doc("The name of the file.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("The type of the session resource file.")
  type: string;

  @doc("The type of the content of this file.")
  contentType?: string;

  @doc("The size of the file.")
  sizeInBytes?: int64;

  @doc("The date time in RFC3339 format when the file was last modified.")
  lastModifiedAt: utcDateTime;
}
