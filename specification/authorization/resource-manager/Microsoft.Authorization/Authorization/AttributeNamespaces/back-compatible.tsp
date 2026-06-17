import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AttributeNamespaces;

@@clientName(AttributeNamespaces.create::parameters.body, "parameters");
