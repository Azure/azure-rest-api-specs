import "./main.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(ContainerRegistryService, "ContainerRegistry");
// Rename ChangeableAttributes models to WriteableProperties for Python SDK backward compatibility
@@clientName(ContainerRegistryService.ManifestChangeableAttributes,
  "ManifestWriteableProperties",
  "python"
);
@@clientName(ContainerRegistryService.TagChangeableAttributes,
  "TagWriteableProperties",
  "python"
);
@@clientName(ContainerRegistryService.RepositoryChangeableAttributes,
  "RepositoryWriteableProperties",
  "python"
);
