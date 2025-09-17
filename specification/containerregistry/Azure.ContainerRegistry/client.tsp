import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureContainerRegistry;

@@clientName(Platform.`os.version`, "osVersion");
@@clientName(Platform.`os.features`, "osFeatures");

@@clientName(Annotations.`org.opencontainers.image.created`, "created");
@@clientName(Annotations.`org.opencontainers.image.authors`, "authors");
@@clientName(Annotations.`org.opencontainers.image.url`, "url");
@@clientName(Annotations.`org.opencontainers.image.documentation`,
  "documentation"
);
@@clientName(Annotations.`org.opencontainers.image.source`, "source");
@@clientName(Annotations.`org.opencontainers.image.version`, "version");
@@clientName(Annotations.`org.opencontainers.image.revision`, "revision");
@@clientName(Annotations.`org.opencontainers.image.vendor`, "vendor");
@@clientName(Annotations.`org.opencontainers.image.licenses`, "licenses");
@@clientName(Annotations.`org.opencontainers.image.ref.name`, "name");
@@clientName(Annotations.`org.opencontainers.image.title`, "title");
@@clientName(Annotations.`org.opencontainers.image.description`, "description");

@@clientName(ContainerRepositoryProperties.registry, "registryLoginServer");
@@clientName(ContainerRepositoryProperties.imageName, "name");
@@clientName(ContainerRepositoryProperties.createdTime, "createdOn");
@@clientName(ContainerRepositoryProperties.lastUpdateTime, "lastUpdatedOn");

@@clientName(RepositoryWriteableProperties.deleteEnabled, "canDelete");
@@clientName(RepositoryWriteableProperties.writeEnabled, "canWrite");
@@clientName(RepositoryWriteableProperties.listEnabled, "canList");
@@clientName(RepositoryWriteableProperties.readEnabled, "canRead");

@@clientName(DeleteRepositoryResult.manifestsDeleted, "deletedManifests");
@@clientName(DeleteRepositoryResult.tagsDeleted, "deletedTags");

@@clientName(TagList.registry, "registryLoginServer");
@@clientName(TagList.imageName, "repository");
@@clientName(TagList.tags, "tagAttributeBases");

@@clientName(TagAttributesBase.createdTime, "createdOn");
@@clientName(TagAttributesBase.lastUpdateTime, "lastUpdatedOn");

@@clientName(TagWriteableProperties.deleteEnabled, "canDelete");
@@clientName(TagWriteableProperties.writeEnabled, "canWrite");
@@clientName(TagWriteableProperties.listEnabled, "canList");
@@clientName(TagWriteableProperties.readEnabled, "canRead");

@@clientName(ArtifactTagProperties.registry, "registryLoginServer");
@@clientName(ArtifactTagProperties.imageName, "repositoryName");

@@clientName(AcrManifests.registry, "registryLoginServer");
@@clientName(AcrManifests.imageName, "repository");

@@clientName(ManifestAttributesBase.imageSize, "size");
@@clientName(ManifestAttributesBase.createdTime, "createdOn");
@@clientName(ManifestAttributesBase.lastUpdateTime, "lastUpdatedOn");
@@clientName(ManifestAttributesBase.os, "operatingSystem");
@@clientName(ManifestAttributesBase.references, "relatedArtifacts");

@@clientName(ArtifactManifestPlatform.os, "operatingSystem");

@@clientName(ManifestWriteableProperties.deleteEnabled, "canDelete");
@@clientName(ManifestWriteableProperties.writeEnabled, "canWrite");
@@clientName(ManifestWriteableProperties.listEnabled, "canList");
@@clientName(ManifestWriteableProperties.readEnabled, "canRead");

@@clientName(ArtifactManifestProperties.registry, "registryLoginServer");
@@clientName(ArtifactManifestProperties.imageName, "repositoryName");

@@clientName(AcrRefreshToken.refresh_token, "refreshToken");

@@clientName(AcrAccessToken.access_token, "accessToken");

@@clientName(Paths108HwamOauth2ExchangePostRequestbodyContentApplicationXWwwFormUrlencodedSchema.grant_type,
  "grantType"
);
@@clientName(Paths108HwamOauth2ExchangePostRequestbodyContentApplicationXWwwFormUrlencodedSchema.refresh_token,
  "refreshToken"
);
@@clientName(Paths108HwamOauth2ExchangePostRequestbodyContentApplicationXWwwFormUrlencodedSchema.access_token,
  "aadAccessToken"
);

@@clientName(PathsV3R3RxOauth2TokenPostRequestbodyContentApplicationXWwwFormUrlencodedSchema.refresh_token,
  "acrRefreshToken"
);
@@clientName(PathsV3R3RxOauth2TokenPostRequestbodyContentApplicationXWwwFormUrlencodedSchema.grant_type,
  "grantType"
);

@@clientLocation(ContainerRegistryOperationGroup.checkDockerV2Support,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.getManifest,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.createManifest,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.deleteManifest,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.getRepositories,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.getProperties,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.deleteRepository,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.updateProperties,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.getTags, "ContainerRegistry");
@@clientLocation(ContainerRegistryOperationGroup.getTagProperties,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.updateTagAttributes,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.deleteTag,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.getManifests,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.getManifestProperties,
  "ContainerRegistry"
);
@@clientLocation(ContainerRegistryOperationGroup.updateManifestProperties,
  "ContainerRegistry"
);

@@clientLocation(ContainerRegistryBlobOperationGroup.getBlob,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.checkBlobExists,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.deleteBlob,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.mountBlob,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.getUploadStatus,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.uploadChunk,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.completeUpload,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.cancelUpload,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.startUpload,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.getChunk,
  "ContainerRegistryBlob"
);
@@clientLocation(ContainerRegistryBlobOperationGroup.checkChunkExists,
  "ContainerRegistryBlob"
);

@@clientLocation(AuthenticationOperationGroup.exchangeAadAccessTokenForAcrRefreshToken,
  "Authentication"
);
@@clientLocation(AuthenticationOperationGroup.exchangeAcrRefreshTokenForAcrAccessToken,
  "Authentication"
);
@@clientLocation(AuthenticationOperationGroup.getAcrAccessTokenFromLogin,
  "Authentication"
);
