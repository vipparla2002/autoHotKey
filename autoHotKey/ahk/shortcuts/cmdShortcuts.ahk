#Requires AutoHotkey v2.0
SetTitleMatchMode("2")

::tkc:: ;task kill chrome
{
    Run "taskkill /F /IM chrome.exe /T"
}

::tkcd:: ;task kill chromedriver
{
    Run "taskkill /F /IM chromedriver.exe /T"
}
