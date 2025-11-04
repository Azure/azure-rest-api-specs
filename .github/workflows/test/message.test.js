import { describe, expect, it } from "vitest";
import { ZodError } from "zod";
import {
  BaseMessageRecordSchema,
  MessageLevel,
  MessageLevelSchema,
  MessageRecordSchema,
  MessageType,
  generateMarkdownTable,
} from "../src/message.js";

function testSchemaParse(schema, input, expectedError) {
  if (expectedError) {
    expect(() => schema.parse(input)).toThrowError(expectedError);
  } else {
    expect(schema.parse(input)).toEqual(input);
  }
}

describe("MessageLevelSchema", () => {
  it.each([["foo", ZodError], [MessageLevel.Error], [MessageLevel.Info], [MessageLevel.Warning]])(
    "parse(%o)",
    (input, expectedError) => {
      testSchemaParse(MessageLevelSchema, input, expectedError);
    },
  );
});

describe("BaseMessageRecordSchema", () => {
  it.each([
    [{}, ZodError],
    [{ level: "foo", message: 1, time: "bar" }, ZodError],
    [{ level: MessageLevel.Error, message: "test-message", time: new Date().toISOString() }],
    [
      {
        level: MessageLevel.Warning,
        message: "test-message",
        time: new Date().toISOString(),
        context: { toolVersion: "1.0" },
        group: "test-group",
        extra: { extraKey: "extraVal" },
        groupName: "test-group-name",
      },
    ],
  ])("parse(%o)", (input, expectedError) => {
    testSchemaParse(BaseMessageRecordSchema, input, expectedError);
  });
});

describe("MessageRecordSchema", () => {
  it.each([
    [{}, ZodError],
    [
      {
        type: "Result",
        level: MessageLevel.Error,
        message: "test-message",
        time: new Date().toISOString(),
        // Missing required field "paths"
      },
      ZodError,
    ],
    [
      {
        type: "Raw",
        level: MessageLevel.Error,
        message: "test-message",
        time: new Date().toISOString(),
      },
    ],
    [
      {
        type: "Raw",
        level: MessageLevel.Warning,
        message: "test-message",
        time: new Date().toISOString(),
        context: { toolVersion: "1.0" },
        group: "test-group",
        extra: { extraKey: "extraVal" },
        groupName: "test-group-name",
      },
    ],
    [
      {
        type: "Result",
        level: MessageLevel.Warning,
        message: "test-message",
        time: new Date().toISOString(),
        context: { toolVersion: "1.0" },
        group: "test-group",
        extra: { extraKey: "extraVal" },
        groupName: "test-group-name",
        id: "test-id",
        code: "test-code",
        docUrl: "test-url",
        paths: [
          { tag: "tag1", path: "path1", jsonPath: "jsonPath1" },
          { tag: "tag2", path: "path2" },
        ],
      },
    ],
  ])("parse(%o)", (input, expectedError) => {
    testSchemaParse(MessageRecordSchema, input, expectedError);
  });
});

describe("generateMarkdownTable", () => {
  it("no messages", () => {
    const messages = [];

    expect(generateMarkdownTable(messages)).toMatchInlineSnapshot(`
      "| Rule | Message |
      | ---- | ------- |"
    `);
  });

  it("all message types", () => {
    /** @type {import("../src/message.js").MessageRecord[]} */
    const messages = [];

    /** @type {import("../src/message.js").ResultMessageRecord} */
    const resultMessageRecord = {
      type: MessageType.Result,
      level: MessageLevel.Error,
      code: "NO_JSON_FILE_FOUND",
      message: "The JSON file is not found but it is referenced from the readme file.",
      docUrl: "https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND",
      time: "2025-07-11T00:01:00.418Z",
      paths: [
        {
          tag: "readme",
          path: "https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/readme.md",
        },
        {
          tag: "json",
          path: "https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json",
        },
      ],
    };

    messages.push(resultMessageRecord);
    messages.push({ ...messages[0], level: MessageLevel.Info });
    messages.push({ ...messages[0], level: MessageLevel.Warning });

    // URL with "path="
    messages.push({
      ...resultMessageRecord,
      paths: [
        {
          tag: resultMessageRecord.paths[0].tag,
          path:
            "https://www.example.org?path=" + encodeURIComponent(resultMessageRecord.paths[0].path),
        },
      ],
    });

    // Empty path
    messages.push({
      ...resultMessageRecord,
      paths: [
        {
          tag: resultMessageRecord.paths[0].tag,
          path: "",
        },
      ],
    });

    // No paths
    messages.push({
      ...resultMessageRecord,
      paths: [],
    });

    /** @type {import("../src/message.js").RawMessageRecord} */
    const rawMessageRecord = {
      type: MessageType.Raw,
      level: MessageLevel.Error,
      message: "Test raw message",
      time: "2025-07-11T00:01:00.418Z",
      extra: {
        key1: "value1",
        key2: "value2",
      },
    };

    messages.push(rawMessageRecord);

    messages.push({ ...rawMessageRecord, extra: undefined });

    expect(generateMarkdownTable(messages)).toMatchInlineSnapshot(`
      "| Rule                                                                                               | Message                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
      | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
      | ❌ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND)  | The JSON file is not found but it is referenced from the readme file.<br>readme: [specification/contosowidgetmanager/resource-manager/readme.md](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/readme.md)<br>json: [Microsoft.Contoso/stable/2021-11-01/contoso2.json](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json) |
      | ℹ️ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND) | The JSON file is not found but it is referenced from the readme file.<br>readme: [specification/contosowidgetmanager/resource-manager/readme.md](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/readme.md)<br>json: [Microsoft.Contoso/stable/2021-11-01/contoso2.json](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json) |
      | ⚠️ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND) | The JSON file is not found but it is referenced from the readme file.<br>readme: [specification/contosowidgetmanager/resource-manager/readme.md](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/readme.md)<br>json: [Microsoft.Contoso/stable/2021-11-01/contoso2.json](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json) |
      | ❌ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND)  | The JSON file is not found but it is referenced from the readme file.<br>readme: [specification/contosowidgetmanager/resource-manager/readme.md](https://www.example.org?path=https%3A%2F%2Fgithub.com%2Fmikeharder%2Fazure-rest-api-specs%2Fblob%2F4e6083f35e27d8e1e3b78222cf4bd27b87cd1409%2Fspecification%2Fcontosowidgetmanager%2Fresource-manager%2Freadme.md)                                                                                                                                                                                                                   |
      | ❌ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND)  | The JSON file is not found but it is referenced from the readme file.<br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | ❌ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND)  | The JSON file is not found but it is referenced from the readme file.<br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | ❌ Test raw message                                                                                 | "key1":"value1",<br>"key2":"value2"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | ❌ Test raw message                                                                                 |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |"
    `);
  });
});
