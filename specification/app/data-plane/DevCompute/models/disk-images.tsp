using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

scalar AsyncOperationId;

/**
 * Status of an asynchronous operation.
 * IMPORTANT: Always use explicit integer values. Never reorder or reassign existing values.
 */
union AsyncOperationStatus {
  "Pending",
  "InProgress",
  "Succeeded",
  "Failed",
}

scalar ContainerImageUrlWithTag;

@added(Versions.v2026_09_01)
model CreateDiskImageRequestView {
  source: CreateDiskImageSource;
  name?: null | string;
  labels?: Record<string>;
  vnetConnectionName?: null | string;
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
@added(Versions.v2026_09_01)
union CreateDiskImageSource {
  registry: CreateDiskImageSourceRegistrySource,
  blob: CreateDiskImageSourceBlobSource,
}

@added(Versions.v2026_09_01)
model CreateDiskImageSourceBlobSource {
  kind?: "blob";
  blobSourceUri: BlobUri;
}

@added(Versions.v2026_09_01)
model CreateDiskImageSourceRegistrySource {
  kind?: "registry";
  imageUrl: ContainerImageUrlWithTag;
  @oneOf registryCredentials?: null | RegistryCredentials;
  managedIdentityClientId?: null | string;
}

scalar DiskImageId;

model DiskImageImageView {
  base: string;
  entrypoint?: null | string[];
  cmd?: null | string[];
}

model DiskImageOperationResponseView {
  operationId: AsyncOperationId;
  status: AsyncOperationStatus;
  errorMessage?: null | string;
  @oneOf diskImage?: null | DiskImageResponseView;
  createdAt: utcDateTime;
  updatedAt: utcDateTime;
}

model DiskImageResponseView {
  id: DiskImageId;
  name?: null | string;
  labels: Record<string>;
  image: DiskImageImageView;
  status: DiskImageStatusView;
  @oneOf sizeInMB?: null | MegaBytes;

  @removed(Versions.v2026_09_01)
  dockerfileContent?: null | string;
}

model DiskImageStatusView {
  state: string;
  errorMessage?: null | string;
  createdAt: utcDateTime;
  updatedAt: utcDateTime;
}

model PublicDiskImageResponseView {
  name: string;
  status: DiskImageStatusView;
}

model RegistryCredentials {
  username: string;

  @secret
  token: string;
}

model SandboxSourceDiskImageView {
  @oneOf id?: null | DiskImageId;

  /**
   * Disk image name for public disk images (e.g., "nginx", "python3.12").
   * Mutually exclusive with Id.
   */
  name?: null | string;

  /**
   * Indicates whether this references a public disk image.
   * Must be true when using Name, must be false when using Id.
   */
  isPublic?: boolean;
}

union CreateDiskImageResponse {
  OkPlain: {
    @header contentType: "text/plain",
    @body body: DiskImageResponseView,
  },
  OkJson: DiskImageResponseView,
  OkTextJson: {
    @header contentType: "text/json",
    @body body: DiskImageResponseView,
  },

  @removed(Versions.v2026_09_01)
  CreatedPlain: {
    @statusCode statusCode: 201,
    @header contentType: "text/plain",
    @body body: DiskImageResponseView,
  },

  @removed(Versions.v2026_09_01)
  CreatedJson: {
    @statusCode statusCode: 201,
    @header contentType: "application/json",
    @body body: DiskImageResponseView,
  },

  @removed(Versions.v2026_09_01)
  CreatedTextJson: {
    @statusCode statusCode: 201,
    @header contentType: "text/json",
    @body body: DiskImageResponseView,
  },

  BadRequestPlain: {
    @statusCode statusCode: 400,
    @header contentType: "text/plain",
    @body body: ProblemDetails,
  },
  BadRequestJson: BadRequestResponse & ProblemDetails,
  BadRequestTextJson: {
    @statusCode statusCode: 400,
    @header contentType: "text/json",
    @body body: ProblemDetails,
  },
  UnauthorizedPlain: {
    @statusCode statusCode: 401,
    @header contentType: "text/plain",
    @body body: ProblemDetails,
  },
  UnauthorizedJson: UnauthorizedResponse & ProblemDetails,
  UnauthorizedTextJson: {
    @statusCode statusCode: 401,
    @header contentType: "text/json",
    @body body: ProblemDetails,
  },

  @removed(Versions.v2026_09_01)
  ConflictPlain: {
    @statusCode statusCode: 409,
    @header contentType: "text/plain",
    @body body: ProblemDetails,
  },

  @removed(Versions.v2026_09_01)
  ConflictJson: ConflictResponse & ProblemDetails,

  @removed(Versions.v2026_09_01)
  ConflictTextJson: {
    @statusCode statusCode: 409,
    @header contentType: "text/json",
    @body body: ProblemDetails,
  },

  TooManyRequestsPlain: {
    @statusCode statusCode: 429,
    @header contentType: "text/plain",
    @body body: ProblemDetails,
  },
  TooManyRequestsJson: {
    @statusCode statusCode: 429,
    @body body: ProblemDetails,
  },
  TooManyRequestsTextJson: {
    @statusCode statusCode: 429,
    @header contentType: "text/json",
    @body body: ProblemDetails,
  },
  InternalServerError: {
    @statusCode statusCode: 500,
  },
}

@removed(Versions.v2026_09_01)
model BuildDiskImageFromDockerfileRequestView {
  name: string;
  dockerfile: string;
  @oneOf vmmType?: null | VmmType;
  labels?: Record<string>;
  buildArgs?: Record<string>;

  @secret
  secrets?: Record<string>;

  @oneOf contextContentPackageId?: null | ContentPackageId;
}

@removed(Versions.v2026_09_01)
model CreateDiskImageV2RequestView {
  source: CreateDiskImageV2Source;
  name?: null | string;
  @oneOf vmmType?: null | VmmType;
  labels?: Record<string>;
  vnetConnectionName?: null | string;
  customerVnetConnectionName?: null | string;
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
@removed(Versions.v2026_09_01)
union CreateDiskImageV2Source {
  registry: CreateDiskImageV2SourceRegistrySource,
  blob: CreateDiskImageV2SourceBlobSource,
  dockerfile: CreateDiskImageV2SourceDockerfileSource,
}

@removed(Versions.v2026_09_01)
model CreateDiskImageV2SourceBlobSource {
  kind?: "blob";
  blobSourceUri: BlobUri;
}

@removed(Versions.v2026_09_01)
model CreateDiskImageV2SourceDockerfileSource {
  kind?: "dockerfile";
  dockerfileContent: string;
  buildArgs: Record<string>;

  @secret
  secrets: Record<string>;

  /** A strongly-typed blob URI (with or without SAS token). */
  contextBlobUri?: unknown;

  contextContentPackageId?: unknown;
}

@removed(Versions.v2026_09_01)
model CreateDiskImageV2SourceRegistrySource {
  kind?: "registry";
  imageUrl: ContainerImageUrlWithTag;
  isPlatformImage?: boolean;
  @oneOf registryCredentials?: null | RegistryCredentials;
  managedIdentityClientId?: null | string;
}

@removed(Versions.v2026_09_01)
model DiskImageRequestView {
  name?: null | string;
  labels?: Record<string>;
  @oneOf vmmType?: null | VmmType;
  image: DiskImageImageView;
  @oneOf registryCredentials?: null | RegistryCredentials;
}

@removed(Versions.v2026_09_01)
union VmmType {
  "cloudhypervisor",
  "hcs",
  "firecracker",
  null,
}
