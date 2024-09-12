import "./common.tsp";
using TypeSpec.Http;
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
  @key("fileName")
  @segment("files")
  @doc("The name of the file.")
  @visibility("read", "query", "create", "update", "delete")
  fileName: string;

  @doc("The size of the file.")
  sizeInBytes: int64;

  @doc("The date time in RFC3339 format when the file was uploaded.")
  createdAt: utcDateTime;

  @doc("The date time in RFC3339 format when the file was last modified.")
  lastModifiedAt: utcDateTime;
}
