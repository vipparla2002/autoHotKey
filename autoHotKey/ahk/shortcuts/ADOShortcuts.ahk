#Requires AutoHotkey v2.0
SetTitleMatchMode("2")

::bgc:: ; bug close
{
    result := InputBox("
    (LTrim
    Choose the closure reason:

    1. Function is working as designed
    2. Module's behavior is consistent
    )", "Bug Closure")

    if result.Result = "Cancel"  ; user pressed Cancel
        return

    choice := result.Value

    if (choice = "1") {
        Send "This bug is closed as the application's function is working as designed after the fix is implemented."
    }
    else if (choice = "2") {
        Send "This bug is closed as this module's behavior is now consistent with the rest of the application after the fix is implemented."
    }
    else {
        Send "[Cancelled: No valid choice entered.]"
    }
}


::bgr:: ;bug remove
{
    send "This bug is removed as it is not reproducible."
}

::usc:: ;User Story close
{
    send "This user story is closed as the application's function satisfies acceptance criteria."
}
