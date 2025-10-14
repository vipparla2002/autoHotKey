#Requires AutoHotkey v2.0
SetTitleMatchMode("2")

TrayTip("AutoHotKey","Parent AutoHotKey activated",3)

!r:: ; Alt+r to run other AutoHotKeys
{
    TrayTip("AutoHotkey","Running other AutoHotKeys",3)
    Run("C:\ahk\shortcuts\ADOShortcuts.ahk")
    Run("C:\ahk\shortcuts\chatShortcuts.ahk")
    Run("C:\ahk\shortcuts\simulatingMouseClickShortcuts.ahk")
    Run("C:\ahk\shortcuts\cmdShortcuts.ahk")

}

!k:: ; Alt+K to force kill all AHK processes
{ 
    RunWait 'taskkill /IM "ahk.exe" /F', , "Hide"
    RunWait 'taskkill /IM "AutoHotkey64.exe" /F', , "Hide"
    TrayTip("AutoHotKey","Kiled all AutoHotKeys",3)
}

::yt:: ;youtube
{
    send "youtube.com/"
}

::adoq:: ;Azure Devops new query page
{
    send "https://hurontfs.visualstudio.com/hrs/_queries/query-edit/?newQuery=true&parentId=68d8fbe9-5f3e-4547-b64b-2f69be40082e"
}




