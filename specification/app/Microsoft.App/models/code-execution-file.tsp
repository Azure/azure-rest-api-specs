import "./common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

@doc("Code execution file resource collection.")
model CodeExecutionFileCollection {
  @doc("The files uploaded.")
  value: CodeExecutionFile[];
}

@doc("Code execution file resource.")
@parentResource(SessionPool)
@resource("files")
model CodeExecutionFile {
  @key("filename")
  @segment("files")
  @doc("The name of the file.")
  @visibility
  filename: string;

  @doc("Code execution file resource properties.")
  properties: CodeExecutionFileProperties;
}

@doc("Code execution file resource properties.")
model CodeExecutionFileProperties {
  @doc("The name of the file.")
  filename: string;

  @doc("The size of the file.")
  size: int64;

  @doc("The date time when the file was last modified.")
  lastModifiedTime: utcDateTime;
}
