// import { strictEqual  } from "assert"
// import path from "path";
// import { main } from "../src/index.js";
import { GitDiffRule } from "../src/rules/git-diff.js";
import { TsvTestHost } from "./tsv-test-host.js";
import {expect} from 'chai';

describe('Compile', function () {
  describe('#Compile', function () {
    it('Should fail if project cannot compile.', async function () {
        process.chdir("test")
        console.log(process.cwd())
        process.argv = ["npx", "tsv", "specification/compile/Compile"]
        // await main()
    });
  });
  describe('#GitDiff', function () {
    it ('Should fail if git diff produces output.', async function () {
      let gitDiffRule = new GitDiffRule();
      const result = await gitDiffRule.execute("mockFolder", TsvTestHost);
      expect(result.errorOutput).to.exist;
      expect(result.errorOutput).be.not.empty;
    })
  })
});