import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureContainerRegistry;

@@clientLocation(ContainerRegistry.checkDockerV2Support, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getManifest, "ContainerRegistry");
@@clientLocation(ContainerRegistry.createManifest, "ContainerRegistry");
@@clientLocation(ContainerRegistry.deleteManifest, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getRepositories, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getProperties, "ContainerRegistry");
@@clientLocation(ContainerRegistry.deleteRepository, "ContainerRegistry");
@@clientLocation(ContainerRegistry.updateProperties, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getTags, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getTagProperties, "ContainerRegistry");
@@clientLocation(ContainerRegistry.updateTagAttributes, "ContainerRegistry");
@@clientLocation(ContainerRegistry.deleteTag, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getManifests, "ContainerRegistry");
@@clientLocation(ContainerRegistry.getManifestProperties, "ContainerRegistry");
@@clientLocation(ContainerRegistry.updateManifestProperties,
  "ContainerRegistry"
);

@@clientLocation(ContainerRegistryBlob.getBlob, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.checkBlobExists,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlob.deleteBlob, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.mountBlob, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.getUploadStatus,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlob.uploadChunk, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.completeUpload, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.cancelUpload, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.startUpload, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.getChunk, "ContainerRegistryBlob");
@@clientLocation(ContainerRegistryBlob.checkChunkExists,
  "ContainerRegistryBlob"
);

@@clientLocation(Authentication.exchangeAadAccessTokenForAcrRefreshToken,
  "Authentication"
);
@@clientLocation(Authentication.exchangeAcrRefreshTokenForAcrAccessToken,
  "Authentication"
);
@@clientLocation(Authentication.getAcrAccessTokenFromLogin, "Authentication");
