import "../LiftrBase/main.tsp";

import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase;

@versioned(LiftrBase.Data.Versions)
namespace LiftrBase.Data;

@doc("Supported versions for LiftrBase.Data resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1 and LiftrBase.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2024-08-01-preview",
}

@doc("Properties specific to Data Organization resource")
model OrganizationProperties is BaseResourceProperties {
  @doc("Organization properties")
  partnerOrganizationProperties?: PartnerOrganizationProperties;
}

@doc("Properties specific to Partner's organization")
model PartnerOrganizationProperties {
  @doc("Organization Id in partner's system")
  organizationId?: string;

  @doc("Organization name in partner's system")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @minLength(1)
  @maxLength(50)
  organizationName: string;

  @doc("Single Sign On properties for the organization")
  singleSignOnProperties?: SingleSignOnProperties;
}
