import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Genome;

// Model renames for .NET SDK naming conventions (AZC0030, AZC0012)
@@clientName(UploadResponse, "DataIngestionUpload", "csharp");
@@clientName(UploadStatus, "DataIngestionUploadStatus", "csharp");
