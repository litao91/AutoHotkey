; Launch or toggle program, http://lifehacker.com/5468862/create-a-shortcut-key-for-restoring-a-specific-window
; -----------------------------------------------------------------------------
ToggleWinMinimize(WindowTitle)
{
    SetTitleMatchMode,2
    DetectHiddenWindows, Off
    IfWinActive, %WindowTitle%
    WinMinimize, %WindowTitle%
    Else
    IfWinExist, %WindowTitle%
    {
        WinActivate
    }
    Return
}


RunOrActivateOrMinimizeProgram(Program, WorkingDir="", WindowSize="")
{
    SplitPath Program, ExeFile
    Process, Exist, %ExeFile%
    PID = %ErrorLevel%
    if (PID = 0)
    {
        Run, %Program%, %WorkingDir%, %WindowSize%
    }
    else
    {
        SetTitleMatchMode,2
        DetectHiddenWindows, Off
        IfWinActive, ahk_pid %PID%
        WinMinimize, ahk_pid %PID%
        Else
        IfWinExist, ahk_pid %PID%
        WinActivate, ahk_pid %PID%
        Return
    }
}

ActiveWinTitleFromInput()
{
    InputBox, winTitle
    ToggleWinMinimize(winTitle)
}

ToggleWinMinimizeById(ID)
{
    WinActivate, ahk_id %ID%
}

RegisterWindow(bindKey) {
    WinGet, WinId, ID, A
    MsgBox, %WinId% will be bind to %bindKey%
    key = %bindKey%
    callback := Func("ToggleWinMinimizeById").bind(WinId)
    Hotkey, % key, % callback, On
}

<!h::ToggleWinMinimize("hadoop-main")
<!s::ToggleWinMinimize("spark-parent")
<!e::ToggleWinMinimize("Microsoft Edge")
<!c::ToggleWinMinimize("ConsoleZ")
<!m::RunOrActivateOrMinimizeProgram("mintty.exe")
<!a::ActiveWinTitleFromInput()

#^1::RegisterWindow("#+1")
#^2::RegisterWindow("#+2")
#^3::RegisterWindow("#+3")
#^4::RegisterWindow("#+4")
#^5::RegisterWindow("#+5")

^+1::RegisterWindow("Capslock & 1")
^+2::RegisterWindow("Capslock & 2")
^+3::RegisterWindow("Capslock & 3")
^+4::RegisterWindow("Capslock & 4")
^+5::RegisterWindow("Capslock & 5")
^+6::RegisterWindow("Capslock & 6")
^+7::RegisterWindow("Capslock & 7")
^+8::RegisterWindow("Capslock & 8")
^+9::RegisterWindow("Capslock & 9")

#+1::RegisterWindow("Home & 1")
#+2::RegisterWindow("Home & 2")
#+3::RegisterWindow("Home & 3")
#+4::RegisterWindow("Home & 4")
#+5::RegisterWindow("Home & 5")
#+6::RegisterWindow("Home & 6")
#+7::RegisterWindow("Home & 7")
#+8::RegisterWindow("Home & 8")
#+9::RegisterWindow("Home & 9")
