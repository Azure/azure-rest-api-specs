using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

scalar AbsoluteDirectoryPath;

scalar AbsoluteFilePath;

model DirListingResponse {
  path: string;
  entries: FileInfoResponse[];
}

model FileInfoResponse {
  name: string;
  path: string;
  size: Int64OrString;
  mode: UInt32OrString;
  isDir: boolean;
  isSymlink: boolean;
  symlinkTarget: null | string;
  modifiedTime: Int64OrString;
}

model FileOpStatusResponse {
  success: boolean;
  error?: null | string;
  message?: null | string;
}

model FileStreamResult {
  fileStream?: Stream;
  contentType?: null | string;
  fileDownloadName?: null | string;
  lastModified?: null | utcDateTime;
  @oneOf entityTag?: null | EntityTagHeaderValue;
  enableRangeProcessing?: boolean;
}

model MkDirRequest {
  path: string;
  createParents?: boolean;
  mode?: UInt32OrString = 0;
}

model StringSegment {
  buffer?: null | string;
  offset?: Int32OrString;
  length?: Int32OrString;
  value?: null | string;
  hasValue?: boolean;
}

model WriteFileResponse {
  success: boolean;
  error?: null | string;
  bytesWritten?: Int64OrString = 0;
}
