import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./AccessReview/main.tsp";
import "./AttributeNamespaces/main.tsp";
import "./Authorization/main.tsp";
import "./ClassicAdmin/main.tsp";
import "./DenyAssignment/main.tsp";
import "./ProviderOperations/main.tsp";
import "./RoleAssignment/main.tsp";
import "./RoleDefinitions/main.tsp";
import "./RoleManagementAlerts/main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Microsoft.AccessReview;
using Microsoft.AttributeNamespaces;
using Microsoft.Authorization;
using Microsoft.ClassicAdmin;
using Microsoft.DenyAssignment;
using Microsoft.ProviderOperations;
using Microsoft.RoleAssignment;
using Microsoft.RoleDefinitions;
using Microsoft.RoleManagementAlerts;

@client({
  name: "CombineClient",
  service: [
    Microsoft.AccessReview,
    Microsoft.AttributeNamespaces,
    Microsoft.Authorization,
    Microsoft.ClassicAdmin,
    Microsoft.DenyAssignment,
    Microsoft.ProviderOperations,
    Microsoft.RoleAssignment,
    Microsoft.RoleDefinitions,
    Microsoft.RoleManagementAlerts
  ],
  autoMergeService: true,
})
namespace Microsoft.AuthorizationCombinedClient;

@@clientName(Microsoft.AuthorizationCombinedClient,
  "AuthorizationManagementClient",
  "javascript"
);
@@clientName(EligibleChildResourcesOperationGroup.get, "list", "javascript");
