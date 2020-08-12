#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const tao = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'taoteching.json')));
const verse = tao[Math.floor(Math.random() * tao.length)].chap;
const s = `${verse.chapterNum}: ${verse.verse}`;
console.log(s);
