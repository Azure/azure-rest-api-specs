import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Relationships;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@@clientName(Microsoft.Relationships, "RelationshipsMgmtClient", "python");

@@clientName(RelationshipOrigins, "RelationshipOriginType", "csharp");
@@alternateType(RelationshipMetadata.sourceType, armResourceType, "csharp");
@@alternateType(RelationshipMetadata.targetType, armResourceType, "csharp");
@@clientName(ProvisioningState, "RelationshipProvisioningState", "csharp");

// Go SDK: preserve the original public model name for the 2026 shape while
// assigning a distinct name to the legacy model to avoid a duplicate client name.
@@clientName(
  ServiceGroupMemberRelationshipProperties,
  "ServiceGroupMemberRelationshipPropertiesLegacy",
  "go"
);

@@clientName(
  ServiceGroupMemberRelationshipPropertiesV2,
  "ServiceGroupMemberRelationshipProperties",
  "go"
);
