import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./AccessReview.Management/main.tsp";
import "./AttributeNamespaces.Management/main.tsp";
import "./Authorization.Management/main.tsp";
import "./ClassicAdmin.Management/main.tsp";
import "./DenyAsssignment.Management/main.tsp";
import "./ProviderOperations.Management/main.tsp";
import "./RoleAssignment.Management/main.tsp";
import "./RoleDefinitions.Management/main.tsp";
import "./RoleManagementAlerts.Management/main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.Authorization;
