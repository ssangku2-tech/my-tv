' PC TV: opens the 'My TV' screen window on this PC. The phone app's "PC screen" button sends a
' channel here (through ntfy.sh), and this window shows it full size with the English captions.
' Double-click to start. Keep it open (it can sit behind other windows; minimised it may not play).
' CODE: the same pairing code as the radio app's PC speaker (the dashboard's ntfy channel name).
CODE = "PUT-YOUR-CODE-HERE"
Set sh = CreateObject("WScript.Shell")
' Already open? Then don't open a second window.
Set wmi = GetObject("winmgmts:\\.\root\cimv2")
For Each p In wmi.ExecQuery("SELECT CommandLine FROM Win32_Process WHERE Name = 'msedge.exe'")
  If Not IsNull(p.CommandLine) Then
    If InStr(p.CommandLine, "my-tv-pc-screen") > 0 Then WScript.Quit
  End If
Next
edge = sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\Microsoft\Edge\Application\msedge.exe"
prof = sh.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\my-tv-pc-screen"
' Own profile + autoplay switch: sound may start without a click. The occlusion switches keep the
' window playing while the PC is locked or another window covers it.
sh.Run """" & edge & """ --user-data-dir=""" & prof & """ --autoplay-policy=no-user-gesture-required" & _
       " --disable-features=CalculateNativeWinOcclusion --disable-backgrounding-occluded-windows" & _
       " --disable-renderer-backgrounding --disable-background-media-suspend" & _
       " --no-first-run --start-maximized --app=https://ssangku2-tech.github.io/my-tv/?screen#" & CODE, 3, False
