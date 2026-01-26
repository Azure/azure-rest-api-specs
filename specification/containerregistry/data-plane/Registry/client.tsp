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
