import crypto from "crypto";

const len = +process.argv.pop() || 40;
crypto.randomBytes(len, function (err, buffer) {
  const token = buffer.toString("hex");
  console.log(token);
  return token;
});
