import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace RegionalMoveClient;

/** The regional move container provisioning state */
union RegionalMoveProvisioningState {
  ResourceProvisioningState,

  /** The regional move container has been successfully created but not started. */
  Created: "Created",

  /** The regional move container operations are in progress. */
  InProgress: "InProgress",

  /** The regional move container is awaiting the user to invoke finalization on one or more resources. */
  InProgressAwaitingFinalization: "InProgressAwaitingFinalization",
}

model RegionalMoveContainer
  is TrackedResource<
    RegionalMoveContainerProperties,
    PropertiesOptional = false
  > {
  ...ResourceNameParameter<
    Resource = RegionalMoveContainer,
    KeyName = "moveContainerName",
    SegmentName = "regionalMoveContainers",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@@maxLength(RegionalMoveContainer.name, 90);
@@minLength(RegionalMoveContainer.name, 1);
@@doc(RegionalMoveContainer.name,
  "The name of the Regional Move Container resource"
);

/** The properties of a Regional Move Container */
model RegionalMoveContainerProperties {
  // for non-terminal state, we can consider:
  // - Accepted (indicates that the entity was created successfully but no job started yet)
  // - Running/InProgress (indicates that the job is in progress)
  // - <Terminal states>
  /** The ARM provisioning state of the Regional Move Container. */
  @visibility(Lifecycle.Read)
  provisioningState?: RegionalMoveProvisioningState;

  /** The location from which resources will be copied. */
  sourceLocation: string;

  /** The location to which resources will be copied. */
  targetLocation: string;

  /** The list of resources to be copied. */
  @identifiers(#["sourceResourceId"])
  requestedResources: ResourceMoveRequest[];

  ...ErrorResponse;
}

/** Information about the resource to be copied */
model ResourceMoveRequest {
  /** Resource ID of the resource being copied */
  sourceResourceId: string;

  /** Resource ID where the source will be copied/moved to. For copy operations, this cannot be the same as the source. */
  targetResourceId: string;

  /** Properties to be overridden/modified on the resource during the copy operation. The resource provider will reject invalid modifications. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This needs to include properties of any arbitrary resource type."
  resourceProperties?: Record<unknown>;

  /** The API version to use to perform the copy operation. */
  apiVersion: string;
}
