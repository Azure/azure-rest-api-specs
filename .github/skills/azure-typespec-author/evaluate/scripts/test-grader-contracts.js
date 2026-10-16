/* eslint-disable typescript/no-unsafe-assignment, typescript/no-unsafe-call, typescript/no-unsafe-member-access -- Contract tests intentionally mutate dynamic OpenAPI fixtures. */
import * as assert from "node:assert/strict";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import {
  loadOpenApiDocuments,
  verifyArmActionLro,
  verifyArmExtensionResource,
  verifyArmListTopSkip,
  verifyArmNotifyAction,
  verifyArmPatchSync,
  verifyArmTrackedResource,
  verifyDataPlaneList,
  verifyVersion001002,
  verifyVersion001005,
  verifyVersion001007,
  verifyVersion006008,
  verifyVersion006009,
} from "./verify-emitted-contract.js";

function openApi(version, definitions, paths = {}) {
  return {
    document: {
      swagger: "2.0",
      info: { title: "test", version },
      definitions,
      paths,
    },
    file: `${version}.json`,
  };
}

const topSkipDocument = openApi(
  "2024-10-01-preview",
  {},
  {
    "/subscriptions/{subscriptionId}/providers/Microsoft.Widget/employees": {
      get: {
        operationId: "Employees_ListBySubscription",
        parameters: [
          {
            name: "$top",
            in: "query",
            required: false,
            type: "integer",
            format: "int64",
          },
          {
            name: "$skip",
            in: "query",
            required: false,
            type: "integer",
            format: "int64",
          },
        ],
      },
    },
  },
);
verifyArmListTopSkip([topSkipDocument]);
const missingSkip = structuredClone(topSkipDocument);
missingSkip.document.paths[
  "/subscriptions/{subscriptionId}/providers/Microsoft.Widget/employees"
].get.parameters.pop();
assert.throws(() => verifyArmListTopSkip([missingSkip]), /expected \$skip/);
const wrongTopFormat = structuredClone(topSkipDocument);
wrongTopFormat.document.paths[
  "/subscriptions/{subscriptionId}/providers/Microsoft.Widget/employees"
].get.parameters[0].format = "int32";
assert.throws(() => verifyArmListTopSkip([wrongTopFormat]), /\$top must be int64/);

const extensionResource = openApi(
  "2024-10-01-preview",
  {},
  {
    "/{resourceUri}/providers/Microsoft.Widget/employees": {
      get: { operationId: "Employees_List" },
    },
    "/{resourceUri}/providers/Microsoft.Widget/employees/{employeeName}": {
      delete: { operationId: "Employees_Delete" },
      get: { operationId: "Employees_Get" },
      patch: { operationId: "Employees_Update" },
      put: { operationId: "Employees_CreateOrUpdate" },
    },
  },
);
verifyArmExtensionResource([extensionResource]);
const nonExtensionResource = structuredClone(extensionResource);
nonExtensionResource.document.paths = {
  "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Widget/employees":
    {
      get: { operationId: "Employees_List" },
    },
  ...Object.fromEntries(
    Object.entries(extensionResource.document.paths).filter(([route]) =>
      route.includes("{employeeName}"),
    ),
  ),
};
assert.throws(
  () => verifyArmExtensionResource([nonExtensionResource]),
  /must use an extension-resource route/,
);

const trackedResource = openApi(
  "2024-10-01-preview",
  {
    Employee: {
      type: "object",
      allOf: [
        {
          $ref: "#/definitions/Azure.ResourceManager.CommonTypes.TrackedResource",
        },
      ],
      properties: {
        properties: { $ref: "#/definitions/EmployeeProperties" },
      },
    },
    EmployeeProperties: {
      description: "Employee properties",
      type: "object",
      properties: {
        age: { type: "integer", format: "int32" },
        city: { type: "string" },
        profile: { type: "string", format: "base64url" },
        provisioningState: { type: "string", readOnly: true },
      },
    },
  },
  {
    "/employees": {
      get: { operationId: "Employees_ListByResourceGroup", responses: {} },
      put: { operationId: "Employees_CreateOrUpdate", responses: {} },
    },
    "/subscriptions/{subscriptionId}/employees": {
      get: { operationId: "Employees_ListBySubscription", responses: {} },
    },
    "/employees/{employeeName}": {
      get: { operationId: "Employees_Get", responses: {} },
      patch: { operationId: "Employees_Update", responses: {} },
      delete: { operationId: "Employees_Delete", responses: {} },
    },
  },
);
verifyArmTrackedResource([trackedResource]);
const writableProvisioningState = structuredClone(trackedResource);
writableProvisioningState.document.definitions.EmployeeProperties.properties.provisioningState.readOnly = false;
assert.throws(() => verifyArmTrackedResource([writableProvisioningState]), /must be read-only/);

const patchDocument = openApi(
  "2024-10-01-preview",
  {
    EmployeeUpdate: {
      type: "object",
      properties: {
        properties: { $ref: "#/definitions/EmployeePropertiesUpdate" },
      },
      allOf: [
        {
          $ref: "#/definitions/Azure.ResourceManager.CommonTypes.TrackedResourceUpdate",
        },
      ],
    },
    EmployeePropertiesUpdate: {
      type: "object",
      properties: { age: { type: "integer", format: "int32" } },
    },
  },
  {
    "/employees/{employeeName}": {
      patch: {
        operationId: "Employees_Update",
        parameters: [
          {
            name: "properties",
            in: "body",
            schema: { $ref: "#/definitions/EmployeeUpdate" },
          },
        ],
        responses: { 200: { description: "ok" } },
      },
    },
  },
);
verifyArmPatchSync([patchDocument]);
const readOnlyPatch = structuredClone(patchDocument);
readOnlyPatch.document.definitions.EmployeePropertiesUpdate.properties = {
  provisioningState: { type: "string", readOnly: true },
};
assert.throws(() => verifyArmPatchSync([readOnlyPatch]), /exclude read-only provisioningState/);

const lroDocument = openApi(
  "2025-01-01",
  { MoveRequest: {}, MoveResponse: {} },
  {
    "/employees/{employeeName}/move": {
      post: {
        operationId: "Employees_Move",
        "x-ms-long-running-operation": true,
        parameters: [
          {
            name: "body",
            in: "body",
            schema: { $ref: "#/definitions/MoveRequest" },
          },
        ],
        responses: {
          200: {
            description: "done",
            schema: { $ref: "#/definitions/MoveResponse" },
          },
          202: {
            description: "accepted",
            headers: {
              "Azure-AsyncOperation": { type: "string" },
              Location: { type: "string" },
              "Retry-After": { type: "integer" },
            },
          },
        },
      },
    },
  },
);
verifyArmActionLro([lroDocument]);
const missingLocation = structuredClone(lroDocument);
delete missingLocation.document.paths["/employees/{employeeName}/move"].post.responses["202"]
  .headers.Location;
assert.throws(() => verifyArmActionLro([missingLocation]), /must include location/);

const notifyDocument = openApi(
  "2024-10-01-preview",
  {
    NotifyRequest: {
      type: "object",
      properties: {
        message: { type: "string" },
        priority: { $ref: "#/definitions/Priority" },
      },
    },
    NotifyResponse: {
      type: "object",
      properties: {
        notificationId: { type: "string" },
        status: { type: "string" },
      },
    },
    Priority: { type: "string", enum: ["Low", "Medium", "High"] },
  },
  {
    "/employees/{employeeName}/notify": {
      post: {
        operationId: "Employees_Notify",
        parameters: [
          {
            name: "body",
            in: "body",
            schema: { $ref: "#/definitions/NotifyRequest" },
          },
        ],
        responses: {
          200: {
            description: "ok",
            schema: { $ref: "#/definitions/NotifyResponse" },
          },
        },
      },
    },
  },
);
verifyArmNotifyAction([notifyDocument]);
const extensiblePriority = structuredClone(notifyDocument);
extensiblePriority.document.definitions.Priority.enum.push("Urgent");
assert.throws(() => verifyArmNotifyAction([extensiblePriority]), /closed Low\/Medium\/High enum/);

const listResponse = {
  WidgetListResult: {
    type: "object",
    properties: {
      value: {
        type: "array",
        items: { $ref: "#/definitions/WidgetSuite" },
      },
    },
  },
  WidgetSuite: { type: "object", properties: {} },
};
const dataPlaneList = openApi("2022-12-01", listResponse, {
  "/widgets": {
    get: {
      operationId: "Widgets_List",
      responses: {
        200: {
          description: "ok",
          schema: { $ref: "#/definitions/WidgetListResult" },
        },
      },
    },
  },
});
verifyDataPlaneList([dataPlaneList]);
const scalarList = structuredClone(dataPlaneList);
scalarList.document.definitions.WidgetListResult.properties.value = {
  type: "string",
};
assert.throws(() => verifyDataPlaneList([scalarList]), /must contain an array/);

const examplesRoot = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-author-contracts-"));
try {
  for (const version of ["2025-05-04-preview", "2025-01-01"]) {
    const directory = path.join(examplesRoot, "examples", version);
    fs.mkdirSync(directory, { recursive: true });
    fs.writeFileSync(
      path.join(directory, "example.json"),
      JSON.stringify({ parameters: { "api-version": version } }),
    );
  }
  const stable = openApi("2021-10-01", {
    EmployeeProperties: {
      description: "Employee properties",
      properties: {
        age: { type: "integer", format: "int32" },
        assets: { type: "array", items: { type: "string" } },
      },
    },
  });
  const oldPreview = openApi("2021-10-01-preview", {
    EmployeeProperties: {
      description: "Employee properties",
      properties: { age: { type: "integer", format: "int32" } },
    },
  });
  const defaultTarget = openApi("2025-11-01", {
    EmployeeProperties: {
      description: "Employee properties",
      properties: {
        age: { type: "integer", format: "int32", default: 21 },
      },
    },
  });
  verifyVersion001002([oldPreview, stable, defaultTarget]);
  const stableDefaultRegression = structuredClone(stable);
  stableDefaultRegression.document.definitions.EmployeeProperties.properties.age.default = 21;
  assert.throws(
    () => verifyVersion001002([oldPreview, stableDefaultRegression, defaultTarget]),
    /must not gain the new age default/,
  );
  const preview = openApi("2025-05-04-preview", {
    EmployeeProperties: {
      description: "Employee properties",
      properties: {
        age: { type: "integer", format: "int32" },
        assets: { type: "array", items: { type: "string" } },
        workLocation: { $ref: "#/definitions/WorkLocation" },
      },
    },
    WorkLocation: { type: "object", properties: {} },
  });
  verifyVersion001005([stable, preview], examplesRoot);
  const defaultRegression = structuredClone(preview);
  defaultRegression.document.definitions.EmployeeProperties.properties.age.default = 21;
  assert.throws(
    () => verifyVersion001005([stable, defaultRegression], examplesRoot),
    /excluded age default/,
  );

  const promoted = openApi("2025-01-01", {
    EmployeeProperties: {
      description: "Employee properties",
      properties: {
        age: { type: "integer", format: "int32", default: 21 },
        assets: { type: "array", items: { type: "string" } },
      },
    },
  });
  verifyVersion001007([stable, promoted], examplesRoot);
  const excludedRegression = structuredClone(promoted);
  excludedRegression.document.definitions.EmployeeProperties.properties.workLocation = {
    type: "object",
  };
  assert.throws(
    () => verifyVersion001007([stable, excludedRegression], examplesRoot),
    /excluded workLocation/,
  );

  const oldWidget = openApi("2022-12-01", {
    WidgetSuite: {
      type: "object",
      properties: { color: { type: "string" } },
    },
  });
  const removedWidget = openApi("2023-06-01-preview", {
    WidgetSuite: { type: "object", properties: {} },
  });
  verifyVersion006008([oldWidget, removedWidget]);
  const emittedRoot = path.join(examplesRoot, "emitted");
  const stableDirectory = path.join(emittedRoot, "stable", "2022-12-01");
  const previewDirectory = path.join(emittedRoot, "preview", "2023-06-01-preview");
  const previewExamples = path.join(previewDirectory, "examples");
  fs.mkdirSync(stableDirectory, { recursive: true });
  fs.mkdirSync(previewExamples, { recursive: true });
  fs.writeFileSync(
    path.join(stableDirectory, "widgetanalytics.json"),
    JSON.stringify(oldWidget.document),
  );
  fs.writeFileSync(
    path.join(previewDirectory, "widgetanalytics.json"),
    JSON.stringify(removedWidget.document),
  );
  fs.writeFileSync(
    path.join(previewExamples, "example.json"),
    JSON.stringify({ parameters: { "api-version": "2023-06-01-preview" } }),
  );
  const loadedDocuments = loadOpenApiDocuments(emittedRoot);
  assert.equal(loadedDocuments.length, 2, "OpenAPI loader excludes example JSON");
  verifyVersion006008(loadedDocuments);
  const removedTooEarly = structuredClone(oldWidget);
  delete removedTooEarly.document.definitions.WidgetSuite.properties.color;
  assert.throws(() => verifyVersion006008([removedTooEarly, removedWidget]), /must retain color/);

  const renamedWidget = openApi("2023-06-01-preview", {
    WidgetSuite: {
      type: "object",
      properties: { widgetColor: { type: "string" } },
    },
  });
  verifyVersion006009([oldWidget, renamedWidget]);
  const leakedRename = structuredClone(oldWidget);
  leakedRename.document.definitions.WidgetSuite.properties.widgetColor = {
    type: "string",
  };
  assert.throws(
    () => verifyVersion006009([leakedRename, renamedWidget]),
    /must not expose widgetColor/,
  );
} finally {
  fs.rmSync(examplesRoot, { recursive: true });
}

console.log("Grader contract alternatives passed.");
