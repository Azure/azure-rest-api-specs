import "./common.tsp";
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

/** Code execution file resource collection. */
model SessionResourceFileCollection {
  /** The files uploaded. */
  value: SessionResourceFile[];
}

/** Code execution file resource. */
@resource("files")
model SessionResourceFile {
  /** The name of the file. */
  @key("name")
  @segment("files")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  /** The type of the session resource file. */
  type: string;

  /** The type of the content of this file. */
  contentType?: string;

  /** The size of the file. */
  sizeInBytes?: int64;

  /** The date time in RFC3339 format when the file was last modified. */
  lastModifiedAt: utcDateTime;

  /** The directory path of the session resource file. */
  @added(Versions.v2025_10_02_preview)
  directory?: string;
}
