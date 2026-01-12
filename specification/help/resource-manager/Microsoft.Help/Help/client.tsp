import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Help;

@@clientName(Solutions, "SolutionMetadatas", "csharp");
@@clientName(ValidationScope.IpAddressFormat, "IPAddressFormat", "csharp");