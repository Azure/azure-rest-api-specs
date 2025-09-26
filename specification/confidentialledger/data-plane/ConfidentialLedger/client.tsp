import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ConfidentialLedger;

namespace Customizations;

@@clientName(Roles, "UserRoles", "csharp");
