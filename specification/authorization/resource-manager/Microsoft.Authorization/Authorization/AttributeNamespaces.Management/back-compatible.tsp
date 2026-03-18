import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

@@clientName(AttributeNamespaces.create::parameters.body, "parameters");
