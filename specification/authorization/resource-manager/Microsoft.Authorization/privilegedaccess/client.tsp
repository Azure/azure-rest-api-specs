import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.PrivilegedAccess,
  "AuthorizationManagementClient",
  "javascript,python"
);
@@clientName(
  Microsoft.PrivilegedAccess.ResourceProjection.parentResource,
  "parent",
  "csharp"
);
@@clientName(
  Microsoft.PrivilegedAccess.MemberType,
  "PrivilegedResourceMemberType",
  "csharp,java,python,go,javascript"
);
