import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./discoveryHub.tsp";

using Azure.Core;

namespace Microsoft.ApplicationMigration;

/**
 * Model representing the properties of an application.
 */
model ApplicationProperties {
  @doc("The display name of the application.")
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "We are using the record datatype to represent the tags as it is not supported for proxy resources in ARM yet"
  @doc("The tags of the application.")
  tags?: Record<string>;

  @doc("The description of the application.")
  description?: string;

  @doc("The publisher of the application.")
  publisher?: string;

  @doc("The type of the application.")
  applicationType?: ApplicationType;

  @doc("The technology stack of the application.")
  technologyStack?: string[];

  @doc("The business criticality of the application.")
  businessCriticality?: BusinessCriticality;

  @doc("The complexity of the application.")
  complexity?: Complexity;

  @doc("The provisioning status of Application.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Model representing the properties of a member.
 */
model MemberProperties {
  @doc("The Azure resource id of the member.")
  memberResourceId: armResourceIdentifier;

  @doc("The provisioning status of Application.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The enum defining type of application.")
union ApplicationType {
  @doc("The application is a Commercial Off the Shelf application.")
  COTS: "COTS",

  @doc("The application is a custom developed application.")
  Custom: "Custom",

  string,
}

@doc("The enum defining the business criticality of the application.")
union BusinessCriticality {
  @doc("The application has low criticality for the business.")
  Low: "Low",

  @doc("The application has medium criticality for the business.")
  Medium: "Medium",

  @doc("The application is highly critical for the business.")
  High: "High",

  string,
}

@doc("The enum defining the complexity of the application.")
union Complexity {
  @doc("The application is simple, with minimal dependencies and straightforward functionality.")
  Low: "Low",

  @doc("The application has moderate interdependencies and requires some coordination between components.")
  Medium: "Medium",

  @doc("The application is intricate, with multiple interdependent components and complex interactions.")
  High: "High",

  string,
}
