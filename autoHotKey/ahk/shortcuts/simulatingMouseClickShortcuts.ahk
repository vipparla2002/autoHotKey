#Requires AutoHotkey v2.0
SetTitleMatchMode("2")

toggle := false
startTime := 0
stopTime := 0
loopInterval := 250000 ; default value (ms)
clickCount := 0

; GUI Setup
myGui := Gui("+AlwaysOnTop", "AHK Clicker Control")
myGui.Add("Button", "w100 h30 vStartBtn", "Start").OnEvent("Click", StartClicker)
myGui.Add("Button", "w100 h30 vStopBtn Disabled", "Stop").OnEvent("Click", StopClicker)
myGui.Add("Button", "w100 h30", "Kill Script").OnEvent("Click", (*) => ExitApp())
myGui.Add("Text", "vStatusText w220", "Status: Stopped")
myGui.Add("Text", "vElapsedText w220", "Elapsed Time: 0.0 sec")
myGui.Add("Text", "vStartText w220", "Start Time: -")
myGui.Add("Text", "vStopText w220", "Stop Time: -")
myGui.Add("Text", , "Loop Interval (ms):")
myGui.Add("Edit", "vLoopInput w100", loopInterval)
myGui.Add("Text", "vClickCountText w220", "Clicks Made: 0")
myGui.OnEvent("Close", (*) => myGui.Hide()) ; Hide GUI instead of exiting
myGui.Show("AutoSize")

; Tray menu setup
A_TrayMenu.Delete()
A_TrayMenu.Add("Show GUI", ShowGui)
A_TrayMenu.Add("Exit", (*) => ExitApp())
A_TrayMenu.Default := "Show GUI"

; Start Button Handler
StartClicker(*) {
    global toggle, startTime, myGui, loopInterval, clickCount
    toggle := true
    clickCount := 0 ; reset counter
    startTime := A_TickCount
    loopInterval := Integer(myGui["LoopInput"].Text) ; get interval from GUI
    myGui["StartBtn"].Enabled := false
    myGui["StopBtn"].Enabled := true
    myGui["StatusText"].Text := "Status: Running"
    myGui["StartText"].Text := "Start Time: " FormatTime(A_Now)
    myGui["StopText"].Text := "Stop Time: -"
    myGui["ClickCountText"].Text := "Clicks Made: 0"
    SetTimer(ClickLoop, loopInterval)
    SetTimer(UpdateElapsed, 200)
}

; Stop Button Handler
StopClicker(*) {
    global toggle, stopTime, myGui
    toggle := false
    stopTime := A_TickCount
    myGui["StartBtn"].Enabled := true
    myGui["StopBtn"].Enabled := false
    myGui["StatusText"].Text := "Status: Stopped"
    myGui["StopText"].Text := "Stop Time: " FormatTime(A_Now)
    SetTimer(ClickLoop, 0)
    SetTimer(UpdateElapsed, 0)
}

; Main clicking loop
ClickLoop() {
    global clickCount, myGui
    if WinExist("Microsoft Teams") {
        WinActivate()
        Click(500, 300)
        clickCount++
        myGui["ClickCountText"].Text := "Clicks Made: " clickCount
    }
}

; Timer to update elapsed time
UpdateElapsed() {
    global toggle, startTime, myGui
    if toggle {
        elapsed := (A_TickCount - startTime) / 1000
        myGui["ElapsedText"].Text := "Elapsed Time: " Round(elapsed, 1) " sec"
    }
}

; Format A_Now to HH:MM:SS
FormatTime(ts) {
    return Format("{:02}:{:02}:{:02}"
        , SubStr(ts, 9, 2)
        , SubStr(ts, 11, 2)
        , SubStr(ts, 13, 2))
}

; F8 toggles start/stop
F8:: {
    global toggle
    if !toggle {
        StartClicker()
    } else {
        StopClicker()
    }
}

; Ctrl+Shift+G shows GUI
^+g::myGui.Show()

; Tray menu handler
ShowGui(*) {
    myGui.Show()
}
