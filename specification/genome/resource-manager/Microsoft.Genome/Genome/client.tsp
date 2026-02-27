import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.Genome;

@@clientName(GenomeAccounts.create, "beginCreate");
@@clientName(GenomeAccounts.update, "beginUpdate");
@@clientName(GenomeAccounts.delete, "beginDelete");
