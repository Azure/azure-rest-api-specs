import "./common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

@doc("Code execution file resource collection.")
model SessionResourceFileCollection {
  @doc("The files uploaded.")
  value: SessionResourceFile[];
}

@doc("Code execution file resource.")
@parentResource(SessionPool)
@resource("files")
model SessionResourceFile {
  @key("fileName")
  @segment("files")
  @doc("The name of the file.")
  @visibility("create")
  fileName: string;

  @doc("The size of the file.")
  sizeInBytes: int64;

  @doc("The date time when the file was last modified.")
  lastModifiedAt: utcDateTime;
}
