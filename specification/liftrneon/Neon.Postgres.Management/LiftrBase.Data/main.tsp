import "../LiftrBase/main.tsp";
import "../Neon.Postgres.Models/projects.tsp";

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
  v1_preview: "2024-12-22-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2_preview: "2025-03-01-preview",
}

@doc("Properties specific to Neon Organization resource")
model OrganizationProperties is BaseResourceProperties {
  @doc("Neon Organization properties")
  partnerOrganizationProperties?: PartnerOrganizationProperties;

  @doc("Neon Project Properties")
  @added(Versions.v2_preview)
  projectProperties?: Neon.Postgres.ProjectProperties;
}

@doc("Properties specific to Partner's organization")
model PartnerOrganizationProperties {
  @doc("Organization Id in partner's system")
  organizationId?: string;

  @doc("Organization name in partner's system")
  @pattern("^\\S.{0,62}\\S$|^\\S$")
  @minLength(1)
  @maxLength(50)
  organizationName: string;

  @doc("Single Sign On properties for the organization")
  singleSignOnProperties?: SingleSignOnProperties;
}
