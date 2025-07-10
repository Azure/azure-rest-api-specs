// @ts-check

import { describe, expect, it } from "vitest";
import { ZodError } from "zod/v4";
import { BaseMessageRecordSchema, MessageLevel, MessageLevelSchema } from "../src/message.js";

describe("message", () => {
  it.each([["foo", ZodError], [MessageLevel.Error], [MessageLevel.Info], [MessageLevel.Warning]])(
    "MessageLevelSchema.parse(%o)",
    (input, expectedError) => {
      testSchemaParse(MessageLevelSchema, input, expectedError);
    },
  );

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
  ])("BaseMessageRecordSchema.parse(%o)", (input, expectedError) => {
    testSchemaParse(BaseMessageRecordSchema, input, expectedError);
  });
});

function testSchemaParse(schema, input, expectedError) {
  if (expectedError) {
    expect(() => schema.parse(input)).toThrowError(expectedError);
  } else {
    expect(schema.parse(input)).toEqual(input);
  }
}
