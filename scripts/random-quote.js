import fs from "fs";

function getQuote() {
  const quotes = fs
    .readFileSync(__dirname + "/quotes", "UTF-8")
    .split("\n")
    .filter((ln) => ln !== "");
  const random = Math.floor(Math.random() * quotes.length);
  console.log(quotes[random]);
}

getQuote();
