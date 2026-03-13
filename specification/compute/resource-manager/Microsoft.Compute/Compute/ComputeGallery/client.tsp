import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComputeGallery;

// C# enum singular←plural rename
@@clientName(SharedToValues, "SharedToValue", "csharp");
