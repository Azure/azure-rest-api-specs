#!/usr/bin/env node
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { simpleGit } from 'simple-git';
import { exec } from "child_process";
function runCmd(cmd) {
    return __awaiter(this, void 0, void 0, function* () {
        console.log(`run command:${cmd}`);
        const { err, stdout, stderr } = yield new Promise((res) => exec(cmd, { encoding: "utf8", maxBuffer: 1024 * 1024 * 64 }, (err, stdout, stderr) => res({ err: err, stdout: stdout, stderr: stderr })));
        let resultString = stderr + stdout;
        console.log("Stdout output:");
        console.log(stdout);
        if (stderr) {
            console.log("Stderr output:");
            console.log(stderr);
        }
        if (stderr || err) {
            throw new Error(err);
        }
        return resultString;
    });
}
function main() {
    return __awaiter(this, void 0, void 0, function* () {
        const args = process.argv.slice(2);
        const folder = args[0];
        console.log("Running TypeSpecValidation on folder:", folder);
        const output = yield runCmd(`npx tsp compile ${folder}`);
        const git = simpleGit();
        let gitStatusIsClean = yield (yield git.status(['--porcelain'])).isClean();
        if (!gitStatusIsClean) {
            let gitStatus = yield git.status();
            let gitDiff = yield git.diff();
            console.log("git status");
            console.log(gitStatus);
            console.log("git diff");
            console.log(gitDiff);
            throw new Error("Generated swagger file does not match swagger file on disk");
        }
    });
}
main();
