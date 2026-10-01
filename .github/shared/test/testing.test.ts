import { d } from "@azure-tools/specs-shared/testing";
import { d as textD } from "@azure-tools/specs-shared/text";
import { expect, it } from "vitest";

it("keeps the existing testing import compatible with the text helper", () => {
  expect(d).toBe(textD);
});
