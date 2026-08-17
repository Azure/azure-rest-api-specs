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

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace Microsoft.Relationships {
  @doc("DependencyOf relationship resource for create or update.")
  model DependencyOfRelationshipCreateOrUpdate
    is ExtensionResource<DependencyOfRelationshipPropertiesCreateOrUpdate> {
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Name validation is owned by the RP service code from 2026-03-01-preview; the published swagger intentionally omits a name pattern so RPaaS does not gate names."
    @doc("Name of dependencyOf relationship.")
    @key
    @path
    @segment("dependencyOf")
    name: string;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model DependencyOfRelationshipPropertiesCreateOrUpdate {
    @doc("The relationship target resource id.")
    targetId: armResourceIdentifier;

    @doc("The relationship target tenant id.")
    targetTenant?: string;
  }

  @doc("ServiceGroupMember relationship resource for create or update.")
  model ServiceGroupMemberRelationshipCreateOrUpdate
    is ExtensionResource<ServiceGroupMemberRelationshipPropertiesCreateOrUpdate> {
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Name validation is owned by the RP service code from 2026-03-01-preview; the published swagger intentionally omits a name pattern so RPaaS does not gate names."
    @doc("Name of ServiceGroupMember relationship.")
    @key
    @path
    @segment("serviceGroupMember")
    name: string;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model ServiceGroupMemberRelationshipPropertiesCreateOrUpdate {
    @added(Versions.`2026-03-01-preview`)
    @doc("The relationship source resource id. Must be a service group.")
    sourceId: armResourceIdentifier;

    @removed(Versions.`2026-03-01-preview`)
    @doc("The relationship target resource id.")
    targetId: armResourceIdentifier<[
      {
        type: "Microsoft.Management/serviceGroups";
        scopes: ["Tenant"];
      }
    ]>;

    @added(Versions.`2026-03-01-preview`)
    @doc("The relationship source tenant id.")
    sourceTenant?: string;

    @removed(Versions.`2026-03-01-preview`)
    @doc("The relationship target tenant id.")
    targetTenant?: string;
  }
}

// JavaScript SDK: use CreateOrUpdate-specific resource model for write operations,
// which omits server-side read-only fields (sourceId, originInformation, metadata, etc.)
@@alternateType(
  DependencyOfRelationships.createOrUpdate::parameters.resource,
  DependencyOfRelationshipCreateOrUpdate,
  "javascript"
);
@@alternateType(
  ServiceGroupMemberRelationships.createOrUpdate::parameters.resource,
  ServiceGroupMemberRelationshipCreateOrUpdate,
  "javascript"
);

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
