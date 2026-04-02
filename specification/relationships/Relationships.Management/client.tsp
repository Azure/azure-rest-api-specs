import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Relationships;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace Microsoft.Relationships {
  @doc("DependencyOf relationship resource for create or update.")
  model DependencyOfRelationshipCreateOrUpdate
    is ExtensionResource<DependencyOfRelationshipPropertiesCreateOrUpdate> {
    @doc("Name of dependencyOf relationship.")
    @pattern("^[a-zA-Z0-9]{3,64}$")
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
    @doc("Name of ServiceGroupMember relationship.")
    @pattern("^[a-zA-Z0-9]{3,64}$")
    @key
    @path
    @segment("serviceGroupMember")
    name: string;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model ServiceGroupMemberRelationshipPropertiesCreateOrUpdate {
    @doc("The relationship target resource id.")
    targetId: armResourceIdentifier<[
      {
        type: "Microsoft.Management/serviceGroups";
        scopes: ["Tenant"];
      }
    ]>;

    @doc("The relationship target tenant id.")
    targetTenant?: string;
  }
}

// JavaScript SDK: use CreateOrUpdate-specific resource model for write operations,
// which omits server-side read-only fields (sourceId, originInformation, metadata, etc.)
@@alternateType(DependencyOfRelationships.createOrUpdate::parameters.resource,
  DependencyOfRelationshipCreateOrUpdate,
  "javascript"
);
@@alternateType(ServiceGroupMemberRelationships.createOrUpdate::parameters.resource,
  ServiceGroupMemberRelationshipCreateOrUpdate,
  "javascript"
);
