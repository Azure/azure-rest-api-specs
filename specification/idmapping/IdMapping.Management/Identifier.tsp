import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IdMapping;

/** Defines the Identifier */
@singleton
model Identifier is ExtensionResource<IdentifierProperties> {
  /** Name of the Identifier. */
  @key("resourceid")
  @segment("identifiers")
  @visibility(Lifecycle.Read)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  name: string;
}

/** Defines the Identifier properties. */
model IdentifierProperties {
  /** The resource type of the resource */
  resourceType: string;

  /** The fully qualified resource id of the resource */
  resourceId: string;

  /** Provisioning state of the activation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** Timestamp in UTC format. */
  identifierCreationTimestamp?: utcDateTime;

  /** The new created resourceIdentifier for the resource */
  @Azure.ResourceManager.identifiers(#[])
  resourceIdentifiers: ResourceIdentifier[];
}

/** Defines the ResourceIdentifier */
model ResourceIdentifier {
  /** The Internal Id name */
  name: string;

  /** The Internal Id value */
  value: string;
}

@armResourceOperations
interface Identifiers {
  @summary("Gets Identifier.")
  get is ArmResourceRead<Identifier>;
}
