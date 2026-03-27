import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./AccessReview.Management/main.tsp";
import "./AttributeNamespaces.Management/main.tsp";
import "./Authorization.Management/main.tsp";
import "./ClassicAdmin.Management/main.tsp";
import "./DenyAssignment.Management/main.tsp";
import "./ProviderOperations.Management/main.tsp";
import "./RoleAssignment.Management/main.tsp";
import "./RoleDefinitions.Management/main.tsp";
import "./RoleManagementAlerts.Management/main.tsp";

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
namespace Microsoft.Authorization;
