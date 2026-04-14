import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@added(Versions.v1)
@doc("Model Version Definition")
@Rest.resource("models")
model ModelVersion {
  @doc("System related metadata")
  systemData?: SystemDataV3;

  @doc("URI of the model artifact in blob storage")
  blobUri?: string;

  @doc("Derived model information")
  derivedModelInformation?: DerivedModelInformation;

  ...AssetBase;
}

@added(Versions.v1)
@doc("System metadata for a resource")
model SystemDataV3 {
  @doc("Timestamp of resource creation")
  createdAt?: utcDateTime;

  @doc("Identity that created the resource")
  createdBy?: string;

  @doc("Type of identity that created the resource")
  createdByType?: string;

  @doc("Timestamp of last resource modification")
  lastModifiedAt?: utcDateTime;
}

@added(Versions.v1)
@doc("Derived model information")
model DerivedModelInformation {
  @doc("Base model asset ID")
  baseModel: string;
}

@added(Versions.v1)
@doc("Request to start or retrieve a pending upload for a model version.")
model ModelPendingUploadRequest {
  @doc("Optional pending upload ID. If provided, retrieves the existing pending upload.")
  pendingUploadId?: string;

  @doc("Type of pending upload.")
  pendingUploadType: PendingUploadType;
}

@added(Versions.v1)
@doc("A blob reference with temporary credentials for consumption.")
model ModelBlobReferenceForConsumption {
  @doc("The blob URI.")
  blobUri?: string;

  @doc("Credential for accessing the blob.")
  credential?: SasCredential;

  @doc("ARM resource ID of the storage account.")
  storageAccountArmId?: string;
}

@added(Versions.v1)
@doc("Temporary data reference returned for a pending upload.")
model ModelTemporaryDataReference {
  @doc("Blob reference for consumption with temporary credentials.")
  blobReferenceForConsumption?: ModelBlobReferenceForConsumption;

  @doc("Pending upload ID.")
  pendingUploadId?: string;

  @doc("Type of pending upload.")
  pendingUploadType: PendingUploadType;
}

@added(Versions.v1)
@doc("Request to fetch credentials for a model asset.")
model ModelAssetCredentialRequest {
  @doc("Blob URI of the asset to fetch credentials for.")
  blobUri: string;

  @doc("If true, generates blob-level read SAS instead of container-level.")
  generateBlobLevelReadSas?: boolean;
}

@added(Versions.v1)
@doc("Response containing credentials for a model asset.")
model ModelAssetCredentialResponse {
  @doc("Blob reference with credentials.")
  blobReference?: ModelBlobReferenceForConsumption;
}

@added(Versions.v1)
@doc("Accepted response for asynchronous model version creation, with polling location.")
model CreateModelVersionAsyncResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for operation status.")
  @header("Location")
  location: string;
}
