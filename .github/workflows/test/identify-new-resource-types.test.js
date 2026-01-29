import { describe, expect, test, vi, beforeEach } from "vitest";
import { 
  formatSummary, 
  loadSwaggerFile, 
  compareResourceTypes, 
  checkMultipleFiles,
  getResourceTypesFromSwagger 
} from "../src/identify-new-resource-types.js";

// Mock dependencies
vi.mock('../../shared/src/swagger.js', () => ({
  Swagger: vi.fn().mockImplementation(() => ({
    getContentObject: vi.fn().mockResolvedValue({ paths: {}, definitions: {} })
  }))
}));

vi.mock('child_process', () => ({
  execSync: vi.fn()
}));

vi.mock('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js', () => ({
  ArmHelper: vi.fn().mockImplementation(() => ({
    getAllResources: vi.fn().mockReturnValue([])
  }))
}));

vi.mock('@microsoft.azure/openapi-validator-core', () => ({
  SwaggerInventory: vi.fn()
}));

describe("formatSummary", () => {
  test("returns message when no new types", () => {
    const summary = formatSummary([]);
    expect(summary).toBe('No new resource types detected');
  });
  
  test("formats single new resource type with operations", () => {
    const results = [{
      file: "specification/compute/swagger.json",
      newTypes: [{
        resourceType: "Microsoft.Compute/virtualMachines",
        provider: "Microsoft.Compute",
        operations: ["GET", "PUT"]
      }]
    }];
    
    const summary = formatSummary(results);
    
    expect(summary).toContain('New Resource Types (1)');
    expect(summary).toContain('Microsoft.Compute/virtualMachines');
    expect(summary).toContain('Operations: GET, PUT');
    expect(summary).toContain('https://aka.ms/modelling-officehours');
  });
  
  test("formats multiple resource types", () => {
    const results = [{
      file: "specification/network/swagger.json",
      newTypes: [
        { resourceType: "Microsoft.Network/virtualNetworks", provider: "Microsoft.Network", operations: ["GET"] },
        { resourceType: "Microsoft.Network/loadBalancers", provider: "Microsoft.Network", operations: ["PUT"] }
      ]
    }];
    
    const summary = formatSummary(results);
    expect(summary).toContain('New Resource Types (2)');
    expect(summary).toContain('Microsoft.Network/virtualNetworks');
    expect(summary).toContain('Microsoft.Network/loadBalancers');
  });
});

describe("Resource Type Extraction", () => {
  const RESOURCE_TYPE_REGEX = /\/providers\/([^\/]+\/[^\/\{]+)/;
  const PROVIDER_REGEX = /\/providers\/([^\/]+)\//;
  
  test("extracts resource type from ARM paths", () => {
    const testCases = [
      { 
        path: "/subscriptions/{id}/resourceGroups/{rg}/providers/Microsoft.Compute/virtualMachines/{name}",
        expectedType: "Microsoft.Compute/virtualMachines",
        expectedProvider: "Microsoft.Compute"
      },
      { 
        path: "/subscriptions/{id}/providers/Microsoft.Network/virtualNetworks/{name}/subnets/{subnet}",
        expectedType: "Microsoft.Network/virtualNetworks",
        expectedProvider: "Microsoft.Network"
      },
      { 
        path: "/providers/Microsoft.Management/managementGroups/{id}",
        expectedType: "Microsoft.Management/managementGroups",
        expectedProvider: "Microsoft.Management"
      }
    ];
    
    testCases.forEach(({ path, expectedType, expectedProvider }) => {
      expect(path.match(RESOURCE_TYPE_REGEX)[1]).toBe(expectedType);
      expect(path.match(PROVIDER_REGEX)[1]).toBe(expectedProvider);
    });
  });
  
  test("returns null for non-ARM paths", () => {
    const path = "/api/v1/resources/{id}";
    expect(path.match(RESOURCE_TYPE_REGEX)).toBeNull();
  });
});

describe("getResourceTypesFromSwagger", () => {
  test("extracts resource types using ArmHelper", async () => {
    const { ArmHelper } = await import('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js');
    
    ArmHelper.mockImplementationOnce(() => ({
      getAllResources: () => [{
        modelName: "VirtualMachine",
        operations: [{
          method: "GET",
          apiPath: "/subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}"
        }]
      }]
    }));
    
    const result = getResourceTypesFromSwagger({}, "test.json");
    
    expect(result.size).toBe(1);
    expect(result.has("Microsoft.Compute/virtualMachines")).toBe(true);
  });
  
  test("handles multiple resources", async () => {
    const { ArmHelper } = await import('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js');
    
    ArmHelper.mockImplementationOnce(() => ({
      getAllResources: () => [
        {
          modelName: "VM",
          operations: [{ method: "GET", apiPath: "/providers/Microsoft.Compute/virtualMachines/{name}" }]
        },
        {
          modelName: "VNet",
          operations: [{ method: "PUT", apiPath: "/providers/Microsoft.Network/virtualNetworks/{name}" }]
        }
      ]
    }));
    
    const result = getResourceTypesFromSwagger({}, "test.json");
    
    expect(result.size).toBe(2);
    expect(result.has("Microsoft.Compute/virtualMachines")).toBe(true);
    expect(result.has("Microsoft.Network/virtualNetworks")).toBe(true);
  });
  
  test("skips resources without valid resource type", async () => {
    const { ArmHelper } = await import('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js');
    
    ArmHelper.mockImplementationOnce(() => ({
      getAllResources: () => [{
        modelName: "InvalidResource",
        operations: [{ method: "GET", apiPath: "/api/invalid/path" }]
      }]
    }));
    
    const result = getResourceTypesFromSwagger({}, "test.json");
    
    expect(result.size).toBe(0);
  });
});

describe("loadSwaggerFile", () => {
  test("loads swagger file successfully", async () => {
    const { Swagger } = await import('../../shared/src/swagger.js');
    const mockDoc = { swagger: "2.0", paths: {} };
    
    Swagger.mockImplementationOnce(() => ({
      getContentObject: vi.fn().mockResolvedValue(mockDoc)
    }));
    
    const result = await loadSwaggerFile("test.json");
    
    expect(result).toEqual(mockDoc);
  });
});

describe("compareResourceTypes", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });
  
  test("identifies new resource types", async () => {
    const { Swagger } = await import('../../shared/src/swagger.js');
    const { ArmHelper } = await import('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js');
    const { execSync } = await import('child_process');
    
    // Current branch has new resource
    Swagger.mockImplementationOnce(() => ({
      getContentObject: vi.fn().mockResolvedValue({})
    }));
    
    ArmHelper.mockImplementationOnce(() => ({
      getAllResources: () => [{
        modelName: "VM",
        operations: [{ method: "GET", apiPath: "/providers/Microsoft.Compute/virtualMachines/{name}" }]
      }]
    }));
    
    // Base branch returns null (file doesn't exist)
    execSync.mockReturnValueOnce(null);
    
    const result = await compareResourceTypes("test.json", "main");
    
    expect(result.newTypes).toHaveLength(1);
    expect(result.newTypes[0].resourceType).toBe("Microsoft.Compute/virtualMachines");
  });
  
  test("returns empty when no new types", async () => {
    const { Swagger } = await import('../../shared/src/swagger.js');
    const { ArmHelper } = await import('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js');
    const { execSync } = await import('child_process');
    
    const mockSwaggerContent = JSON.stringify({});
    
    Swagger.mockImplementation(() => ({
      getContentObject: vi.fn().mockResolvedValue({})
    }));
    
    ArmHelper.mockImplementation(() => ({
      getAllResources: () => []
    }));
    
    execSync.mockReturnValueOnce(mockSwaggerContent);
    
    const result = await compareResourceTypes("test.json", "main");
    
    expect(result.newTypes).toHaveLength(0);
  });
});

describe("checkMultipleFiles", () => {
  test("processes multiple files and filters results", async () => {
    const { Swagger } = await import('../../shared/src/swagger.js');
    const { ArmHelper } = await import('@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js');
    const { execSync } = await import('child_process');
    
    Swagger.mockImplementation(() => ({
      getContentObject: vi.fn().mockResolvedValue({})
    }));
    
    // First file has new type, second doesn't
    let callCount = 0;
    ArmHelper.mockImplementation(() => ({
      getAllResources: () => {
        callCount++;
        if (callCount === 1) {
          return [{
            modelName: "VM",
            operations: [{ method: "GET", apiPath: "/providers/Microsoft.Compute/virtualMachines/{name}" }]
          }];
        }
        return [];
      }
    }));
    
    execSync.mockReturnValue(null);
    
    const results = await checkMultipleFiles(["file1.json", "file2.json"], "main");
    
    expect(results).toHaveLength(1);
    expect(results[0].file).toBe("file1.json");
  });
});
