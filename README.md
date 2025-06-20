<p align="center">
	<a href="https://discord.gg/sH5Mh2XfPC"><img src=".assets/icon.ico" alt="Imperium" height="90" /></a>
</p>

<h4 align="center">MY VENCORD PLUGINS | THEMES</h4>
<p align="center">
	V1.0.9
</p>

<p align="center">
  <a href="#-important">IMPORTANT</a> •
	<a href="#-faq">FAQ</a> •
	<a href="https://discord.gg/sH5Mh2XfPC">Discord server</a>
</p>
<br/>

## • IMPORTANT

**_1. Discord themes or plugins doesn't work._**
> If you have installed the theme and it is not working this may be caused by our themes and plugins being `updated` or you may also have your discord `patched`.

**_2. My discord has frozen and won't open... This is because your discord has been updated and patched Vencord._**
> To fix it open `VencordInstaller.exe` or `VencordInstallerCli.exe` and select the "Repair Vencord" option.


## • FAQ

**Q: I want to `Ctrl + Shift + I` but it doesn't work.**

A: Press <kbd>Win</kbd> + <kbd>R</kbd>, Type `%appdata%\discord`... Look for the `settings.json` file and open it in notepad.
At the top of the file, under the open curly brace you need to add `"DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,`

So you file should be

```js
{
  "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
  "IS_MAXIMIZED": false,
  "IS_MINIMIZED": false,
}
```

After that, save the file, open your task manager... <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Escape</kbd> and close Discord.
Open Discord again and you should now be able to press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd>.
