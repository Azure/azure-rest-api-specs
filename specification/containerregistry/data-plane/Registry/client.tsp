import "./main.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@usage(ContainerRegistry.TokenGrantType, Usage.output);
@@usage(ContainerRegistry.AcrErrors, Usage.output);

@@clientName(ContainerRegistry, "ContainerRegistry", "!autorest");
// Rename ChangeableAttributes models to WriteableProperties for Python SDK backward compatibility
@@clientName(
  ContainerRegistry.ManifestChangeableAttributes,
  "ManifestWriteableProperties",
  "python"
);
@@clientName(
  ContainerRegistry.TagChangeableAttributes,
  "TagWriteableProperties",
  "python"
);
@@clientName(
  ContainerRegistry.RepositoryChangeableAttributes,
  "RepositoryWriteableProperties",
  "python"
);

// Client name mappings for ContainerRepositoryProperties
@@clientName(
  ContainerRegistry.ContainerRepositoryProperties.registry,
  "registryLoginServer",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ContainerRepositoryProperties.imageName,
  "name",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ContainerRepositoryProperties.createdTime,
  "createdOn",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ContainerRepositoryProperties.lastUpdateTime,
  "lastUpdatedOn",
  "!autorest"
);

// Client name mappings for RepositoryChangeableAttributes
@@clientName(
  ContainerRegistry.RepositoryChangeableAttributes.deleteEnabled,
  "canDelete",
  "!autorest"
);
@@clientName(
  ContainerRegistry.RepositoryChangeableAttributes.writeEnabled,
  "canWrite",
  "!autorest"
);
@@clientName(
  ContainerRegistry.RepositoryChangeableAttributes.listEnabled,
  "canList",
  "!autorest"
);
@@clientName(
  ContainerRegistry.RepositoryChangeableAttributes.readEnabled,
  "canRead",
  "!autorest"
);

// Client name mappings for DeleteRepositoryResult
@@clientName(
  ContainerRegistry.DeleteRepositoryResult.manifestsDeleted,
  "deletedManifests",
  "!autorest"
);
@@clientName(
  ContainerRegistry.DeleteRepositoryResult.tagsDeleted,
  "deletedTags",
  "!autorest"
);

// Client name mappings for TagList
@@clientName(
  ContainerRegistry.TagList.registry,
  "registryLoginServer",
  "!autorest"
);
@@clientName(ContainerRegistry.TagList.imageName, "repository", "!autorest");
@@clientName(ContainerRegistry.TagList.tags, "tagAttributeBases", "!autorest");

// Client name mappings for TagAttributesBase
@@clientName(
  ContainerRegistry.TagAttributesBase.createdTime,
  "createdOn",
  "!autorest"
);
@@clientName(
  ContainerRegistry.TagAttributesBase.lastUpdateTime,
  "lastUpdatedOn",
  "!autorest"
);

// Client name mappings for TagChangeableAttributes
@@clientName(
  ContainerRegistry.TagChangeableAttributes.deleteEnabled,
  "canDelete",
  "!autorest"
);
@@clientName(
  ContainerRegistry.TagChangeableAttributes.writeEnabled,
  "canWrite",
  "!autorest"
);
@@clientName(
  ContainerRegistry.TagChangeableAttributes.listEnabled,
  "canList",
  "!autorest"
);
@@clientName(
  ContainerRegistry.TagChangeableAttributes.readEnabled,
  "canRead",
  "!autorest"
);

// Client name mappings for ArtifactTagProperties
@@clientName(
  ContainerRegistry.ArtifactTagProperties.registry,
  "registryLoginServer",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ArtifactTagProperties.imageName,
  "repositoryName",
  "!autorest"
);

// Client name mappings for AcrManifests
@@clientName(
  ContainerRegistry.AcrManifests.registry,
  "registryLoginServer",
  "!autorest"
);
@@clientName(
  ContainerRegistry.AcrManifests.imageName,
  "repository",
  "!autorest"
);

// Client name mappings for ManifestAttributesBase
@@clientName(
  ContainerRegistry.ManifestAttributesBase.imageSize,
  "size",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestAttributesBase.createdTime,
  "createdOn",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestAttributesBase.lastUpdateTime,
  "lastUpdatedOn",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestAttributesBase.os,
  "operatingSystem",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestAttributesBase.references,
  "relatedArtifacts",
  "!autorest"
);

// Client name mappings for ArtifactManifestPlatform
@@clientName(
  ContainerRegistry.ArtifactManifestPlatform.os,
  "operatingSystem",
  "!autorest"
);

// Client name mappings for ManifestChangeableAttributes
@@clientName(
  ContainerRegistry.ManifestChangeableAttributes.deleteEnabled,
  "canDelete",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestChangeableAttributes.writeEnabled,
  "canWrite",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestChangeableAttributes.listEnabled,
  "canList",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ManifestChangeableAttributes.readEnabled,
  "canRead",
  "!autorest"
);

// Client name mappings for ArtifactManifestProperties
@@clientName(
  ContainerRegistry.ArtifactManifestProperties.registry,
  "registryLoginServer",
  "!autorest"
);
@@clientName(
  ContainerRegistry.ArtifactManifestProperties.imageName,
  "repositoryName",
  "!autorest"
);
