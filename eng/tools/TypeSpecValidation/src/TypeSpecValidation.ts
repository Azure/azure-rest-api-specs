#!/usr/bin/env node

import {simpleGit} from 'simple-git';
import { exec } from "child_process";

async function runCmd(cmd:string) {
    console.log(`run command:${cmd}`)
    const { err, stdout, stderr } = await new Promise((res) =>
        exec(
        cmd,
        { encoding: "utf8", maxBuffer: 1024 * 1024 * 64 },
        (err: unknown, stdout: unknown, stderr: unknown) =>
            res({ err: err, stdout: stdout, stderr: stderr })
        )
    ) as any;
    let resultString = stderr + stdout;
    console.log("Stdout output:")
    console.log(stdout)
    if (stderr) {
        console.log("Stderr output:")
        console.log(stderr)
    }
    if (stderr || err) {
        throw new Error(err);
    }
    return resultString as string;
}
    
async function main() {
    const args = process.argv.slice(2);
    const folder = args[0];
    console.log("Running TypeSpecValidation on folder:", folder);
    const output = await runCmd(
        `npx tsp compile ${folder}`
    );

    const git = simpleGit();
    let gitStatusIsClean = await (await git.status(['--porcelain'])).isClean()
    if (!gitStatusIsClean) {
        let gitStatus = await git.status()
        let gitDiff = await git.diff()
        console.log("git status")
        console.log(gitStatus)
        console.log("git diff")
        console.log(gitDiff)
        throw new Error("Generated swagger file does not match swagger file on disk")
    }
}

main();
