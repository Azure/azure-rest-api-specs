import { describe, expect, it } from "vitest";
import {
  getResourceType,
  isOperationsPath,
  isResourceGroupScoped,
  isSubscriptionScoped,
} from "../src/arm-resource-types.js";

describe("getResourceType", () => {
  it("extracts top-level resource type under resource group scope", () => {
    expect(
      getResourceType(
        "/subscriptions/{subscriptionId}/resourceGroups/{rg}/providers/Microsoft.Compute/virtualMachines/{name}",
      ),
    ).toBe("Microsoft.Compute/virtualMachines");
  });

  it("extracts nested resource type", () => {
    expect(
      getResourceType(
        "/subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}/extensions/{ext}",
      ),
    ).toBe("Microsoft.Compute/virtualMachines/extensions");
  });

  it("extracts root-level provider path (operations endpoint)", () => {
    expect(getResourceType("/providers/Microsoft.Compute/operations")).toBe(
      "Microsoft.Compute/operations",
    );
  });

  it("handles paths with only provider namespace and no resource path", () => {
    expect(getResourceType("/providers/Microsoft.Compute")).toBe("Microsoft.Compute");
  });

  it("returns null for paths with no /providers/ segment", () => {
    expect(getResourceType("/subscriptions/{id}/resourceGroups/{rg}")).toBeNull();
  });

  it("strips path parameters to return static type only", () => {
    expect(
      getResourceType(
        "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Foo/superDisks/{diskName}",
      ),
    ).toBe("Microsoft.Foo/superDisks");
  });

  it("handles new resource type in PR context (the superDisk case)", () => {
    expect(
      getResourceType(
        "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/superDisks/{diskName}",
      ),
    ).toBe("Microsoft.Compute/superDisks");
  });

  it("returns provider only when type hierarchy contains only path parameters", () => {
    // e.g. /providers/Microsoft.Foo/{id}  → only a param, no static type
    expect(getResourceType("/providers/Microsoft.Foo/{id}")).toBe("Microsoft.Foo");
  });

  it("handles three-level nesting", () => {
    expect(
      getResourceType(
        "/subscriptions/{id}/resourceGroups/{rg}/providers/Microsoft.Network/virtualNetworks/{vnet}/subnets/{subnet}/serviceEndpointPolicies/{policyName}",
      ),
    ).toBe("Microsoft.Network/virtualNetworks/subnets/serviceEndpointPolicies");
  });
});

describe("isOperationsPath", () => {
  it("returns true for Microsoft.Compute/operations", () => {
    expect(isOperationsPath("Microsoft.Compute/operations")).toBe(true);
  });

  it("returns false for resource types", () => {
    expect(isOperationsPath("Microsoft.Compute/virtualMachines")).toBe(false);
  });

  it("returns false for nested resource types ending in a real type", () => {
    expect(isOperationsPath("Microsoft.Compute/virtualMachines/extensions")).toBe(false);
  });

  it("is case-insensitive for 'operations'", () => {
    expect(isOperationsPath("Microsoft.Compute/Operations")).toBe(true);
    expect(isOperationsPath("Microsoft.Compute/OPERATIONS")).toBe(true);
  });
});

describe("isResourceGroupScoped", () => {
  it("returns true for a resource group scoped path", () => {
    expect(
      isResourceGroupScoped(
        "/subscriptions/{id}/resourceGroups/{rg}/providers/Microsoft.Compute/virtualMachines/{name}",
      ),
    ).toBe(true);
  });

  it("returns false for a subscription-only scoped path", () => {
    expect(
      isResourceGroupScoped(
        "/subscriptions/{id}/providers/Microsoft.Compute/locations/{location}/sizes",
      ),
    ).toBe(false);
  });

  it("returns false for a tenant-level path", () => {
    expect(isResourceGroupScoped("/providers/Microsoft.Management/managementGroups/{id}")).toBe(
      false,
    );
  });
});

describe("isSubscriptionScoped", () => {
  it("returns true for a subscription-only scoped path", () => {
    expect(
      isSubscriptionScoped(
        "/subscriptions/{id}/providers/Microsoft.Compute/locations/{location}/sizes",
      ),
    ).toBe(true);
  });

  it("returns false for a resource group scoped path", () => {
    expect(
      isSubscriptionScoped(
        "/subscriptions/{id}/resourceGroups/{rg}/providers/Microsoft.Compute/virtualMachines/{name}",
      ),
    ).toBe(false);
  });

  it("returns false for a tenant-level path", () => {
    expect(isSubscriptionScoped("/providers/Microsoft.Management/managementGroups/{id}")).toBe(
      false,
    );
  });
});
