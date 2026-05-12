import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./Microsoft.AttributeNamespaces/main.tsp";
import "./Microsoft.AccessReview/main.tsp";
import "./Microsoft.Authorization/main.tsp";
import "./Microsoft.ClassicAdmin/main.tsp";
import "./Microsoft.DenyAssignment/main.tsp";
import "./Microsoft.ProviderOperations/main.tsp";
import "./Microsoft.RoleAssignment/main.tsp";
import "./Microsoft.RoleDefinitions/main.tsp";
import "./Microsoft.RoleManagementAlerts/main.tsp";

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

#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
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

@@clientName(
  Microsoft.AuthorizationCombinedClient,
  "AuthorizationManagementClient",
  "javascript,python"
);
@@alternateType(
  Microsoft.DenyAssignment.DenyAssignmentPrincipalType,
  string,
  "go,python"
);
@@clientName(EligibleChildResourcesOperationGroup.get, "list", "javascript");
@@clientName(
  Microsoft.Authorization.UsersOrServicePrincipalSetUserType,
  "UserType",
  "python"
);
@@clientName(Microsoft.Authorization.UserType, "CommonUserType", "python");

@@usage(
  Microsoft.RoleAssignment.RoleAssignment,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  Microsoft.ProviderOperations.ProviderOperationsMetadataGetParameters.$expand,
  "resourceTypes",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  Microsoft.ProviderOperations.ProviderOperationsMetadataListParameters.$expand,
  "resourceTypes",
  "python"
);
