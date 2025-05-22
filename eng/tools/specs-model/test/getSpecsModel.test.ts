import { expect, test } from "vitest";
import { getSpecsModel } from "../src/getSpecsModel.js";

test("example getSpecsModel test", async () => {
  const output = await getSpecsModel("foo_path");
  expect(output).toEqual("stub getSpecsModel. path: foo_path");
});
