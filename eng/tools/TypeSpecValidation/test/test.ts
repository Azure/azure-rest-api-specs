import { GitDiffRule } from "../src/rules/git-diff.js";
import { TsvTestHost } from "./tsv-test-host.js";
import {expect} from 'chai';

describe('TSV Unit Tests', function () {
  describe('#Compile', function () {
    it('Should fail if project cannot compile.', async function () {
        // TODO: Compile rule unit test
    });
  });
  describe('#FolderStructure', function () {
    it ('Should fail if directory name does not conform.', async function () {
      // TODO: Folder structure rule unit test
    })
  })
  describe('#GitDiff', function () {
    it ('Should fail if git diff produces output.', async function () {
      let gitDiffRule = new GitDiffRule();
      const result = await gitDiffRule.execute("mockFolder", TsvTestHost);
      expect(result.errorOutput).to.exist;
      expect(result.errorOutput).be.not.empty;
    })
  });
});
