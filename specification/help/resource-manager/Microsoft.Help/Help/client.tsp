import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Help;

@@clientName(Solutions, "SolutionMetadatas", "csharp");
@@clientName(ValidationScope.IpAddressFormat, "IPAddressFormat", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(DiscoverySolutionNLPOperationGroup.discoverSolutions, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription, "csharp");