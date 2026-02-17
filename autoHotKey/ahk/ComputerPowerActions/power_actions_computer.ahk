#Requires AutoHotkey v2.0
SetTitleMatchMode(2) 

;Shutdown computer with a custom and default timer
;Default timer is 60 seconds, you can change it by changing the value of the variable
;You can also set a custom timer by entering the time in seconds in the input box
;The script will display a message box with the remaining time before shutdown  
;Set default timer in seconds

;::#!s:: to run this script, you can change the hotkey by changing the value of the variable

#Requires AutoHotkey v2.0
SetTitleMatchMode(2)

global countdownGui
global cancelRequested := false
global forceClose := false
global selectedAction := "Shutdown"

; ==============================
; HOTKEY TO START (Win+Alt+S)
; ==============================
#!s::
{
    default_timer := 60

    selectedAction := AskAction()
    if (selectedAction = "")
        return

    timer := AskTimeLag(default_timer)
    if (timer = "")
        return

    StartCountdown(timer)
}

; ==============================
; CANCEL HOTKEY (Win+Alt+C)
; ==============================
#!c::
{
    cancelRequested := true
    if IsSet(countdownGui)
        countdownGui.Destroy()
    SoundBeep(500, 200)
    MsgBox("Shutdown cancelled.")
}

; ==============================
; MODERN ACTION SELECTION GUI
; ==============================
AskAction()
{
    gui := Gui("+AlwaysOnTop")
    gui.Title := "Power Manager"
    gui.SetFont("s10", "Segoe UI")

    gui.AddText("xm", "Choose Action:")
    r1 := gui.AddRadio("vAction Checked", "Shutdown")
    r2 := gui.AddRadio("", "Restart")
    r3 := gui.AddRadio("", "Sleep")

    chk := gui.AddCheckBox("vForceClose", "Force close applications")

    btn := gui.AddButton("Default w80", "OK")

    action := ""
    btn.OnEvent("Click", (*) => (
        gui.Submit(),
        action := gui["Action"].Text,
        forceClose := gui["ForceClose"].Value,
        gui.Destroy()
    ))

    gui.Show("AutoSize Center")
    WinWaitClose(gui)

    return action
}

; ==============================
; TIME INPUT FUNCTION
; ==============================
AskTimeLag(default_timer)
{
    result := InputBox(
        "Enter delay in seconds:`n(Default is " default_timer " seconds)",
        "Set Timer"
    )

    if (result.Result = "Cancel")
        return ""

    if (result.Value = "")
        return default_timer

    if result.Value ~= "^\d+$"
        return result.Value

    MsgBox("Invalid input. Please enter a valid number.")
    return ""
}

; ==============================
; LIVE COUNTDOWN GUI
; ==============================
StartCountdown(seconds)
{
    global countdownGui, cancelRequested

    cancelRequested := false

    countdownGui := Gui("+AlwaysOnTop -SysMenu")
    countdownGui.SetFont("s14 Bold", "Segoe UI")
    countdownGui.BackColor := "202020"

    txt := countdownGui.AddText("cWhite Center w300", "")
    countdownGui.Show("AutoSize Center")

    Loop seconds
    {
        if (cancelRequested)
            return

        remaining := seconds - A_Index + 1
        txt.Value := selectedAction " in " remaining " seconds..."

        if (remaining = 5)
            SoundBeep(1000, 300)

        Sleep(1000)
    }

    countdownGui.Destroy()
    ExecuteAction()
}

; ==============================
; EXECUTE SELECTED ACTION
; ==============================
ExecuteAction()
{
    global selectedAction, forceClose

    flag := forceClose ? " /f" : ""

    if (selectedAction = "Shutdown")
        Run("shutdown /s /t 0" flag)
    else if (selectedAction = "Restart")
        Run("shutdown /r /t 0" flag)
    else if (selectedAction = "Sleep")
        DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
}





