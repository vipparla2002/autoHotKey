#Requires AutoHotkey v2.0
SetTitleMatchMode("2")

!r:: ; Alt+r to run all shortcut scripts at once
{
    Run("C:\ahk\shortcuts\ADOShortcuts.ahk")
    Run("C:\ahk\shortcuts\chatShortcuts.ahk")
    Run("C:\ahk\shortcuts\simulatingMouseClickShortcuts.ahk")
    Run("C:\ahk\shortcuts\cmdShortcuts.ahk")
}

!k:: ; Alt+K to force kill all AHK processes
{ 
    RunWait 'taskkill /IM "ahk.exe" /F', , "Hide"
    RunWait 'taskkill /IM "AutoHotkey64.exe" /F', , "Hide"
}

::yt:: ;youtube
{
    send "youtube.com/"
}

::adoq:: ;Azure Devops new query page
{
    send "https://hurontfs.visualstudio.com/hrs/_queries/query-edit/?newQuery=true&parentId=68d8fbe9-5f3e-4547-b64b-2f69be40082e"
}




