import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Genome;

// Operation names
@@clientName(uploadDocuments, "uploadDocuments");

// Model renames for .NET SDK naming conventions (AZC0030)
@@clientName(UploadResponse, "DocumentUpload", "csharp");
