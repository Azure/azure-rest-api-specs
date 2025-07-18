import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace SdkCustomizations;

// C# specific customizations
// @@clientName(DiskOptions, "ResourceManagerDiskConfiguration", "csharp");
// @@clientName(Wrapper, "ResourceManagerDiskConfigurationWrapper", "csharp");