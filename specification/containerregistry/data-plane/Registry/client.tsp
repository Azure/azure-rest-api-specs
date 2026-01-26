import "./main.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(ContainerRegistry, "ContainerRegistry");
// Rename ChangeableAttributes models to WriteableProperties for Python SDK backward compatibility
@@clientName(ContainerRegistry.ManifestChangeableAttributes,
  "ManifestWriteableProperties",
  "python"
);
@@clientName(ContainerRegistry.TagChangeableAttributes,
  "TagWriteableProperties",
  "python"
);
@@clientName(ContainerRegistry.RepositoryChangeableAttributes,
  "RepositoryWriteableProperties",
  "python"
);

// Client name mappings for ContainerRepositoryProperties
@@clientName(ContainerRegistry.ContainerRepositoryProperties.registry,
  "registryLoginServer"
);
@@clientName(ContainerRegistry.ContainerRepositoryProperties.imageName, "name");
@@clientName(ContainerRegistry.ContainerRepositoryProperties.createdTime,
  "createdOn"
);
@@clientName(ContainerRegistry.ContainerRepositoryProperties.lastUpdateTime,
  "lastUpdatedOn"
);

// Client name mappings for RepositoryChangeableAttributes
@@clientName(ContainerRegistry.RepositoryChangeableAttributes.deleteEnabled,
  "canDelete"
);
@@clientName(ContainerRegistry.RepositoryChangeableAttributes.writeEnabled,
  "canWrite"
);
@@clientName(ContainerRegistry.RepositoryChangeableAttributes.listEnabled,
  "canList"
);
@@clientName(ContainerRegistry.RepositoryChangeableAttributes.readEnabled,
  "canRead"
);

// Client name mappings for DeleteRepositoryResult
@@clientName(ContainerRegistry.DeleteRepositoryResult.manifestsDeleted,
  "deletedManifests"
);
@@clientName(ContainerRegistry.DeleteRepositoryResult.tagsDeleted,
  "deletedTags"
);

// Client name mappings for TagList
@@clientName(ContainerRegistry.TagList.registry, "registryLoginServer");
@@clientName(ContainerRegistry.TagList.imageName, "repository");
@@clientName(ContainerRegistry.TagList.tags, "tagAttributeBases");

// Client name mappings for TagAttributesBase
@@clientName(ContainerRegistry.TagAttributesBase.createdTime, "createdOn");
@@clientName(ContainerRegistry.TagAttributesBase.lastUpdateTime,
  "lastUpdatedOn"
);

// Client name mappings for TagChangeableAttributes
@@clientName(ContainerRegistry.TagChangeableAttributes.deleteEnabled,
  "canDelete"
);
@@clientName(ContainerRegistry.TagChangeableAttributes.writeEnabled,
  "canWrite"
);
@@clientName(ContainerRegistry.TagChangeableAttributes.listEnabled, "canList");
@@clientName(ContainerRegistry.TagChangeableAttributes.readEnabled, "canRead");

// Client name mappings for ArtifactTagProperties
@@clientName(ContainerRegistry.ArtifactTagProperties.registry,
  "registryLoginServer"
);
@@clientName(ContainerRegistry.ArtifactTagProperties.imageName,
  "repositoryName"
);

// Client name mappings for AcrManifests
@@clientName(ContainerRegistry.AcrManifests.registry, "registryLoginServer");
@@clientName(ContainerRegistry.AcrManifests.imageName, "repository");

// Client name mappings for ManifestAttributesBase
@@clientName(ContainerRegistry.ManifestAttributesBase.imageSize, "size");
@@clientName(ContainerRegistry.ManifestAttributesBase.createdTime, "createdOn");
@@clientName(ContainerRegistry.ManifestAttributesBase.lastUpdateTime,
  "lastUpdatedOn"
);
@@clientName(ContainerRegistry.ManifestAttributesBase.os, "operatingSystem");
@@clientName(ContainerRegistry.ManifestAttributesBase.references,
  "relatedArtifacts"
);

// Client name mappings for ArtifactManifestPlatform
@@clientName(ContainerRegistry.ArtifactManifestPlatform.os, "operatingSystem");

// Client name mappings for ManifestChangeableAttributes
@@clientName(ContainerRegistry.ManifestChangeableAttributes.deleteEnabled,
  "canDelete"
);
@@clientName(ContainerRegistry.ManifestChangeableAttributes.writeEnabled,
  "canWrite"
);
@@clientName(ContainerRegistry.ManifestChangeableAttributes.listEnabled,
  "canList"
);
@@clientName(ContainerRegistry.ManifestChangeableAttributes.readEnabled,
  "canRead"
);

// Client name mappings for ArtifactManifestProperties
@@clientName(ContainerRegistry.ArtifactManifestProperties.registry,
  "registryLoginServer"
);
@@clientName(ContainerRegistry.ArtifactManifestProperties.imageName,
  "repositoryName"
);
