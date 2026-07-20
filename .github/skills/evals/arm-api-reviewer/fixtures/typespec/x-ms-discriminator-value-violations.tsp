// TypeSpec fixture: x-ms-discriminator-value violations (TSP-EXT-DISCRIMINATOR)
// Seeded violations:
//   - @extension("x-ms-discriminator-value", "Cat") on a derived model (FORBIDDEN -- use literal-typed discriminator property)
//   - @extension("x-ms-discriminator-value", "Dog") on a derived model (FORBIDDEN -- same issue)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - @discriminator("kind") on base model + literal kind property on each variant

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Pet Registry Service",
})
@versioned(Versions)
namespace Microsoft.PetRegistryService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

// ---- Seeded violations: @extension("x-ms-discriminator-value", ...) pattern ----

/** Base animal model (violation: no @discriminator, variants use @extension). */
model AnimalBase {
  /** The kind of animal. */
  kind: string;

  /** The animal's name. */
  name: string;
}

// Violation #1: @extension("x-ms-discriminator-value", "Cat") is FORBIDDEN.
// Correct fix: add @discriminator("kind") to AnimalBase and give Cat a literal kind property.
/** A cat. */
@extension("x-ms-discriminator-value", "Cat")
model Cat extends AnimalBase {
  /** Volume level for meowing. */
  meowVolume?: int32;
}

// Violation #2: @extension("x-ms-discriminator-value", "Dog") is FORBIDDEN.
/** A dog. */
@extension("x-ms-discriminator-value", "Dog")
model Dog extends AnimalBase {
  /** Volume level for barking. */
  barkVolume?: int32;
}

// ---- Positive controls: correct discriminated union pattern ----

/** Base vehicle model using the correct @discriminator pattern. */
@discriminator("vehicleType")
model VehicleBase {
  /** The type of vehicle. */
  vehicleType: string;

  /** The vehicle's registration number. */
  registrationNumber: string;
}

// Positive control #1: literal-typed discriminator property on Car -- should NOT be flagged.
/** A car. */
model CarVehicle extends VehicleBase {
  /** Discriminator value is a string literal -- no @extension needed. */
  vehicleType: "Car";

  /** Number of doors. */
  doorCount?: int32;
}

// Positive control #2: literal-typed discriminator property on Truck -- should NOT be flagged.
/** A truck. */
model TruckVehicle extends VehicleBase {
  vehicleType: "Truck";

  /** Payload capacity in kg. */
  payloadKg?: int32;
}

@segment("petRegistries")
model PetRegistry is TrackedResource<PetRegistryProperties> {
  @key("registryName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a pet registry. */
model PetRegistryProperties {
  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** The featured vehicle model (positive control). */
  featuredVehicle?: VehicleBase;
}

@armResourceOperations
interface PetRegistries {
  get is ArmResourceRead<PetRegistry>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PetRegistry>;
  update is ArmResourcePatchAsync<PetRegistry, PetRegistryProperties>;
  delete is ArmResourceDeleteAsync<PetRegistry>;
  listByResourceGroup is ArmResourceListByParent<PetRegistry>;
  listBySubscription is ArmListBySubscription<PetRegistry>;
}

interface Operations extends Azure.ResourceManager.Operations {}
