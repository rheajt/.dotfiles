import { $ } from "bun";

const profiles = {
  PSISJS: {
    browser: "microsoft-edge",
    profile: "Profile 1",
  },
  "Keystone Academy": {
    browser: "microsoft-edge",
    profile: "Default",
  },
  "jordanrhea.com": {
    browser: "google-chrome",
    profile: "Profile 1",
  },
  "rheajt@gmail.com": {
    browser: "google-chrome",
    profile: "Default",
  },
};

const output =
  await $`echo "${Object.keys(profiles).join(",")}" | rofi -dmenu -sep ',' -p "Select browser instance:"`.text();

if (output) {
  const selectedProfile = profiles[output.trim() as keyof typeof profiles];
  await $`${selectedProfile.browser} --profile-directory=${selectedProfile.profile}`.quiet();
}
